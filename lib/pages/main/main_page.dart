import 'package:flutter/material.dart';
import 'package:prog_app/pages/cart/cart_page.dart';
import 'package:prog_app/pages/galeria/galeria_page.dart';
import 'package:prog_app/pages/home/home_page.dart';
import 'package:prog_app/pages/rastreamento/rastreamento_page.dart';
import 'package:prog_app/pages/userprofile/user_profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 2.0,
        title: const Text("Loja"),
      ),
      body: [
        HomePage(),
        // GaleriaPage(),
        CartPage(),
        const Center(
          child: RastreamentoPage(),
        ),
        const Center(
          child: UserProfilePage(),
        ),
      ][_index],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (int position) {
            setState(() {
              _index = position;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            // NavigationDestination(
            //   icon: Icon(Icons.line_style_outlined),
            //   label: 'Galeria',
            // ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Carrinho',
            ),
            NavigationDestination(
              icon: Icon(Icons.map_outlined),
              label: 'Rastreamento',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_box_outlined),
              label: 'Perfil de Usuário',
            )
          ]),
    );
  }
}
