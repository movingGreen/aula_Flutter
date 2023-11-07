import 'package:flutter/material.dart';
import 'package:prog_app/services/users/users_services.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          const SizedBox(
            height: 100,
          ),
          const Text(
            'IFMT App',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 6, 66, 8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50, top: 70),
            child: TextFormField(
              controller: _userEmailController,
              decoration: InputDecoration(
                labelText: 'Email',
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF4CAF50),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.black26,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50, top: 40),
            child: TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF4CAF50),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.black26,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 170,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text('Entrar')),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () async {
                        UsersServices userServices = UsersServices();
                        if (await userServices.signUp(
                            email: _userEmailController.text,
                            password: _passwordController.text)) {
                          Navigator.pushNamed(context, '/mainpage');
                        } else {
                          // ignore: use_build_context_synchronously
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  content: Text('Não autorizado!!!'),
                                );
                              });
                        }
                      },
                      child: const Text('Registrar')),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
