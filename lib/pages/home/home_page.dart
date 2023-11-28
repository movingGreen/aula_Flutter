import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prog_app/models/produtc/product.dart';
import 'package:prog_app/models/produtc/product_services.dart';
import 'package:prog_app/pages/cart/cart_page.dart';
import 'package:prog_app/pages/product/product_detail_page.dart';
import 'package:prog_app/services/cart/cart_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductServices productServices = ProductServices();
    return Scaffold(
      body: FutureBuilder(
        future: productServices.getDocs(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 30.0,
                top: 30,
                left: 20,
                right: 20,
              ),
              child: Center(
                child: GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 0.70),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Product product = Product();
                          product.id = snapshot.data!.docs[index].id;
                          product.name = snapshot.data!.docs[index].get('name');
                          product.brand =
                              snapshot.data!.docs[index].get('brand');
                          product.description =
                              snapshot.data!.docs[index].get('description');
                          product.price = double.parse(snapshot
                              .data!.docs[index]
                              .get('price')
                              .toString());
                          product.image =
                              snapshot.data!.docs[index].get('image');

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(product: product)));
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  docSnap[index].get('image'),
                                  height: 150,
                                  width: 150,
                                  scale: 1,
                                ),
                                Text(docSnap[index].get('name')),
                                Text(
                                  'R\$ ${docSnap[index].get('price').toString()}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      );
                    }),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
