import 'package:flutter/material.dart';
import 'package:weatherapp/provider/darktheme.dart';
import 'package:weatherapp/styles.dart';
import 'package:provider/provider.dart';

class GradientMaterial extends StatelessWidget {
  const GradientMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProv, _){
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: const Alignment(0.8, 1),
                colors: Styles.gradientColors(themeProv.darkTheme, context),
                tileMode: TileMode.mirror,
              ),
            ),
          );
        }
      ),
    );
  }
}