import 'package:flutter/material.dart';
// If you no longer need direct access to Provider, you can remove this import.
// import 'package:provider/provider.dart';
// import 'package:meta_verse/services/theme_provider.dart'; // Not needed if we don't call Provider.of<ThemeProvider>

import 'package:meta_verse/widgets/app_bar_content.dart'; // If you have a separate custom AppBarContent
// or define your own TopAppBarContent or something similar.

class ProfilePage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const ProfilePage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Here we call our custom app bar, but rely on the values from constructor:
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: AppBarContent(
          toggleTheme: toggleTheme,       // use the callback we got from constructor
          isDarkMode: isDarkMode,         // use the boolean from constructor
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  // Tab bar
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
                  // Tab bar views
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
              () => Navigator.pushNamed(context, '/review'),
              iconSize: 21.0,
            ),
            _buildBottomNavItem(
              context,
              Icons.home,
              'Home',
              () => Navigator.pushNamed(context, '/main'),
              iconSize: 21.0,
            ),
            _buildBottomNavItem(
              context,
              Icons.qr_code,
              'QR Code',
              () => _showQRCodeModal(context),
              iconSize: 21.0,
            ),
            _buildBottomNavItem(
              context,
              Icons.notifications,
              'Notifications',
              () => Navigator.pushNamed(context, '/notifications'),
              iconSize: 21.0,
            ),
            _buildBottomNavItem(
              context,
              Icons.person,
              'Profile',
              () {
                // Already on profile page, do nothing
              },
              iconSize: 21.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
    BuildContext context,
    IconData iconData,
    String label,
    VoidCallback onTap, {
    double iconSize = 24.0,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(iconData, size: iconSize),
          Text(label, style: const TextStyle(fontSize: 11)),
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
        _buildListTile(
          'My Rewards',
          'Manage Points, bonuses, and streaks',
          Icons.money_sharp,
          () {},
        ),
        _buildListTile(
          'Get Help',
          'Need help with orders?',
          Icons.help_outline,
          () {},
        ),
        _buildListTile(
          'Saved Stores',
          'Check out your favorite stores',
          Icons.store,
          () {},
        ),
        _buildListTile(
          'Gift Card',
          'Manage gift cards',
          Icons.payment,
          () {},
        ),
        _buildListTile(
          'Privacy',
          'Learn about Privacy and manage settings',
          Icons.privacy_tip_outlined,
          () {},
        ),
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
          () {},
        ),
        _buildListTile(
          'Payment',
          'Manage Payment methods and credits',
          Icons.payment,
          () {},
        ),
        _buildListTile(
          'Rate Us',
          'Leave us a review on the app store',
          Icons.rate_review_outlined,
          () {},
        ),
        // Toggle theme
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
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}
