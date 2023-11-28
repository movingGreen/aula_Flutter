import 'package:flutter/material.dart';
import 'package:prog_app/commons/count_controller.dart';
import 'package:prog_app/commons/customized_elevated_button.dart';
import 'package:prog_app/models/cart/cart_item.dart';
import 'package:prog_app/pages/cart/cart_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prog_app/models/produtc/product.dart';
import 'package:prog_app/pages/cart/cart_page.dart';
import 'package:prog_app/services/cart/cart_service.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({required this.product, super.key});
  Product product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int? countControllerValue = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Detalhes do produto"),
        actions: [
          Consumer<CartService>(
            builder: (context, cartService, child) {
              return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 24, 0),
                child: GestureDetector(
                  onTap: () {
                    if (cartService.items.isNotEmpty) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CartPage(),
                      ));
                    }
                  },
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        size: 36,
                      ),
                      if (cartService.items.isNotEmpty)
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 4.0, bottom: 8.0),
                          child: CircleAvatar(
                            radius: 8.0,
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            child: Text(
                              cartService.items.length.toString(),
                              style: const TextStyle(fontSize: 12.0),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: constraints.maxWidth > 700
                    ? EdgeInsets.only(
                        top: 30.0,
                        left: MediaQuery.of(context).size.width * .1,
                        right: MediaQuery.of(context).size.width * .1)
                    : const EdgeInsets.only(top: 15.0, left: 40, right: 40),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 30, left: 15, right: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.black12, //
                      )),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.product.image!,
                          height: constraints.maxWidth > 1100
                              ? 500
                              : constraints.maxWidth > 800
                                  ? 300
                                  : 200,
                          width: constraints.maxWidth > 1100
                              ? 500
                              : constraints.maxWidth > 800
                                  ? 300
                                  : 200,
                          fit: BoxFit.contain,
                          isAntiAlias: true,
                          // filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.product.name!,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.lexendDeca(
                          color: const Color(0xFF151B1E),
                          fontSize: constraints.maxWidth > 700 ? 25 : 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'R\$ ${widget.product.price.toString()}',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.lexendDeca(
                          color: const Color(0xFF151B1E),
                          fontSize: constraints.maxWidth > 700 ? 25 : 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informações do Produto:',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.lexendDeca(
                              color: const Color(0xFF151B1E),
                              fontSize: constraints.maxWidth > 700 ? 25 : 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            widget.product.description!,
                            style: GoogleFonts.lexendDeca(
                              color: const Color(0xFF151B1E),
                              fontSize: constraints.maxWidth > 700 ? 25 : 20,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CountController(
                                decrementIconBuilder: (enabled) => Icon(
                                  Icons.remove_circle_outline,
                                  size: constraints.maxWidth > 700 ? 30 : 25,
                                  color: enabled
                                      ? Theme.of(context).primaryColorDark
                                      : Theme.of(context).primaryColorLight,
                                ),
                                incrementIconBuilder: (enabled) => Icon(
                                  Icons.add_circle_outline,
                                  size: constraints.maxWidth > 700 ? 30 : 25,
                                  color: enabled
                                      ? Theme.of(context).primaryColorDark
                                      : Theme.of(context).primaryColorLight,
                                ),
                                countBuilder: (count) => Text(
                                  count.toString(),
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                count: countControllerValue ?? 1,
                                min: 1,
                                updateCount: (count) => setState(
                                  () => countControllerValue = count,
                                ),
                              ),
                              CustomizedElevatedButton(
                                  icon: const Icon(Icons.shopping_cart),
                                  text: 'Adicionar no Carrinho',
                                  onPressed: () {
                                    Product product = widget.product;
                                    product.quantity = countControllerValue;

                                    CartItem cartItem = CartItem(
                                        name: product.name,
                                        price: product.price,
                                        lat: product.lat,
                                        long: product.long);
                                    context
                                        .read<CartService>()
                                        .addToCart(cartItem);
                                  },
                                  options: ButtonOptions(
                                      width: constraints.maxWidth > 1100
                                          ? 350
                                          : constraints.maxWidth > 800
                                              ? 250
                                              : 240,
                                      height: constraints.maxWidth > 1100
                                          ? 55
                                          : constraints.maxWidth > 800
                                              ? 50
                                              : 48,
                                      color: Theme.of(context).primaryColor,
                                      textStyle: GoogleFonts.poppins(
                                          fontSize: constraints.maxWidth > 1100
                                              ? 28
                                              : constraints.maxWidth > 800
                                                  ? 25
                                                  : 20,
                                          color: Colors.white)))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
