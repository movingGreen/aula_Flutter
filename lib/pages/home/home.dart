import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text("Vitrine"),          
      ),
      body: Center(
        child: Column(children: [
          const Text("Ofertas"),
          ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Container();
              },
            ),
        ]),
      )

    );
  }
}