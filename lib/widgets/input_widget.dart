import 'package:flutter/material.dart';

class InputMoney extends StatelessWidget {
  const InputMoney({
    Key? key,
    required this.money,
    required this.iconMoney,
    required this.controller,
    required this.function,
  }) : super(key: key);

  final String money;
  final IconData iconMoney;
  final TextEditingController controller;
  final Function(String) function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        controller: controller,
        onChanged: function,
        textAlign: TextAlign.center,
        cursorColor: Colors.amber,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          color: Colors.white70,
        ),
        decoration: InputDecoration(
          labelText: money,
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
