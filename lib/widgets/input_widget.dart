import 'package:flutter/material.dart';

class InputMoney extends StatelessWidget {
  const InputMoney({
    Key? key,
    required this.money,
    required this.iconMoney,
  }) : super(key: key);

  final String money;
  final IconData iconMoney;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        textAlign: TextAlign.center,
        cursorColor: Colors.amber,
        style: const TextStyle(
          color: Colors.white70,
        ),
        decoration: InputDecoration(
          labelText: "$money",
          labelStyle: const TextStyle(
            color: Colors.amber,
            fontSize: 20,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          prefixIcon: Icon(
            iconMoney,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
