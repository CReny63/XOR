// lib/widgets/featured_item_card.dart
import 'package:flutter/material.dart';
import '../menu_item.dart';
import 'package:provider/provider.dart';
import '../home_viewmodel.dart';

class FeaturedItemCard extends StatelessWidget {
  final MenuItem item;

  FeaturedItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          Text(item.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Image.asset(item.imagePath, width: 150, height: 180),
          ElevatedButton(
            onPressed: () => _orderItem(context),
            child: Text("Order for Pick Up"),
          ),
        ],
      ),
    );
  }

  void _orderItem(BuildContext context) {
    // Handle the order logic via the ViewModel
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    viewModel.placeOrder(item);
  }
}
