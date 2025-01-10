// lib/main.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta_verse/models/reviews.dart' as review;
import 'package:meta_verse/user.dart';
import 'package:meta_verse/widgets/promo.dart';
import 'package:meta_verse/widgets/social_media.dart';
import 'package:provider/provider.dart';

// Import your widgets/models
import 'widgets/circular_layout.dart';
import 'widgets/app_bar_content.dart';
import 'widgets/chatbot_popup.dart';
import 'models/boba_store.dart'; // Keep your BobaStore list
import 'services/theme_provider.dart';
import 'login.dart';
import 'models/user_admin_page.dart';
import 'services/splash.dart';
import 'services/splash2.dart';
import 'models/profile.dart';

// --------------
//    NEW IMPORT
// --------------
import 'widgets/carousel_widget.dart'; // <--- We'll create this new widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for Flutter
  await Hive.initFlutter();

  // Register adapters if you haven't yet
  Hive.registerAdapter(UserAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // Add other providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Meta Verse',
          theme: themeProvider.currentTheme,
          initialRoute: '/splash', // Start at splash screen
          routes: {
            '/splash': (context) => SplashScreen(), // Splash1 -> user_admin
            '/splash2': (context) => Splash2(), // Sign in -> splash2 -> home
            '/user_admin': (context) => const UserAdminPage(),
            '/login': (context) => LoginPage(
                  themeProvider:
                      Provider.of<ThemeProvider>(context, listen: false),
                ),
            '/main': (context) => HomePage(toggleTheme: themeProvider.toggleTheme,
                isDarkMode: themeProvider.isDarkMode,),
            '/review': (context) => const review.ReviewsPage(),
            '/notifications': (context) => const NotificationsPage(),
            '/profile': (context) {
              // We can safely read the provider here, since we are under MultiProvider
              final themeProvider = Provider.of<ThemeProvider>(context);
              return ProfilePage(
                toggleTheme: themeProvider.toggleTheme,
                isDarkMode: themeProvider.isDarkMode,
              );
            },
            // Add other routes here if needed
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required bool isDarkMode, required void Function() toggleTheme});

  // Keep the same greeting and date functions
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  String getCurrentDate() {
    final now = DateTime.now();
    return '${now.month}/${now.day}/${now.year}'; // MM/DD/YYYY
  }

  @override
  Widget build(BuildContext context) {
    // Calculate responsive radius based on screen size
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double radius = min(screenWidth, screenHeight) / 4; // phone screens

    // Get greeting and date
    final String greeting = getGreeting();
    final String currentDate = getCurrentDate();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: AppBarContent(
          toggleTheme: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
          isDarkMode: Provider.of<ThemeProvider>(context).isDarkMode,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            // Left-align contents
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Greeting Text
              Text(
                greeting,
                style: TextStyle(
                  fontSize: 21,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontFamily: 'Roboto',
                ),
              ),
              // Current Date Text
              Text(
                currentDate,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),

              // Space so text doesn't overlap with circle
              const SizedBox(height: 150),

              // Center the circular layout
              Center(
                child: CircularLayout(
                  radius: radius,
                  centralWidget: Container(
                    width: radius,
                    height: radius,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [Colors.green.shade800, Colors.blue.shade900],
                        stops: const [0.6, 1.0],
                        center: const Alignment(-0.3, -0.3),
                        focal: const Alignment(-0.3, -0.3),
                        focalRadius: 0.1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    // child: CustomPaint(
                    //   painter: EarthPainter(),
                    //   child: Container(),
                    // ),
                  ),
                  bobaStores: bobaStores,
                ),
              ),

              // Some extra space before the carousel
              const SizedBox(height: 100),

              const CarouselWidget(),

              const SizedBox(height: 120), // Add spacing if desired

              const PromoBanner(),

               const SizedBox(height: 30), 
              
              const SocialMediaLinks(),

              const SizedBox(height: 30), 
              // ------------------------------------------------------
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger chatbot popup
          showDialog(
            context: context,
            builder: (context) => const ChatbotPopup(),
          );
        },
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        child: const Icon(Icons.chat),
      ),
      bottomNavigationBar: buildBottomNavBar(context),
    );
  }

  Widget buildBottomNavBar(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.star_half_sharp, size: 21.0),
            onPressed: () {
              Navigator.pushNamed(context, '/review');
            },
            tooltip: 'Reviews',
          ),
          IconButton(
            icon: const Icon(Icons.home, size: 21.0),
            onPressed: () {
              Navigator.pushNamed(context, '/main');
            },
            tooltip: 'Home',
          ),
          IconButton(
            icon: const Icon(Icons.qr_code, size: 30.0),
            onPressed: () {
              Navigator.pushNamed(context, '/qr_code');
            },
            tooltip: 'QR Code',
          ),
          IconButton(
            icon: const Icon(Icons.notifications, size: 21.0),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
            tooltip: 'Notifications',
          ),
          IconButton(
            icon: const Icon(Icons.person, size: 21.0),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            tooltip: 'Profile',
          ),
        ],
      ),
    );
  }
}

class QRCodePage extends StatelessWidget {
  const QRCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Implement your QR Code Page here
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code')),
      body: const Center(child: Text('QR Code Page')),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Implement your Notifications Page here
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: const Center(child: Text('Notifications Page')),
    );
  }
}

// Updated EarthPainter (no changes needed for the carousel addition)
// class EarthPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint greenPaint = Paint()
//       ..color = Colors.green.shade900
//       ..style = PaintingStyle.fill;
//     final Paint bluePaint = Paint()
//       ..color = Colors.blue.shade900
//       ..style = PaintingStyle.fill;

//     // Continents
//     Path continent1 = Path();
//     continent1.moveTo(size.width * 0.15, size.height * 0.25);
//     continent1.lineTo(size.width * 0.25, size.height * 0.2);
//     continent1.lineTo(size.width * 0.38, size.height * 0.27);
//     continent1.lineTo(size.width * 0.3, size.height * 0.38);
//     continent1.close();

//     Path continent2 = Path();
//     continent2.moveTo(size.width * 0.62, size.height * 0.48);
//     continent2.lineTo(size.width * 0.68, size.height * 0.42);
//     continent2.lineTo(size.width * 0.82, size.height * 0.48);
//     continent2.lineTo(size.width * 0.75, size.height * 0.58);
//     continent2.close();

//     Path continent3 = Path();
//     continent3.moveTo(size.width * 0.38, size.height * 0.68);
//     continent3.lineTo(size.width * 0.48, size.height * 0.63);
//     continent3.lineTo(size.width * 0.58, size.height * 0.68);
//     continent3.lineTo(size.width * 0.52, size.height * 0.78);
//     continent3.close();

//     // Draw land
//     canvas.drawPath(continent1, greenPaint);
//     canvas.drawPath(continent2, greenPaint);
//     canvas.drawPath(continent3, greenPaint);

//     // Lakes
//     Path lake1 = Path();
//     lake1.addOval(Rect.fromCircle(
//       center: Offset(size.width * 0.5, size.height * 0.5),
//       radius: size.width * 0.07,
//     ));
//     canvas.drawPath(lake1, bluePaint);

//     Path lake2 = Path();
//     lake2.addOval(Rect.fromCircle(
//       center: Offset(size.width * 0.35, size.height * 0.6),
//       radius: size.width * 0.045,
//     ));
//     canvas.drawPath(lake2, bluePaint);

//     Path lake3 = Path();
//     lake3.addOval(Rect.fromCircle(
//       center: Offset(size.width * 0.65, size.height * 0.4),
//       radius: size.width * 0.05,
//     ));
//     canvas.drawPath(lake3, bluePaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
 