import 'package:flutter/material.dart';
import 'package:meta_verse/services/QRCode.dart';

BottomAppBar buildBottomNavBar(BuildContext context) {
  return BottomAppBar(
    color: Theme.of(context).bottomAppBarTheme.color,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        // Reviews Button
        IconButton(
          icon: const Icon(Icons.star_half_sharp, size: 21.0),
          onPressed: () {
            Navigator.pushNamed(context, '/review');
          },
          tooltip: 'Reviews',
        ),
        // Home Button
        IconButton(
          icon: const Icon(Icons.home, size: 21.0),
          onPressed: () {
            // Handle home button tap
          },
          tooltip: 'Home',
        ),
        // QR Code Button
        IconButton(
          icon: const Icon(Icons.qr_code, size: 30.0),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) =>  QRCodePage(),
            );
          },
          tooltip: 'QR Code',
        ),
        // Notifications Button
        IconButton(
          icon: const Icon(Icons.notifications, size: 21.0),
          onPressed: () {
            Navigator.pushNamed(context, '/notifications');
          },
          tooltip: 'Notifications',
        ),
        // Profile Button
        IconButton(
          icon: const Icon(Icons.person, size: 21.0),
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
          tooltip: 'Profile',
        ),
      ],
    ),
  );
}
