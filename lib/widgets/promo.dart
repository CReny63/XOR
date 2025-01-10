// lib/widgets/promo_banner.dart
import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Use decoration to add background color and rounded corners
      decoration: BoxDecoration(
        color: const Color(0xFF4E342E), // Your brown color
        borderRadius: BorderRadius.circular(12.0), // Adjust radius as needed
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: const Text(
        "The Right way to buy boba. Check out our socials and give us a follow to stay up to date on new rewards and updates!",
        style: TextStyle(
          fontFamily: 'Roboto', // Use a clean font like Roboto
          fontSize: 14,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
