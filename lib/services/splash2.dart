import 'package:flutter/material.dart';
import 'package:meta_verse/home_page.dart';

class Splash2 extends StatefulWidget {
  @override
  _Splash2State createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the fade animation
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    // Trigger fade animation once
    _fadeController.forward();

    // Navigate to the home page after 4 seconds
    Future.delayed(const Duration(seconds: 5), () {
  Navigator.pushReplacementNamed(context, '/main');
});

  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 249, 249, 249), // Light Beige
              Color.fromARGB(255, 254, 254, 254), // Tan
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  "Logging in...",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                width: 50,
                height: 50,
                child: _BobaBallLoadingAnimation(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BobaBallLoadingAnimation extends StatefulWidget {
  const _BobaBallLoadingAnimation();

  @override
  State<_BobaBallLoadingAnimation> createState() =>
      _BobaBallLoadingAnimationState();
}

class _BobaBallLoadingAnimationState extends State<_BobaBallLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Continuous rotation
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.141592653589793, // Full rotation
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF4E342E), // Dark brown base color for the boba ball
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: const Offset(0.5, 0.5),
                ),
              ],
              gradient: const RadialGradient(
                colors: [
                  Color(0xFF6D4C41), // Lighter brown highlight
                  Color.fromARGB(255, 30, 27, 26), // Base color
                ],
                center: Alignment(-0.4, -0.4),
                radius: 0.8,
              ),
            ),
            child: Align(
              alignment: const Alignment(-0.4, -0.4),
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
