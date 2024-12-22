import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this for formatting the date

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  int _rating = 0;
  List<Map<String, dynamic>> _reviews = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBarContent(),
      ),
      backgroundColor: const Color.fromARGB(255, 206, 189, 152), // Coffee brown background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title Section
              const Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Name input field
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Rating input section
              Row(
                children: [
                  const Text(
                    'Rating: ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  ...List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        Icons.star,
                        color: _rating > index ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey,
                      ),
                      onPressed: () => setState(() {
                        _rating = index + 1;
                      }),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 10),

              // Textfield for the comment
              TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Leave your feedback...',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  if (_rating > 0 && _commentController.text.isNotEmpty && _nameController.text.isNotEmpty) {
                    final now = DateTime.now();
                    final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now); // Formatting date
                    setState(() {
                      _reviews.add({
                        'name': _nameController.text,
                        'rating': _rating,
                        'comment': _commentController.text,
                        'date': formattedDate,
                      });
                      _commentController.clear();
                      _nameController.clear();
                      _rating = 0;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.orange, // Text color
                ),
                child: const Text('Submit Review'),
              ),
              const SizedBox(height: 20),

              // Displaying all reviews
              const Text(
                'All Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _reviews.length,
                  itemBuilder: (context, index) {
                    final review = _reviews[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: Colors.white,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ...List.generate(review['rating'], (index) {
                                  return const Icon(Icons.star, color: Colors.orange);
                                }),
                                const SizedBox(width: 8),
                                Text(
                                  review['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(review['comment']),
                            const SizedBox(height: 8),
                            Text(
                              review['date'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 255, 255, 255), // Coffee brown color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildBottomNavItem(
              context,
              Icons.star_half_outlined,
              'Reviews',
              () {},
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
                Navigator.pushNamed(context, '/profile');
              },
              iconSize: 21.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
    BuildContext context, IconData iconData, String label, VoidCallback onTap, {
    double iconSize = 24.0,
  }) {
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
      color: const Color.fromARGB(255, 255, 255, 255), // Coffee brown color for AppBar
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu, size: 13, color: Color.fromARGB(255, 0, 0, 0)),
            onPressed: () {
              _showSettingsMenu(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.coffee, size: 13, color: Color.fromARGB(255, 0, 0, 0)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 13, color: Color.fromARGB(255, 0, 0, 0)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void _showSettingsMenu(BuildContext context) {
    // Show settings menu logic here
  }
}
