import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prog_app/commons/responsive.dart';
import 'package:prog_app/models/produtc/product.dart';
import 'package:prog_app/models/produtc/product_services.dart';
import 'package:prog_app/pages/product/product_detail_page.dart';

class HomePageStream extends StatelessWidget {
  const HomePageStream({super.key});

  @override
  Widget build(BuildContext context) {
    ProductServices productServices = ProductServices();
    return Scaffold(
      body: StreamBuilder(
        stream: productServices.getAllProducts(),
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
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    crossAxisCount: Responsive.isDesktop(context) ? 4 : 3,
                    childAspectRatio: .5,
                    mainAxisExtent: Responsive.isDesktop(context)
                        ? MediaQuery.of(context).size.height * .5
                        : MediaQuery.of(context).size.height * .3,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Product product = Product();
                        product.id = snapshot.data!.docs[index].id;
                        product.name = snapshot.data!.docs[index].get('name');
                        product.brand = snapshot.data!.docs[index].get('brand');
                        product.description =
                            snapshot.data!.docs[index].get('description');
                        product.price = double.parse(
                            snapshot.data!.docs[index].get('price').toString());
                        product.image = snapshot.data!.docs[index].get('image');

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: product)));
                      },
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              docSnap[index].get('image'),
                              height: Responsive.isDesktop(context)
                                  ? MediaQuery.of(context).size.height * .3
                                  : MediaQuery.of(context).size.height * .2,
                              width: Responsive.isDesktop(context)
                                  ? MediaQuery.of(context).size.height * .3
                                  : MediaQuery.of(context).size.height * .2,
                              scale: 1,
                            ),
                            Text(docSnap[index].get('name')),
                            Text(
                              'R\$ ${docSnap[index].get('price').toString()}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                    );
                  }),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
