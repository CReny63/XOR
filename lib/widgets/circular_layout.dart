// lib/widgets/circular_layout.dart

import 'dart:math';
import 'package:flutter/material.dart';
import '../models/boba_store.dart';
import 'qr_code_dialog.dart';

class CircularLayout extends StatelessWidget {
  final double radius;
  final Widget centralWidget;
  final List<BobaStore> bobaStores;

  const CircularLayout({
    Key? key,
    required this.radius,
    required this.centralWidget,
    required this.bobaStores,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int itemCount = bobaStores.length;
    final double angleIncrement = 2 * pi / itemCount;

    return SizedBox(
      width: radius * 3,       // Large overall size
      height: radius * 3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Central Earth-like circle
          centralWidget,

          // Position each Boba store around the circle
          for (int i = 0; i < itemCount; i++)
            _buildPositionedBobaStore(context, i, angleIncrement),
        ],
      ),
    );
  }

  Widget _buildPositionedBobaStore(
      BuildContext context, int index, double angleIncrement) {
    // Increase orbit for spacing between circles
    final double orbitRadius = radius * 1.5;
    final double angle = angleIncrement * index - pi / 2; // Start from top

    // Compute (x, y) based on orbit radius and current angle
    final double x = orbitRadius * cos(angle);
    final double y = orbitRadius * sin(angle);

    return Transform.translate(
      offset: Offset(x, y),
      child: GestureDetector(
        onTap: () {
          // Show dialog with a unique QR code for each store
          showDialog(
            context: context,
            builder: (context) => QRCodeDialog(
              storeName: bobaStores[index].name,
              qrData: bobaStores[index].qrData, // unique data
            ),
          );
        },
        child: Tooltip(
          message: bobaStores[index].name, // shows store name on hover
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                // Light drop shadow
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 30, // Boba store icon size
              backgroundImage: AssetImage(
                'assets/${bobaStores[index].imageName}.png',
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
