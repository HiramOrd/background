import 'package:flutter/material.dart';

class WHomeHideget extends StatelessWidget {
  const WHomeHideget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Click $index"),
          const Icon(Icons.person, color: Colors.white),
        ],
      ),
    );
  }
}
