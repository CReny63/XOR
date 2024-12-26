import 'package:flutter/material.dart';
import '../models/user_admin_page.dart'; // Import the User/Admin Selection Page

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Delay for 3 seconds and navigate to the next screen
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserAdminPage()),
      );
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 249, 249, 249), // Saddle Brown
              Color(0xFFD2B48C), // Tan
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "metaV",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 100,
                height: 200,
                child: _BobaCupLoadingAnimation(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BobaCupLoadingAnimation extends StatefulWidget {
  @override
  State<_BobaCupLoadingAnimation> createState() =>
      _BobaCupLoadingAnimationState();
}

class _BobaCupLoadingAnimationState extends State<_BobaCupLoadingAnimation>
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Cup
              Container(
                width: 50,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  border: Border.all(color: Colors.brown, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // White top half
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 250, 250, 250),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    // Dark orange bottom half with boba balls
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          Container(
                            color: const Color.fromARGB(255, 82, 193, 117), // Dark orange
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(5, (index) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  width: 8,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Straw
              Positioned(
                top: 20,
                child: Container(
                  width: 5,
                  height: 40,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
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
