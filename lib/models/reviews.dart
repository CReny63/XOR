import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the date
import 'package:meta_verse/widgets/app_bar_content.dart'; // Custom AppBarContent

class ReviewsPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const ReviewsPage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

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
    // Use themeColor from current theme for title text
    final Color themeColor =
        Theme.of(context).floatingActionButtonTheme.backgroundColor ?? Colors.black;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: AppBarContent(
          toggleTheme: widget.toggleTheme,
          isDarkMode: widget.isDarkMode,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title Section
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 20),

              
              // Rating input section
    Center(
  child: Row(
    mainAxisSize: MainAxisSize.min,  // Row occupies minimal horizontal space
    children: [
      const Text(
        'Rating: ',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      ...List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            Icons.star,
            color: _rating > index ? Colors.black : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
        );
      }),
    ],
  ),
),

const SizedBox(height: 10),



              // Comment input field
           // Wrap the comment TextField with a Container or SizedBox
SizedBox(
  width: 250,   // Set desired width
  height: 100,  // Set desired height (optional for multi-line inputs)
  child: TextField(
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
),
const SizedBox(height: 10),

              const SizedBox(height: 20),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  if (_rating > 0 &&
                      _commentController.text.isNotEmpty &&
                      _nameController.text.isNotEmpty) {
                    final now = DateTime.now();
                    final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
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
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                ),
                child: const Text('Submit Review'),
              ),
              const SizedBox(height: 20),

              // All Reviews header
              const Text(
                'All Reviews',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.star_half_outlined, size: 21.0),
              tooltip: 'Reviews',
              onPressed: () {
                // Already on Reviews
              },
            ),
            IconButton(
              icon: const Icon(Icons.home, size: 21.0),
              tooltip: 'Home',
              onPressed: () => Navigator.pushNamed(context, '/main'),
            ),
            IconButton(
              icon: const Icon(Icons.qr_code, size: 21.0),
              tooltip: 'QR Code',
              onPressed: () => _showQRCodeModal(context),
            ),
            IconButton(
              icon: const Icon(Icons.notifications, size: 21.0),
              tooltip: 'Notifications',
              onPressed: () => Navigator.pushNamed(context, '/notifications'),
            ),
            IconButton(
              icon: const Icon(Icons.person, size: 21.0),
              tooltip: 'Profile',
              onPressed: () => Navigator.pushNamed(context, '/profile'),
            ),
          ],
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
