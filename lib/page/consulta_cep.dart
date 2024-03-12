import 'dart:convert';
import 'package:dio_imc_2/model/via_cep_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConsultaCEP extends StatefulWidget {
  const ConsultaCEP({Key? key}) : super(key: key);

  @override
  State<ConsultaCEP> createState() => _ConsultaCEPState();
}

class _ConsultaCEPState extends State<ConsultaCEP> {
  TextEditingController cepController = TextEditingController();
  bool loading = false;
  var viaCepModel = ViaCEPModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            const Text(
              "Consulta de CEP",
              style: TextStyle(fontSize: 22),
            ),
            TextField(
              maxLength: 9,
              keyboardType: TextInputType.number,
              controller: cepController,
              onChanged: (String value) async {
                var cep = value.trim().replaceAll(RegExp(r'[^0-9]'), '');
                if (cep.length == 8) {
                  setState(() {
                    loading = true;
                  });
                  var response = await http
                      .get(Uri.parse("https://viacep.com.br/ws/$cep/json"));
                  var json = jsonDecode(response.body);
                  viaCepModel = ViaCEPModel.fromJson(json);
                }
                setState(() {
                  loading = false; 
                });
              },
            ),
            const SizedBox(height: 50),
            Text(
              viaCepModel.logradouro ?? "",
              style: const TextStyle(fontSize: 22),
            ),
            Text(
              "${viaCepModel.localidade ?? ""} - ${ viaCepModel.uf ?? ""} ",
              style: TextStyle(fontSize: 22),
            ),
            if (loading) CircularProgressIndicator()
          ],
        ),
      ),
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          print("Antes da chamada");
          var response = await http.get(Uri.parse("https://www.google.com"));
          print(response.body);
          print("Depois da chamada");
        },
      ),
    ));
  }
}
