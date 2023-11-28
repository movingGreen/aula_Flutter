import 'package:flutter/material.dart';
import 'package:prog_app/pages/home/home_page.dart';
import 'package:prog_app/pages/product/product_add_page.dart';
import 'package:prog_app/pages/product/product_list_page.dart';
import 'package:prog_app/pages/rastreamento/rastreamento_page.dart';
import 'package:prog_app/pages/userprofile/user_profile_page.dart';
import 'package:prog_app/services/users/users_services.dart';
import 'package:provider/provider.dart';

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
        const Center(
          // child: HomePage(),
          child: Text('home page'),
        ),
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Carrinho de Compras'),
            ],
          ),
        ),
        Center(
          child: Container(
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Pedidos'),
              ],
            ),
          ),
        ),
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
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Carrinho',
            ),
            NavigationDestination(
              icon: Icon(Icons.line_style_outlined),
              label: 'Pedidos',
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
      drawer: Consumer<UsersServices>(
        builder: (context, usersServices, child) {
          return Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ClipOval(
                          child: Image.network(
                            usersServices.users!.image!,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(usersServices.users!.userName!.toUpperCase()),
                      Text(usersServices.users!.email!.toLowerCase()),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const ListTile(
                      title: Text('Pedidos'),
                    ),
                    const ListTile(
                      title: Text('Carrinho de Compras'),
                    ),
                    const Divider(
                      height: 2,
                    ),
                    ListTile(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const UserProfileList(),
                        //   ),
                        // );
                      },
                      title: const Text('Relatório de usuários'),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserProfilePage(),
                          ),
                        );
                      },
                      title: const Text('Perfil de usuário'),
                    ),
                    ExpansionTile(
                      title: const Text("Gerenciamento de Produtos"),
                      leading: const Icon(Icons.person), //add icon
                      childrenPadding:
                          const EdgeInsets.only(left: 60), //children padding
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductAddPage(),
                              ),
                            );
                          },
                          title: const Text('Cadastro de Produtos'),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductListPage(),
                              ),
                            );
                          },
                          title: const Text('Listagem de Produtos'),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
