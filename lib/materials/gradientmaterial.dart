import 'package:flutter/material.dart';

class GradientMaterial extends StatelessWidget {
  const GradientMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xffa6bcff),
              Color(0xff99b1f9),
              Color(0xff8da6f2),
              Color(0xff809bec),
              Color(0xff7390e5),
              Color(0xff6685de),
              Color(0xff587ad8),
              Color(0xff4970d1),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
      ),
    );
  }
}