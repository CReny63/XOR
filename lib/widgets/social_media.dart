import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';  // Import Font Awesome

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({Key? key}) : super(key: key);

  final String instagramUrl = 'https://www.instagram.com/creny633/';
  final String facebookUrl = 'https://www.facebook.com/yourProfile';
  final String gmailUrl = 'mailto:youremail@gmail.com';

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.instagram),  // Instagram icon
          color: const Color.fromARGB(255, 0, 0, 0),
          onPressed: () => _launchURL(instagramUrl),
          tooltip: 'Instagram',
        ),
        IconButton(
          selectedIcon: const SizedBox(width: 20), // Adjust width as needed
          icon: const FaIcon(FontAwesomeIcons.facebook),  // Facebook icon
          color: const Color.fromARGB(255, 0, 0, 0),
          onPressed: () => _launchURL(facebookUrl),
          tooltip: 'Facebook',
        ),
        IconButton(
          selectedIcon: const SizedBox(width: 20), // Adjust width as needed
          icon: const Icon(Icons.email),  // Use default email icon for Gmail
          color: const Color.fromARGB(255, 0, 0, 0),
          onPressed: () => _launchURL(gmailUrl),
          tooltip: 'Email Us!',
        ),
      ],
    );
  }
}
