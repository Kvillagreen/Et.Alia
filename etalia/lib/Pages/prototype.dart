import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Prototype extends StatefulWidget {
  const Prototype({Key? key}) : super(key: key);
  @override
  _Prototype createState() => _Prototype();
}

class _Prototype extends State<Prototype> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 5,
        shadowColor: Colors.black12,
        backgroundColor: Color.fromARGB(255, 2, 138, 93),
        leading: Builder(
          builder: (context) => IconButton(
              padding:const EdgeInsets.only(bottom: 5),
              iconSize: MediaQuery.of(context).size.height * 0.04,
              icon:const Icon(Ionicons.arrow_back_outline),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Prototype',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      body: CheckPrototype(),
      backgroundColor: Color.fromARGB(255, 0, 163, 108),
    );
  }
}

class CheckPrototype extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
