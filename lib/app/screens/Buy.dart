import 'package:flutter/material.dart';

class BuyScreen extends StatefulWidget {
  BuyScreen({Key? key}) : super(key: key);

  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<BuyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comprar'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('Hola'),
          ],
        )
      ),
    );
  }
}