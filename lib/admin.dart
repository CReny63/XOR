import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'user.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Admin Panel'),
        backgroundColor: const Color(0xFF4E342E), // Granite brown
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6D4C41), // Lighter granite brown
              Color(0xFF4E342E), // Darker granite brown
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Admin Dashboard",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Black text for better contrast
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1, // Square layout
                children: [
                  _buildAdminCard(
                    title: "Manage Users",
                    icon: Icons.people,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ManageUsersPage(),
                        ),
                      );
                    },
                  ),
                  _buildAdminCard(
                    title: "Reviews",
                    icon: Icons.rate_review,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReviewsPage(),
                        ),
                      );
                    },
                  ),
                  _buildAdminCard(
                    title: "Admin Settings",
                    icon: Icons.settings,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminSettingsPage(),
                        ),
                      );
                    },
                  ),
                  _buildAdminCard(
                    title: "Payment Info",
                    icon: Icons.payment,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentInfoPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // Transparent background
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black, width: 2), // Black border
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black), // Black icon
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Black text
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}



class ManageUsersPage extends StatefulWidget {
  const ManageUsersPage({Key? key}) : super(key: key);

  @override
  _ManageUsersPageState createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  late Future<Box<User>> _userBoxFuture;

  @override
  void initState() {
    super.initState();
    // Load the Hive box asynchronously to ensure it is opened properly
    _userBoxFuture = Hive.openBox<User>('users');
  }

  // Function to remove a user
  void _removeUser(Box<User> box, User user) {
    setState(() {
      box.delete(user.username);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User ${user.username} removed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Users"),
        backgroundColor: const Color(0xFF4E342E), // Granite brown
      ),
      body: FutureBuilder<Box<User>>(
        future: _userBoxFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(), // Show a loading spinner
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error loading users: ${snapshot.error}",
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else {
            final userBox = snapshot.data!;
            final users = userBox.values.toList();

            return users.isEmpty
                ? const Center(
                    child: Text(
                      "No users available.",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        color: Colors.transparent,
                        elevation: 4.0,
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                          leading: const Icon(Icons.person, color: Colors.black),
                          title: Text(
                            user.username,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _removeUser(userBox, user);
                            },
                          ),
                        ),
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}


class ReviewsPage extends StatelessWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
        backgroundColor: const Color(0xFF4E342E), // Granite brown
      ),
      body: const Center(
        child: Text("Reviews Section"),
      ),
    );
  }
}

class AdminSettingsPage extends StatelessWidget {
  const AdminSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Settings"),
        backgroundColor: const Color(0xFF4E342E), // Granite brown
      ),
      body: const Center(
        child: Text("Admin Settings Section"),
      ),
    );
  }
}

class PaymentInfoPage extends StatelessWidget {
  const PaymentInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Info"),
        backgroundColor: const Color(0xFF4E342E), // Granite brown
      ),
      body: const Center(
        child: Text("Payment Info Section"),
      ),
    );
  }
}
