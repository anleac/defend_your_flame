import "package:flutter/material.dart";

class Background extends StatefulWidget {
  final Widget? child;

  const Background({Key? key, this.child}) : super(key: key);

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
      begin: Alignment.topCenter,
      colors: <Color>[
        Color.fromARGB(255, 21, 99, 225),
        Color.fromARGB(255, 98, 156, 243),
        Color.fromARGB(255, 166, 212, 255),
        Color.fromARGB(255, 236, 249, 255)
      ],
      stops: [
        0.5,
        0.8,
        0.94,
        1.0,
      ],
      end: Alignment.bottomCenter,
    )));
  }
}
