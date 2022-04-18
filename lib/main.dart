import 'dart:ui';

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
  double? euro;
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
                return Center(
                  child: Text(
                    "$dolar",
                    style: TextStyle(color: Colors.green),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Future<Map> getData() async {
  var url =
      Uri.https('economia.awesomeapi.com.br', '/last/USD-BRL,EUR-BRL,BTC-BRL');

  var response = await http.get(url);

  return json.decode(response.body);
}
