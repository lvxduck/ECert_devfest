import 'package:ecert/theme/theme_data.dart';
import 'package:flutter/material.dart';

class CardSetupWrapper extends StatelessWidget {
  const CardSetupWrapper({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                const Color(0x6B0B66BF),
                CustomTheme.lightColorScheme.primary,
              ],
              stops: const [0, 0.7],
              radius: 0.6,
            ),
          ),
        ),
        Align(
          child: SizedBox(
            width: 380,
            height: 520,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
