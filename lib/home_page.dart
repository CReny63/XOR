// lib/home_page.dart
import 'package:flutter/material.dart';
import 'widgets/featured_item.dart';
import 'services/QRCode.dart';
import 'package:provider/provider.dart';
import 'home_viewmodel.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Boba Shop')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // QR Code Section
            QRCodePage(),
            // Featured Items Section
            Consumer<HomeViewModel>(
              builder: (context, viewModel, child) {
                return viewModel.isLoading
                    ? const CircularProgressIndicator()
                    : const FeaturedItems(items: [],);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(Icons.star_half_sharp, 'Reviews', context),
            _buildBottomNavItem(Icons.home, 'Home', context),
            _buildBottomNavItem(Icons.qr_code, 'QR Code', context),
            _buildBottomNavItem(Icons.notifications, 'Notifications', context),
            _buildBottomNavItem(Icons.person, 'Profile', context),
          ],
        ),
      ),
    );
  }

  // Helper function for bottom navigation
  Widget _buildBottomNavItem(IconData icon, String label, BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        Navigator.pushNamed(context, '/$label');
      },
    );
  }
}
