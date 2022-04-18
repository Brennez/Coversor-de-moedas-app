import 'dart:ui';

import 'package:covert_app/widgets/input_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hintColor: Colors.amber,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white70,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.amber,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.amber,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? dolar;
  String? euro;
  String? bitcoin;

  final _realController = TextEditingController();
  final _dolarController = TextEditingController();
  final _euroController = TextEditingController();
  final _bitcoinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        actions: const [
          Icon(
            Icons.monetization_on,
            size: 40,
            color: Colors.black,
          ),
        ],
        leading: const Icon(
          Icons.monetization_on,
          size: 40,
          color: Colors.black,
        ),
        backgroundColor: Colors.amber,
        title: const Text(
          'Conversor',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Falha ao carregar dados :/",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                  ),
                );
              } else {
                dolar = snapshot.data?['USDBRL']['bid'];
                euro = snapshot.data?['EURBRL']['bid'];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.monetization_on_outlined,
                        size: 150,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputMoney(
                        money: "Real",
                        iconMoney: FontAwesomeIcons.brazilianRealSign,
                        controller: _realController,
                        function: onChange,
                      ),
                      InputMoney(
                        money: "Dólar",
                        iconMoney: FontAwesomeIcons.dollarSign,
                        controller: _dolarController,
                        function: onChange,
                      ),
                      InputMoney(
                        money: "Euro",
                        iconMoney: FontAwesomeIcons.euroSign,
                        controller: _euroController,
                        function: onChange,
                      ),
                      InputMoney(
                        money: "Bitcoin",
                        iconMoney: FontAwesomeIcons.bitcoinSign,
                        controller: _bitcoinController,
                        function: onChange,
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

void onChange(String text) {
  print(text);
}

Future<Map> getData() async {
  var url =
      Uri.https('economia.awesomeapi.com.br', '/last/USD-BRL,EUR-BRL,BTC-BRL');

  var response = await http.get(url);

  return json.decode(response.body);
}
