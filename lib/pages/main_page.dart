import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0; // variável utilizada para controlar o índice do navigationBar
  final List <Widget> _pages = [
    Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: const Text("Home", style: TextStyle(color: Colors.white),) ,
    ),
    Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: const Text("Pedidos"),
    ),
    Container(
      color: Colors.green,
      alignment: Alignment.center,
      child: const Text("Perfil de Usuários"),
    ),
    Container(
      color: Colors.red,
      alignment: Alignment.center,
      child: const Text("Configurações"),
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold( // fornece a estrutura básica para a construção de uma pagina
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.list),
        //  onPressed: (){
        //   showDialog(
        //     context: context, 
        //     builder: (BuildContext context) {
        //       return const AlertDialog(
        //         title: Text("Usp do Alerta"),
        //         content: Text("Teste para disparo no appbar")
        //       );
        //     }
        //   );
        //  },
        // ),
        title: const Text("IFMT - E-COMMERCE"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.filter)),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: Text("Opção 1")),
              const PopupMenuItem(value: 2, child: Text("Opção 2")),
            ],
          )
        ]
      ),
      body:  IndexedStack(
        index: _index,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Pedidos"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil de Usuário"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Configurações"
          ),
        ],
        onTap: changeTab,
        selectedItemColor: const Color.fromARGB(202, 0, 0, 0),
        unselectedItemColor: const Color.fromARGB(201, 175, 102, 102),
      ),
      drawer: const Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Text("Pastelaria do Zezinho")),
            ListTile(
              hoverColor: Colors.amber,
              title:Text("Home"),
            ),
            ListTile(
              title:Text("Pedidos"),
            ),
            ListTile(
              title:Text("Perfil do Usuário"),
            ),
            Divider(
              height: 2,
            ),
            ListTile(
              title: Text("Configurações do Sistema"),
            )
          ],
        ),
      ),
    );
  }
  void changeTab(int pos){
    setState(() {
      _index = pos;
    });
  }
}