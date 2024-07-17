import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const ProfilePage(
      {super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBarContent(),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    color: Theme.of(context).cardColor,
                    child: const TabBar(
                      labelColor: Color.fromARGB(255, 206, 189, 152),
                      tabs: [
                        Tab(text: 'Account'),
                        Tab(text: 'Settings'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildAccountTab(),
                        _buildSettingsTab(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildBottomNavItem(
              context,
              Icons.star_half_outlined,
              'Reviews',
              () {
                Navigator.pushNamed(context, '/review');
              },
              iconSize: 21.0,
            ),
            _buildBottomNavItem(
              context,
              Icons.home,
              'Home',
              () {
                Navigator.pushNamed(context, '/');
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
                Navigator.pushNamed(context, '/notifications');
              },
              iconSize: 21.0,
            ),
            _buildBottomNavItem(
              context,
              Icons.person,
              'Profile',
              () {
                // Already on profile page, no navigation needed
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

  Widget _buildAccountTab() {
    return ListView(
      children: [
        _buildListTile('My Rewards', 'Manage Points, bonuses, and streaks',
            Icons.money_sharp, () {}),
        _buildListTile(
            'Get Help', 'Need help with orders?', Icons.help_outline, () {}),
        _buildListTile('Saved Stores', 'Check out your favorite stores',
            Icons.store, () {}),
        _buildListTile('Gift Card', 'Manage gift cards', Icons.payment, () {}),
        _buildListTile('Privacy', 'Learn about Privacy and manage settings',
            Icons.privacy_tip_outlined, () {}),
      ],
    );
  }

  Widget _buildSettingsTab(BuildContext context) {
    return ListView(
      children: [
        _buildListTile(
            'Manage Account',
            'Update information and manage your account',
            Icons.account_circle,
            () {}),
        _buildListTile('Payment', 'Manage Payment methods and credits',
            Icons.payment, () {}),
        _buildListTile('Rate Us', 'Leave us a review on the app store',
            Icons.rate_review_outlined, () {}),
        _buildListTile(
          isDarkMode ? 'Light Mode' : 'Dark Mode',
          isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
          isDarkMode ? Icons.wb_sunny : Icons.dark_mode,
          toggleTheme,
        ),
      ],
    );
  }

  Widget _buildListTile(
      String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}

class AppBarContent extends StatelessWidget {
  const AppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu, size: 13),
            onPressed: () {
              _showSettingsMenu(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.coffee, size: 13),
            onPressed: () {
              // Add your custom action here
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 13),
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
