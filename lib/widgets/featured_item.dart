import 'package:flutter/material.dart';
import '../menu_item.dart'; // Update with the correct import path
import 'featured_item_card.dart'; // Import the FeaturedItemCard widget

class FeaturedItems extends StatelessWidget {
  final List<MenuItem> items;

  const FeaturedItems({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.map((item) {
            return FeaturedItemCard(item: item); // Pass each item to the card widget
          }).toList(),
        ),
      ),
    );
  }
}
