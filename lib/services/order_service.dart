import '../menu_item.dart';

class OrderService {
  static Future<List<MenuItem>> fetchFeaturedItems() async {
    // Replace with actual data fetching logic (e.g., API call)
    return [
      MenuItem(name: 'Share Tea', imagePath: 'assets/menu_item_0.png'),
      MenuItem(name: 'Ding Tea', imagePath: 'assets/menu_item_1.png'),
    ];
  }

  static void placeOrder(MenuItem item) {
    // Logic to place the order
  }
}
