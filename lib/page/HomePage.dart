import 'package:dio_imc_2/page/consulta_cep.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageState(),
    );
  }
}

class HomePageState extends StatefulWidget {
  @override
  State<HomePageState> createState() => HomePageStateful();
}

class HomePageStateful extends State<HomePageState> {
  String auxiliar = " , , ";
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  bool isVisible = true;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // late Box collection;

  // @override
  // void initState() {
  //   super.initState();
  //   lendoComHive();
  // }

  // void lendoComHive() async {
  //   collection = await Hive.openBox('IMC');
  // }

  _criarLinhaTable(String listaNomes) {
    return TableRow(
      children: listaNomes.split(',').map((name) {
        return Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            name,
            style: TextStyle(fontSize: 20.0),
          ),
          padding: const EdgeInsets.all(8.0),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Calculando IMC")),
      ),
      drawer: Drawer(
        child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ConsultaCEP()));
            },
            child: const Text("Pagina de Teste")),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column( 
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Visibility(
                      visible: !isVisible,
                      child: Table(
                        defaultColumnWidth: const FixedColumnWidth(90.0),
                        border: const TableBorder(
                          horizontalInside: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          verticalInside: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                        ),
                        children: [
                          _criarLinhaTable("Altura, Peso, IMC"),
                          _criarLinhaTable(auxiliar),
                        ],
                      ),
                    ),
                  ),
                  calculandoImc(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 28.0, horizontal: 8.0),
                    child: Visibility(
                      visible: !isVisible,
                      child: Table(
                        defaultColumnWidth: const IntrinsicColumnWidth(),
                        border: const TableBorder(
                          horizontalInside: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          verticalInside: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                        ),
                        children: [
                          _criarLinhaTable("IMC, Classificação"),
                          _criarLinhaTable("< 16, Magreza grave"),
                          _criarLinhaTable("16 a < 17, Magreza moderada"),
                          _criarLinhaTable("17 a < 18.5, Magreza leve"),
                          _criarLinhaTable("18.5 a < 25, Saudável"),
                          _criarLinhaTable("25 a < 30, Sobrepeso"),
                          _criarLinhaTable("30 a < 35, Obesidade Grau I"),
                          _criarLinhaTable(
                              "35 a < 40, Obesidade Grau II(severa)"),
                          _criarLinhaTable(
                              ">= 40, Obesidade Grau III(mórbida)"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(220.0),
                  child: Visibility(
                    visible: isVisible,
                    child: TextButton(
                        child: const Text("Calcular Imc"),
                        onPressed: () {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text("Escreva seus dados"),
                                      TextField(
                                        textAlign: TextAlign.center,
                                        controller: alturaController,
                                        decoration: const InputDecoration(
                                            hintText:
                                                'Digite sua altura Ex: 1.75'),
                                      ),
                                      TextField(
                                        controller: pesoController,
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            hintText: 'Digite seu peso Ex: 75'),
                                      ),
                                      TextButton(
                                        child: const Text("Salvar"),
                                        onPressed: () {
                                          setState(() {
                                            isVisible = !isVisible;
                                            salvarDados();
                                            pegarPeso();
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ],
                                  ));
                                });
                          });
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget calculandoImc() {
    return Visibility(
      visible: !isVisible,
      child: TextButton(
        onPressed: () {
          setState(() {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Escreva seus dados"),
                      TextField(
                        textAlign: TextAlign.center,
                        controller: alturaController,
                        decoration: const InputDecoration(
                            hintText: 'Digite sua altura Ex: 1.75'),
                      ),
                      TextField(
                        controller: pesoController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            hintText: 'Digite seu peso Ex: 75'),
                      ),
                      TextButton(
                        child: const Text("Salvar"),
                        onPressed: () {
                          setState(() {
                            //lendoComHive();
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ));
                });
          });
        },
        child: const Text("Salvar"),
      ),
    );
  }

  void salvarDados() async {
    SharedPreferences prefs = await _prefs;
    prefs.setInt('peso', int.parse(pesoController.text));
    prefs.setDouble('altura', double.parse(alturaController.text));
    int imc = int.parse(pesoController.text) ~/
        (double.parse(alturaController.text) *
            double.parse(alturaController.text));
    prefs.setInt('IMC', imc);
  }

  void pegarPeso() async {
    SharedPreferences prefs = await _prefs;
    auxiliar = prefs.getDouble('altura').toString() + ",";
    auxiliar += prefs.getInt('peso').toString() + ',';
    auxiliar += prefs.getInt('IMC').toString();
    if (kDebugMode) {
      print(auxiliar);
    }
  }

//   void salvandoComHive() async {
//   final collection = await BoxCollection.open(
//     'IMC', // Name of your database
//     {'peso', 'altura', 'IMC'}, // Names of your boxes
//     path: './', // Path where to store your boxes (Only used in Flutter / Dart IO)
//   );

//   final pesoBox = await collection.box('peso');
//   final alturaBox = await collection.box('altura');
//   final imcBox = await collection.box('IMC');

//   await pesoBox.put('peso', int.parse(pesoController.text));
//   await alturaBox.put('altura', double.parse(alturaController.text));

//   double peso = await pesoBox.get('peso');
//   double altura = await alturaBox.get('altura');

//   double imc = peso / (altura * altura);
//   await imcBox.put('IMC', imc);
// }

  // void salvandoComHive() async {
  //   final collection =  await BoxCollection.open(
  //     'IMC', // Name of your database
  //     {'peso', 'altura','IMC'}, // Names of your boxes
  //     path: './', // Path where to store your boxes (Only used in Flutter / Dart IO)
  //   );
  //   final pesoBox = collection.openBox<Map>('peso');
  //   final alturaBox = collection.openBox('altura');
  //   final ImcBox = collection.openBox('IMC');
  //   await pesoBox.put('peso', int.parse(pesoController.text));
  //   await alturaBox.put('altura', double.parse(alturaController.text));
  //   int imc = int.parse(pesoController.text) ~/
  //       (double.parse(alturaController.text) *
  //           double.parse(alturaController.text));
  //   await ImcBox.put('IMC', imc);
  // }

  // void lendoComHive() {
  //   box.get('peso');
  //   box.get('altura');
  //   box.get('IMC');
  // }
}
