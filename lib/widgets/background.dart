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
        Color.fromARGB(255, 18, 85, 192),
        Color.fromARGB(255, 77, 123, 191),
        Color.fromARGB(255, 139, 180, 218),
        Color.fromARGB(255, 184, 223, 242)
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
