import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);
  @override
  _More createState() => _More();
}

class _More extends State<More> {
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
            'More',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      body: CheckMore(),
      backgroundColor: Color.fromARGB(255, 0, 163, 108),
    );
  }
}

class CheckMore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
