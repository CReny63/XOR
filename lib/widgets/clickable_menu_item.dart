// lib/widgets/clickable_menu_item.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClickableMenuItem extends StatefulWidget {
  final String name;
  final String imageName;
  final String labelText;

  const ClickableMenuItem({
    Key? key,
    required this.name,
    required this.imageName,
    required this.labelText,
  }) : super(key: key);

  @override
  _ClickableMenuItemState createState() => _ClickableMenuItemState();
}

class _ClickableMenuItemState extends State<ClickableMenuItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        // Implement additional tap functionality if needed
      },
      child: Container(
        width: 200.0,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blueAccent.withOpacity(0.5)
              : const Color.fromARGB(255, 206, 189, 152),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            // Top Section with Name
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 206, 189, 152),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: const EdgeInsets.all(5.8),
              height: 45,
              alignment: Alignment.center,
              child: Text(
                widget.name,
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            // Image Section
            Expanded(
              child: Center(
                child: Image.asset(
                  widget.imageName,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.red,
                    );
                  },
                ),
              ),
            ),
            // Optional: Add label or other widgets here
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
