//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:imc_app2/models/registro_model.dart';
import 'package:imc_app2/repository/registros_repository.dart';

class MainPage extends StatefulWidget {
  final RegistroModel inPessoa;
  const MainPage({super.key, required this.inPessoa});

  @override
  State<MainPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<MainPage> {
  RegistrosRepository registrosRepository = RegistrosRepository();
  var registros = const <RegistroModel>[];

  ///** CONTROLLERS **///
  var pesoController = TextEditingController();
  var nomeController = TextEditingController();
  var alturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    obterRegistros();
  }

  void obterRegistros() async {
    await registrosRepository.salvar(widget.inPessoa);
    registros = await registrosRepository.obterDados();
    setState(() {});
  }

  void atualizarRegistros() async {
    registros = await registrosRepository.obterDados();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //var registros = registrosRepository.listarRegistros();
    var nome = registros.isNotEmpty ? registros[0].nome : "Sem Nome";
    //var nome =
    //    widget.inPessoa.nome.isNotEmpty ? widget.inPessoa.nome : "Sem Nome";
    double altura = registros.isNotEmpty ? registros[0].altura : 1;
    //double altura = widget.inPessoa.altura.isNaN ? 1 : widget.inPessoa.altura;
    //altura = altura / 100;
    var imcIdeal = (25 * (altura * altura)).round();

    return SafeArea(
      child: Scaffold(
        /*** FLOATING BUTTON ***/
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text("Adicionar Peso:"),
                    actions: [
                      TextField(
                        controller: pesoController,
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () {
                              registrosRepository.salvar(RegistroModel(
                                0,
                                nome,
                                altura,
                                int.parse(pesoController.text),
                              ));
                              pesoController.text = "";
                              atualizarRegistros();
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: const Text("Salvar"),
                          )
                        ],
                      ),
                    ],
                  );
                });
          },
        ),

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
        body: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                ///** DADOS DO USUSARIO **///
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nome: $nome",
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Altura: $altura",
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Histórico de IMC",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold),
                ),

                ///** LIST VIEW **///
                Expanded(
                  child: ListView.builder(
                    itemCount: registros.length,
                    // ignore: body_might_complete_normally_nullable
                    itemBuilder: (BuildContext bc, int i) {
                      var registro = registros[i];
                      var peso = registros[i].peso.toString();
                      var imc =
                          (registro.peso / (registro.altura * registro.altura))
                              .round();

                      /// IMC ///
                      if (imc <= 18.5) {
                        return ListTile(
                            key: Key(registro.id.toString()),
                            leading:
                                const Icon(Icons.person, color: Colors.white),
                            title: Text(
                              "Peso: $peso - IMC: $imc",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            subtitle: const Text(
                              "Baixo Peso.",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),

                            /// TRAILING - ICONE ///
                            trailing: const Icon(
                                size: 40,
                                Icons.thumb_down,
                                color: Colors.yellowAccent));
//                        //
                      } else if (imc > 18.5 && imc < 25) {
                        return ListTile(
                            key: Key(registro.id.toString()),
                            leading:
                                const Icon(Icons.person, color: Colors.white),
                            title: Text(
                              "Peso: $peso - IMC: $imc",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            subtitle: const Text(
                              "Peso Adequado",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),

                            /// TRAILING - ICONE ///
                            trailing: const Icon(
                                size: 40, Icons.thumb_up, color: Colors.green));
//                        //
                      } else if (imc >= 25 && imc < 30) {
                        return ListTile(
                            key: Key(registro.id.toString()),
                            leading:
                                const Icon(Icons.person, color: Colors.white),
                            title: Text(
                              "Peso: $peso - IMC: $imc",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            subtitle: const Text(
                              "Sobrepeso",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),

                            /// TRAILING - ICONE ///
                            trailing: const Icon(
                                size: 40,
                                Icons.thumb_up,
                                color: Colors.greenAccent));
//                        //
                      } else if (imc >= 30 && imc < 35) {
                        return ListTile(
                            key: Key(registro.id.toString()),
                            leading:
                                const Icon(Icons.person, color: Colors.white),
                            title: Text(
                              "Peso: $peso - IMC: $imc",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            subtitle: const Text(
                              "Obesidade Grau I",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),

                            /// TRAILING - ICONE ///
                            trailing: const Icon(
                                size: 40,
                                Icons.thumb_down,
                                color: Colors.amber));
//
                      } else if (imc >= 35 && imc < 40) {
                        return ListTile(
                            key: Key(registro.id.toString()),
                            leading:
                                const Icon(Icons.person, color: Colors.white),
                            title: Text(
                              "Peso: $peso - IMC: $imc",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            subtitle: const Text(
                              "Obesidade Grau II",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),

                            /// TRAILING - ICONE ///
                            trailing: const Icon(
                                size: 40,
                                Icons.thumb_down,
                                color: Colors.redAccent));
//
                      } else if (imc >= 40) {
                        return ListTile(
                            key: Key(registro.id.toString()),
                            leading:
                                const Icon(Icons.person, color: Colors.white),
                            title: Text(
                              "Peso: $peso - IMC: $imc",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            subtitle: const Text(
                              "Obesidade Grau III",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),

                            /// TRAILING - ICONE ///
                            trailing: const Icon(
                                size: 40, Icons.thumb_down, color: Colors.red));
                      }
                    },
                  ),
                ),

                // FOOTER //
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.backspace,
                        color: Colors.purple,
                        size: 35,
                      ),
                    ),
                    Text(
                      "Seu peso ideal é $imcIdeal Kg",
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
