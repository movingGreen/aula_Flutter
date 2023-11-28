import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prog_app/commons/dotted_border.dart';
import 'package:prog_app/commons/mypicked_image.dart';
import 'package:prog_app/models/users/users.dart';
import 'package:prog_app/services/users/users_services.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _redeSocial = TextEditingController();
  final TextEditingController _dataDeNascimento = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  Users users = Users();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Registre-se",
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 213, 107, 8),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Text(
                      'loja',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 213, 93, 8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Consumer<MyPickedImage>(
                  builder: (context, myPickedImage, child) {
                    if (myPickedImage.pickImage == null ||
                        myPickedImage.webImage!.isEmpty) {
                      return dottedBorder(color: Colors.red);
                    } else {
                      return GestureDetector(
                        onTap: () {
                          Provider.of<MyPickedImage>(context, listen: false)
                              .myPickedImage();
                        },
                        child: ClipOval(
                          child: kIsWeb
                              ? Image.memory(
                                  myPickedImage.webImage!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  myPickedImage.pickImage!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
            const SizedBox(
              height: 25.0,
            ),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
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
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: _userName,
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
              controller: _phone,
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
              controller: _redeSocial,
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
              controller: _dataDeNascimento,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_month),
                  label: Text("Data de Nascimento"),
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
                Consumer<MyPickedImage>(
                  builder: (context, myPickedImage, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        UsersServices usersServices = UsersServices();
                        users.email = _email.text;
                        users.password = _password.text;
                        users.userName = _userName.text;
                        users.phone = _phone.text;
                        users.socialMedia = _redeSocial.text;
                        users.birthday = _dataDeNascimento.text;

                        if (await usersServices.signUp(
                            users,
                            kIsWeb
                                ? myPickedImage.webImage
                                : myPickedImage.pickImage,
                            kIsWeb)) {
                          if (context.mounted) Navigator.of(context).pop();
                        } else {
                          if (context.mounted) {
                            var snackBar = const SnackBar(
                              content: Text('Algum erro aconteceu no registro'),
                              backgroundColor: Color.fromARGB(255, 161, 71, 66),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(50),
                              elevation: 20,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 1.5,
                          minimumSize: const Size.fromHeight(50),
                          shape: LinearBorder.bottom()),
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Ou',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        height: 50,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Login com Google",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Já tem uma conta?'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
