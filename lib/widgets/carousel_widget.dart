// lib/widgets/carousel_widget.dart

import 'dart:async';
import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  // List of local/asset image paths (replace with your actual image assets)
  final List<String> _images = [
    'assets/nintai_tea.png',
    'assets/serenitea.png',
    'assets/share_tea.png',
    'assets/vivi_tea.png',
    'assets/tea_amo.png',
  ];

  @override
  void initState() {
    super.initState();
    // Auto-scroll every 3.5 seconds
    _timer = Timer.periodic(const Duration(milliseconds: 3500), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    // Cancel timer to prevent memory leaks
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,  // Adjust the height to your preference
      width: 260,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return _buildCarouselItem(_images[index]);
        },
      ),
    );
  }

  Widget _buildCarouselItem(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
