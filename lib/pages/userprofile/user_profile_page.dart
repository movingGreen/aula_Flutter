import 'package:flutter/material.dart';
import 'package:prog_app/services/users/users_services.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          const Text(
            "Perfil de Usuário",
            style: TextStyle(
              color: Color.fromARGB(255, 2, 32, 3),
              fontSize: 28,
              fontFamily: 'Lustria',
              fontWeight: FontWeight.w700,
            ),
          ),
          Card(
            elevation: 1.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15,
              ),
              child: Consumer<UsersServices>(
                builder: (context, usersServices, child) {
                  return Row(children: [
                    const ClipOval(
                      child: Icon(Icons.person, size: 90),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${usersServices.users.userName}'),
                        Text('${usersServices.users.email}'),
                        Text('${usersServices.users.phone}'),
                      ],
                    )
                  ]);
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/userprofileedit'),
            child: const Card(
              elevation: 1.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.person_add_alt_1_outlined,
                      size: 90.0,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Editar',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Edite dados pessoais, profissionais'),
                          Text('Emails, telefones, redes sociais e outros'),
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
