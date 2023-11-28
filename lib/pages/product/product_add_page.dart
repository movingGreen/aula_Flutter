import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prog_app/commons/custom_textformfield.dart';
import 'package:prog_app/commons/dotted_border.dart';
import 'package:prog_app/commons/mypicked_image.dart';
import 'package:prog_app/models/produtc/product.dart';
import 'package:prog_app/models/produtc/product_services.dart';
import 'package:provider/provider.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({super.key});

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProductServices productServices = ProductServices();
  Product product = Product();
  TextEditingController _name = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Produto'),
        centerTitle: true,
      ),
      body: Consumer<MyPickedImage>(
        builder: (context, myPickedImage, child) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer<MyPickedImage>(
                    builder: (context, myPickedImage, child) {
                      if (myPickedImage.pickImage == null ||
                          myPickedImage.webImage!.isEmpty) {
                        return dottedBorder(
                          color: Colors.red,
                          readImage: () {
                            Provider.of<MyPickedImage>(context, listen: false)
                                .myPickedImage();
                          },
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            Provider.of<MyPickedImage>(context, listen: false)
                                .myPickedImage();
                          },
                          child: ClipRRect(
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
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    // controller: _name,
                    borderColor: Colors.black54,
                    enabled: true,
                    labelText: const Text("Nome do produto"),
                    onSaved: (value) {
                      product.name = value;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                      borderColor: Colors.black54,
                      enabled: true,
                      labelText: const Text("Marca"),
                      onSaved: (value) => product.brand = value),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    controller: _description,
                    borderColor: Colors.black54,
                    enabled: true,
                    labelText: const Text("Descrição do produto"),
                    onSaved: (value) => product.description = value,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    borderColor: Colors.black54,
                    enabled: true,
                    labelText: const Text("Unidade"),
                    onSaved: (value) => product.unity = value!,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    borderColor: Colors.black54,
                    enabled: true,
                    labelText: const Text("Quantidade"),
                    onSaved: (value) => product.quantity = int.parse(value!),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    controller: _price,
                    borderColor: Colors.black54,
                    enabled: true,
                    labelText: const Text("Preço do produto"),
                    onSaved: (value) => product.price = double.parse(value!),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              bool ok = await productServices.save(
                                  product,
                                  kIsWeb
                                      ? myPickedImage.webImage
                                      : myPickedImage.pickImage,
                                  kIsWeb);
                              if (mounted && ok) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Alerta!!!'),
                                      content: const Text(
                                          'Deseja cadastrar outro produto?'),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              formKey.currentState?.reset();
                                              myPickedImage.pickImage = null;
                                              myPickedImage.webImage =
                                                  Uint8List(8);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Sim')),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Não'))
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          child: const Text('Salvar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
