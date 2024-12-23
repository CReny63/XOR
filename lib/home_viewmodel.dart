import 'package:flutter/foundation.dart';
import 'menu_item.dart';
import 'services/order_service.dart';

class HomeViewModel extends ChangeNotifier {
  List<MenuItem> featuredItems = [];
  bool isLoading = true;

  HomeViewModel() {
    _fetchFeaturedItems();
  }

  void _fetchFeaturedItems() async {
    featuredItems = await OrderService.fetchFeaturedItems();
    isLoading = false;
    notifyListeners();
  }

  void placeOrder(MenuItem item) {
    OrderService.placeOrder(item);
    notifyListeners();
  }
}
