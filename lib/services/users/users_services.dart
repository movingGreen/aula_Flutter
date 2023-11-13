import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prog_app/models/users/users.dart';
import 'package:geolocator/geolocator.dart';

class UsersServices extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Users users = Users();

  UsersServices() {
    _loadingCurrentUser;
  }

  DocumentReference get _firetoreRef => _firestore.doc('users/${users.id}');

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  //Método para registrar o usuário no firebase console
  Future<bool> signUp(
      {String? email,
      String? password,
      String? userName,
      String? phone,
      String? social,
      String? birthday}) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
              email: email!, password: password!))
          .user;

      users.id = user!.uid;
      users.email = email;
      users.userName = userName;
      users.phone = phone;
      users.social = social;
      users.birthday = birthday;
      saveUserDetails();

      return Future.value(true);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        debugPrint('Email informado é inválido');
      } else if (error.code == 'weak-password') {
        debugPrint('A senha precisa ter no mínimo 6 caracteres');
      } else if (error.code == 'email-already-in-use') {
        debugPrint('Já existe cadastro com este email!!');
      } else {
        debugPrint("Algum erro aconteceu na Plataforma do Firebase");
      }
      return Future.value(false);
    }
  }

  //Método para autenticação de usuário
  Future<bool> signIn(
      {String? email,
      String? password,
      Function? onSucess,
      Function? onFail}) async {
    try {
      User? user = (await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      ))
          .user;

      _loadingCurrentUser(user: user);
      onSucess!();
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      String code;
      if (e.code == 'invalid-email') {
        code = 'Email informado é inválido';
      } else if (e.code == 'wrong-password') {
        code = 'A senha informada está errada';
      } else if (e.code == 'user-disabled') {
        code = 'Já existe cadastro com este email!!';
      } else {
        code = "Algum erro aconteceu na Plataforma do Firebase";
      }
      onFail!(code);
      return Future.value(false);
    }
  }

  saveUserDetails() async {
    await _firetoreRef.set(users.toJson());
  }

  updateUserDetails(Users users) async {
    try {
      await _firetoreRef.collection('users').doc(users.id).set(users.toJson());
    } on FirebaseException catch (e) {}
  }

  Future<Users> getUser() async {
    debugPrint('getUser ${users.userName}');
    notifyListeners();
    return Future.value(users);
  }

  Future<void> _loadingCurrentUser({User? user}) async {
    //se firebaseUser for nulo ele vai pegar o usuário lá no firebase
    final User? currentUser = user ?? _auth.currentUser;
    debugPrint("USUÁRIO ATUAL -->>> $currentUser");
    if (currentUser != null && !currentUser.isAnonymous) {
      final DocumentSnapshot docUser =
          await _firestore.collection('users').doc(currentUser.uid).get();
      users = Users.fromJson(docUser);
      notifyListeners();
    } else {
      users = Users(
        email: "alberto_sales@email.com",
        id: currentUser?.uid,
        userName: "anonnimous",
      );

      debugPrint("USUÁRIO LOGADO COMO ANÔNIMO!!!! -->>> ${users.userName}");
    }
  }
}
