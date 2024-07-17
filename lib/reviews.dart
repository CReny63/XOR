import 'package:flutter/material.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75), // Adjust height as needed
        child: AppBarContent(), // Same AppBarContent as HomePage
      ),
      backgroundColor:
          const Color.fromARGB(255, 255, 255, 255), // Main background color

      body: const Center(
        child: Text('review Content Here'), // Add your review page content here
      ),

      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildBottomNavItem(
              context,
              Icons.star_half_outlined,
              'Reviews',
              () 
              {
               // Navigator.pushNamed(
                    //context, '/review'); 
              },
              iconSize: 21.0,
            ),
            _buildBottomNavItem(
              context,
              Icons.home,
              'Home',
              () {
                Navigator.pushNamed(context, '/'); // Navigate to the home page
              },
              iconSize: 21.0,
            ),
            _buildBottomNavItem(
              context,
              Icons.qr_code,
              'QR Code',
              () {
                _showQRCodeModal(context);
              },
              iconSize: 21.0,
            ),
            _buildBottomNavItem(
              context,
              Icons.notifications,
              'Notifications',
              () {
                Navigator.pushNamed(context, '/notifications'); // Navigate to the home page
              },
              iconSize: 21.0,
            ),
            _buildBottomNavItem(
              context,
              Icons.person,
              'Profile',
              () {
                Navigator.pushNamed(context, '/profile'); // Navigate to the home page
              },
              iconSize: 21.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
      BuildContext context, IconData iconData, String label, VoidCallback onTap,
      {double iconSize = 24.0}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconData,
            size: iconSize,
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  void _showQRCodeModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('QR Code'),
          content: Text('QR Code content here'),
        );
      },
    );
  }
}

class AppBarContent extends StatelessWidget {
  const AppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(
          255, 255, 255, 255), // Set the background color here
      padding:
          const EdgeInsets.symmetric(horizontal: 12), // Optional: Add padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu, size: 13, color: Colors.black),
            onPressed: () {
              _showSettingsMenu(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.coffee, size: 13, color: Colors.black),
            onPressed: () {
              // Add your custom action here
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 13, color: Colors.black),
            onPressed: () {
              // Add an empty onPressed callback to prevent the button from being disabled
            },
          ),
        ],
      ),
    );
  }

  void _showSettingsMenu(BuildContext context) {
    // Show settings menu logic here
  }
}
