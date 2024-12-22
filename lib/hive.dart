// lib/hive_storage.dart

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'user.dart'; // Import your user class (if using custom objects)

class HiveStorage {
  static late Box userBox;

  // Initialize Hive and open the box
  static Future<void> initHive() async {
    var appDocumentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDirectory.path);

    // Register custom adapters (only if using custom objects)
    Hive.registerAdapter(UserAdapter());

    // Open the box for storing user data
    userBox = await Hive.openBox('userBox');
  }

  // Add user to the Hive box
  static Future<void> addUser(User user, String s) async {
    await userBox.put(user.username, user); // Store the user
  }

  // Retrieve a user by username
  static User? getUser(String username) {
    return userBox.get(username); // Get user by username
  }

  // Update user reviews (or other personal information)
  static Future<void> updateUserReviews(String username, List<String> newReviews) async {
    User? user = userBox.get(username);
    if (user != null) {
      user.reviews = newReviews;  // Update the reviews list
      await userBox.put(username, user); // Save the updated user
    }
  }

  // Update user payment information
  static Future<void> updateUserPayment(String username, String paymentInfo) async {
    User? user = userBox.get(username);
    if (user != null) {
      user.paymentInfo = paymentInfo; // Update the payment info
      await userBox.put(username, user); // Save the updated user
    }
  }

  // Delete a user by username
  static Future<void> deleteUser(String username) async {
    await userBox.delete(username);
  }

  static printUsers() {}
}
