// lib/widgets/promo_banner.dart
import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve the desired theme color or fallback to black if null
    final Color themeColor = Theme.of(context).floatingActionButtonTheme.backgroundColor ?? Colors.black;

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: themeColor, // Use the resolved theme color
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "The Right way to buy boba. Check out our socials to stay up to date on rewards & updates!",
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          color: themeColor, // Use the same resolved theme color
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
