import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getGreeting() {
  var now = DateTime.now()
      .toUtc()
      .subtract(const Duration(hours: 8)); // Adjust for PST
  var hour = now.hour;

  if (hour >= 6 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}

String getCurrentDate() {
  var now = DateTime.now();
  var formatter = DateFormat('MMM dd, yyyy');
  return formatter.format(now);
}

void _showSettingsMenu(BuildContext context) {
  showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(0, 100, 0, 0),
    items: <PopupMenuEntry<String>>[
      const PopupMenuItem<String>(
        value: 'Help',
        child: Text('Help', style: TextStyle(color: Colors.white)),
      ),
      const PopupMenuItem<String>(
        value: 'Change Username',
        child: Text('Change Username', style: TextStyle(color: Colors.white)),
      ),
      const PopupMenuItem<String>(
        value: 'Instagram Handle',
        child: Text('Instagram Handle', style: TextStyle(color: Colors.white)),
      ),
      const PopupMenuItem<String>(
        value: 'Rate Us on App Store',
        child:
            Text('Rate Us on App Store', style: TextStyle(color: Colors.white)),
      ),
      const PopupMenuItem<String>(
        value: 'Logout',
        child: Text('Logout', style: TextStyle(color: Colors.white)),
      ),
    ],
    // Set the background color for the entire menu
    color: Colors.blueGrey[800], // Change this to your desired color
    elevation: 8,
  ).then((value) {
    if (value != null) {
      switch (value) {
        case 'Help':
          // Handle help button pressed
          break;
        case 'Change Username':
          // Handle change username pressed
          break;
        case 'Logout':
          break;
        case 'Rate Us on App Store':
          break;
        case 'Instagram Handle':
          break;
      }
    }
  });
}

// void searchBobaStores(String query) {
//     if (query.isEmpty) {
//       filteredBobaStores = List.from(bobaSearch);
//       hideOverlay(); // Hide the overlay when the search text is empty
//     } else {
//       filteredBobaStores = bobaSearch
//           .where(
//               (store) => store.name.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//       showOverlay(context); // Show the overlay when there is a search text
//     }

//     setState(() {
//       isOverlayVisible = true;
//     });
//   }