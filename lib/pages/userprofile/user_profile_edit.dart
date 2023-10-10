import 'package:flutter/material.dart';
import 'package:prog_app/services/users/users_services.dart';
import 'package:provider/provider.dart';

class UserProfileEdit extends StatelessWidget {
  UserProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(35.0),
      child: Consumer<UsersServices>(builder: (context, userServices, _) {
        return Column(children: [
          const SizedBox(
            height: 25.0,
          ),
          TextFormField(
            initialValue: userServices.users.userName,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                label: Text("Nome do usuário"),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.3),
                ),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            initialValue: userServices.users.email,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                label: Text("email"),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.3),
                ),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            initialValue: userServices.users.phone,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                label: Text("Numero de telefone"),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.3),
                ),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            initialValue: userServices.users.social,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_pin_rounded),
                label: Text("Rede social"),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.3),
                ),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            // controller: _dataDeNascimentoController,
            initialValue: userServices.users.birthday,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.calendar_month),
                label: Text("Data de Nascimento"),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.3),
                ),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
          ),
          const SizedBox(
            height: 30.0,
          )
        ]);
      }),
    ));
  }
}
