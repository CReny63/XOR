import 'package:flutter/material.dart';
import 'package:meta_verse/widgets/app_bar_content.dart';

class NotificationsPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const NotificationsPage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75), 
        child: AppBarContent(
          toggleTheme: toggleTheme,
          isDarkMode: isDarkMode,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Center(
        child: Text('noti Content Here'),
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
              () {
                // Currently on Notifications, refresh or do nothing
              },
              iconSize: 21.0,
            ),
            _buildBottomNavItem(
              context,
              Icons.person,
              'Profile',
              () => Navigator.pushNamed(context, '/profile'),
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
      String tooltipMessage,
      VoidCallback onTap, {
        double iconSize = 24.0,
      }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Tooltip(
            message: tooltipMessage,
            child: Icon(
              iconData,
              size: iconSize,
            ),
          ),
        ),
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
