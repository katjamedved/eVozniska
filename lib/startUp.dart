import 'package:flutter/material.dart';

class StartUp extends StatelessWidget {
  const StartUp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        child: Center(
          child: Container(
            child: Image.asset(
              "assets/images/car.gif",
              width: 155,
              height: 155,
            ),
          ),
        ),
      ),
    );
  }
}
