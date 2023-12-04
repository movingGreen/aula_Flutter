import 'package:flutter/material.dart';
import 'package:prog_app/pages/authentication/signup_page.dart';
import 'package:prog_app/pages/home/home_page.dart';
import 'package:prog_app/pages/main/main_page.dart';
import 'package:prog_app/services/users/users_services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Consumer<UsersServices>(builder: (context, usersServices, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 45,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Image.asset(
                  'assets/images/logo_flutter.png',
                  height: 100,
                ),
              ),
              const Text(
                "Bem-vindo de Volta",
                style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 213, 107, 8),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                ),
              ),
              const Text(
                'aplicativo multi-funcional',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 213, 93, 8),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    label: Text("E-mail"),
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
                obscureText: true,
                controller: _password,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.fingerprint),
                    label: Text("Senha"),
                    suffixIcon: Icon(Icons.remove_red_eye),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.3),
                    ),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 8.0),
                child: const Text(
                  'Esqueceu a senha?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      usersServices.signIn(
                          email: _email.text,
                          password: _password.text,
                          onSucess: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/mainpage');
                          },
                          onFail: (e) {
                            var snack = SnackBar(
                              content: Text(e),
                              backgroundColor: Colors.red,
                              elevation: 20,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(20),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snack);
                          });
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 1.5,
                        minimumSize: const Size.fromHeight(50),
                        shape: LinearBorder.bottom()),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Ainda não tem conta?'),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Registre-se',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
