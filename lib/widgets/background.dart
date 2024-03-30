import "package:flutter/material.dart";

class Background extends StatelessWidget {
  final Widget? child;

  const Background({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Colors.blue.shade200,
            Colors.blue.shade100,
          ],
          stops: const [0.0, 0.5],
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
