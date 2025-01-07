import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meta_verse/services/theme_provider.dart';

class AppBarContent extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const AppBarContent({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.menu,
              size: 13,
              color: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
            onPressed: () {
              _showSettingsMenu(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.coffee,
              size: 13,
              color: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
            onPressed: () {
              // Add your custom action here
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings_accessibility_outlined,
              size: 13,
              color: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
            onPressed: () {
              _showSettingsMenu(context);
            },
          ),
        ],
      ),
    );
  }

  void _showSettingsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.color_lens),
                title: const Text('Toggle Theme'),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  // Implement logout functionality
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
