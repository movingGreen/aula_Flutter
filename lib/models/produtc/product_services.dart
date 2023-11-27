import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:prog_app/models/produtc/product.dart';
import 'package:uuid/uuid.dart';

class ProductServices {
  //instância para persistência dos dados no Firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //instância para upload de mídias (imagens, vídeos, pdf) para o Firebase
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Product? product;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('products');
  DocumentReference get _firestoreRef =>
      _firestore.doc('products/${product!.id}');
  Reference get _storageRef =>
      _storage.ref().child('products').child('${product!.id}');

  Future<bool> save(Product product, dynamic imageFile, bool plat) async {
    try {
      final doc = await _collectionRef.add(product.toMap());
      this.product = product;
      this.product!.id = doc.id;

      _uploadImage(imageFile, plat);
      return Future.value(true);
    } on FirebaseException catch (e) {
      debugPrint(e.code.toString());
      return Future.value(false);
    }
  }

  Future<void> update(Product product) async {
    await _collectionRef.doc(product.id).update(
          // {"name": product.name, "price": product.price},
          product.toMap(),
        );
  }

  Future<Product?> getProductById(String? id) async {
    final docProduct = _firestore.collection('products').doc(id);
    final snapShot = await docProduct.get();
    if (snapShot.exists) {
      return Product.fromDocument(snapShot);
    } else {
      return null;
    }
  }

  Stream<QuerySnapshot> getAllProducts() {
    return _collectionRef.snapshots();
  }

  Future<List<Product>> getProducts() async {
    List<Product> listProducts = [];
    final result = await _collectionRef.get();
    listProducts = result.docs.map((e) => Product.fromSnapshot(e)).toList();
    return listProducts;
  }

  _uploadImage(dynamic imageFile, bool plat) async {
    //chave para persistir a imagem no firebasestorage
    final uuid = const Uuid().v1();
    try {
      Reference storageRef =
          _storage.ref().child('products').child(product!.id!);
      //objeto para realizar o upload da imagem
      UploadTask task;
      if (!plat) {
        task = storageRef.child(uuid).putFile(
              imageFile,
              SettableMetadata(
                contentType: 'image/jpg',
                customMetadata: {
                  'product name': product!.name!,
                  'description': 'Informação de arquivo',
                  'imageName': imageFile
                },
              ),
            );
      } else {
        task = storageRef.child(uuid).putData(
              imageFile,
              SettableMetadata(contentType: 'image/jpg', customMetadata: {
                'product name': product!.name!,
                'description': 'Informação de arquivo',
                // 'imageName': File(imageFile).
              }),
            );
      }
      //procedimento para persistir a imagem no banco de dados firebase
      String url = await (await task.whenComplete(() {})).ref.getDownloadURL();
      DocumentReference docRef = _collectionRef.doc(product!.id);
      await docRef.update({
        'id': product!.id,
        'image': url,
      });
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao gravar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Inclusão de dados abortada');
      }
      return Future.value(false);
    }
  }

  Future<bool> delete() {
    try {
      _firestoreRef.update({'deleted': true});
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.value(false);
    }
  }

  Future<QuerySnapshot> getDocs() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      // debugPrint(a.id);
    }
    return querySnapshot;
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    debugPrint(allData.toString());
  }

  Future<List<DocumentSnapshot>> getProductByName(String name) => _collectionRef
      .orderBy('name')
      .startAt([name.toLowerCase()])
      .endAt([
        '${name.toLowerCase()}\uf8ff'
      ]) //.endAt([name.toLowerCase() + '\uf8ff'])
      .get()
      .then((snapshot) {
        return snapshot.docs;
      });

  Future<List<DocumentSnapshot>> getProductByName2(String name) async {
    try {
      var result = _collectionRef
          .where('name', isGreaterThanOrEqualTo: name)
          .where('name', isLessThan: '${name}z')
          .get()
          .then((value) {
        return value.docs;
      }); //.where('name', isLessThan: name +'z').snapshots(); //
      return Future.value(result);
    } on FirebaseException catch (e) {
      return Future.value(null);
    }
  }
}
