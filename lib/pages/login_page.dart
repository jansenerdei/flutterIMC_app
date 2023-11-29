//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:imc_app2/models/pessoa_model.dart';
import 'package:imc_app2/pages/main_page.dart';
import 'package:imc_app2/repository/registros_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var registrosRepository = RegistrosRepository();
  var pessoaModel = RegistrosRepository().listarRegistros();

  ///** CONTROLLERS **///
  var pesoController = TextEditingController();
  var nomeController = TextEditingController();
  var alturaController = TextEditingController();

  ///** VARIAVEIS **///
  var registro = <Pessoa>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*** APP BAR ***/
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "IMC - Calculator",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        ),
      ),

      /*** BODY ***/
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,

        //*** COLUNA - INICIO ***/
        children: [
          const SizedBox(
            height: 50,
          ),

          //*** NOME ***/
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.black,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
            child: Expanded(
              child: TextField(
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.people,
                      color: Colors.amber,
                    ),
                    border: UnderlineInputBorder(),
                    hintText: "Digite o seu nome",
                    hintStyle: TextStyle(color: Colors.white)),
                controller: nomeController,
                style: const TextStyle(fontSize: 16, color: Colors.amber),
              ),
            ),
          ),

          //*** ALTURA ***/
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.black,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.height,
                    color: Colors.amber,
                  ),
                  border: UnderlineInputBorder(),
                  hintText: "Digite a sua altura em metros",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                controller: alturaController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(fontSize: 16, color: Colors.amber),
              ),
            ),
          ),

          //*** PESO ***/
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.black,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.balance,
                    color: Colors.amber,
                  ),
                  border: UnderlineInputBorder(),
                  hintText: "Digite o seu peso em Kg",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                controller: pesoController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(fontSize: 16, color: Colors.amber),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          /** BOTÃO ACESSAR **/
          Container(
            alignment: Alignment.center,
            child: TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all(Colors.purple)),
              onPressed: () {
                if (nomeController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Preencha o seu nome!")));
                } else if (pesoController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Preencha o seu peso!")));
                } else if (alturaController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Preencha a sua altura!")));
                } else {
                  var pes = Pessoa(
                    nomeController.text,
                    double.parse(alturaController.text),
                    double.parse(pesoController.text),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MainPage(inPessoa: pes),
                    ),
                  );
                }
              },
              child: const Text(
                "Acessar",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
