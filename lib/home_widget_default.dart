import 'package:flutter/material.dart';

class WHomeHidegetDefault extends StatelessWidget {
  const WHomeHidegetDefault({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Inicia sesion para cargar widget",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
