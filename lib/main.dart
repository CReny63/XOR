//import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
//import 'package:geocoding/geocoding.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:intl/intl.dart'; //to fetch real world time
import 'package:flutter/material.dart';
import 'package:meta_verse/models/bottom_bar.dart';
import 'package:provider/provider.dart';
import 'dart:async';
//import '3d_object.dart';
import 'widgets/Greeting.dart';
import 'login.dart';
import 'models/profile.dart';
import 'models/reviews.dart';
import 'services/QRCode.dart';
import 'services/theme_provider.dart';
import 'models/notifications.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:qr_flutter/qr_flutter.dart'; //fetch qr code api
import 'services/location.dart';
import 'services/splash.dart';
import 'services/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/chatbot.dart';

Future<void> main() async {
  // Ensure that Flutter bindings are initialized before using Hive
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and HiveStorage before running the app
  await Hive.initFlutter();
  await HiveStorage
      .initHive(); // Make sure the HiveStorage class initializes the box

  // Now run the app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        //ChangeNotifierProvider(create: (_) => LocationPage()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    
   
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
        
          theme: themeProvider.currentTheme,
          initialRoute: '/splash', // Start at login page
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/login': (context) => LoginPage(
                  themeProvider: ThemeProvider(),
                ),
            '/main': (context) => HomePage(
                  toggleTheme: themeProvider.toggleTheme,
                  isDarkMode: themeProvider.isDarkMode,
                ),
            '/review': (context) => const ReviewsPage(),
            '/notifications': (context) => const NotificationsPage(),
            '/profile': (context) => ProfilePage(
                  toggleTheme: themeProvider.toggleTheme,
                  isDarkMode: themeProvider.isDarkMode,
                ),
          },
          debugShowCheckedModeBanner: false,
          // Set the home as Scaffold to include floating action button
          home: Scaffold(
            
            appBar: AppBar(title: const Text('Home Page')),
            body: HomePage(
              toggleTheme: themeProvider.toggleTheme,
              isDarkMode: themeProvider.isDarkMode,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Trigger chatbot popup
                showDialog(
                  context: context,
                  builder: (context) => ChatbotPopup(),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.chat),
            ),
          ),
        );
      },
    );
  }
}

class BobaStores {
  late String name;
  late String _imageName; // Private variable for image name
  String get imageName => _imageName; //getter

  // Constructor
  BobaStores({required this.name, required String imageName}) {
    _imageName = imageName;
  }
}

List<BobaStores> bobaSearch = [
  //list of boba stores for search
  BobaStores(name: 'Share Tea', imageName: 'share_tea'),
  BobaStores(name: 'Bubble Tea', imageName: 'bubble_tea'),
  BobaStores(name: 'Happy Lemon', imageName: 'happy_lemon_'),
  BobaStores(name: 'Kung Fu', imageName: 'kung_fu'),
  BobaStores(name: 'Nintai Tea', imageName: 'nintai_tea'),
  BobaStores(name: 'Serenitea', imageName: 'serenitea'),
  BobaStores(name: 'Tea Amo', imageName: 'tea_amo'),
  BobaStores(name: 'Vivi Tea', imageName: 'vivi_tea'),
  BobaStores(name: 'Ding Tea', imageName: 'ding_tea'),
];

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomePage(
      {super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

Widget _buildBottomNavItem(
  BuildContext context,
  IconData iconData,
  String label,
  VoidCallback onTap, {
  double iconSize = 24.0,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          size: iconSize,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
      ],
    ),
  );
}

//CALL QRCODE HERE
void _goToQRCodePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => QRCodePage()), // Navigate to QRCodePage
  );
}

//call show settings!
_showSettingsMenu(context) {
  // TODO: implement _showSettingsMenu
  throw UnimplementedError();
}

List<String> selectedItems = [];

void _showPopupMenu(BuildContext context, String title, String imageAsset,
    List<String> selectedItems) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
          void removeItem(String item) {
            stateSetter(() {
              selectedItems.remove(item);
            });
          }

          void addItem(String item) {
            stateSetter(() {
              if (!selectedItems.contains(item)) {
                selectedItems.add(item);
              }
            });
          }

          return Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display selected items
                if (selectedItems.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(selectedItems[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            removeItem(selectedItems[index]);
                          },
                        ),
                      );
                    },
                  ),

                // Add "View Order" button if there are selected items
                if (selectedItems.isNotEmpty)
                  ListTile(
                    title: const Text('View Order'),
                    trailing: const Icon(Icons.shopping_cart),
                    onTap: () {
                      _viewOrder(context);
                    },
                  ),

                // Add close button
                ListTile(
                  title: const Text('Close'),
                  trailing: const Icon(Icons.close),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void _viewOrder(BuildContext context) {
  // Implement view order functionality here
  //print('View Order clicked!');
}

String greeting = getGreeting(); //call greeting func
String currentDate = getCurrentDate(); //call date func

class AppBarContent extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const AppBarContent({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    //final locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              color: Theme.of(context).appBarTheme.backgroundColor,
              padding: const EdgeInsets.symmetric(
                  horizontal: 12), // Optional: Add padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu,
                        size: 13,
                        color: Theme.of(context).appBarTheme.iconTheme?.color),
                    onPressed: () {
                      _showSettingsMenu(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.coffee,
                        size: 13,
                        color: Theme.of(context).appBarTheme.iconTheme?.color),
                    onPressed: () {
                      // Add your custom action here
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      final themeProvider =
                          Provider.of<ThemeProvider>(context, listen: false);
                      themeProvider.toggleTheme();
                    },
                    child: IconButton(
                      icon: Icon(Icons.settings_accessibility_outlined,
                          size: 13,
                          color:
                              Theme.of(context).appBarTheme.iconTheme?.color),
                      onPressed: () {
                        _showSettingsMenu(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List<BobaStores> filteredBobaStores = [];
  OverlayEntry? overlayEntry;

  void _showLocationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPage(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  //  WidgetsBinding.instance.addPostFrameCallback((_) { //make sure it pops up with home page
     // _showLocationPage();//call location.dart funcs
   // });
    filteredBobaStores.addAll(bobaSearch);
  }

  void hideOverlay() {
    setState(() {
      isOverlayVisible = false;
    });

    overlayEntry?.remove();
    overlayEntry = null;
  }

  bool isOverlayVisible = false;
  void showOverlay(BuildContext context) {
    if (filteredBobaStores.isEmpty || searchController.text.isEmpty) {
      // Don't show the overlay if there are no search results or no text in the search bar
      hideOverlay();
      return;
    }

    setState(() {
      isOverlayVisible = true;
    });

    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(
        builder: (context) => Visibility(
          visible: isOverlayVisible,
          child: Positioned(
            top: 130,
            left: 40,
            right: 60,
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredBobaStores.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          filteredBobaStores[index].name,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 206, 189, 152),
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      Future.delayed(Duration.zero, () {
        Overlay.of(context).insert(overlayEntry!);
      });
    } else {
      overlayEntry?.markNeedsBuild(); // Update the overlay if it already exists
    }
  }

  get backgroundColor => null;
//Password: Carrots1234
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: AppBarContent(
            toggleTheme: widget.toggleTheme,
            isDarkMode: widget.isDarkMode,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor, //main

        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                // Simulate scanning by showing the progress bar
                // _qrCodeProgressWidgetKey.currentState?.showProgressBar();
              },
              key:
                  UniqueKey(), //using a unique key to make sure gdet has a unique key
            ),
            PreferredSize(
              preferredSize: const Size.fromHeight(90),
              child: Container(),
            ),
            // const SizedBox(height: 150),

            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 70,
                    width: double.infinity,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getGreeting(), // call greeting func
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          Text(
                            getCurrentDate(), // call date func
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (searchController.text.isEmpty)
                        SizedBox(
                          height: 300.0,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                bobaSearch.length,
                                (index) => Container(
                                  margin: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClickableMenuItem(
                                        name: bobaSearch[index].name,
                                        imageName:
                                            'assets/${bobaSearch[index].imageName}.png',
                                        labelText: 'Label Text',
                                        child: Text(
                                          bobaSearch[index].name,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 15,
                                        child: GestureDetector(
                                          onTap: () {
                                            // Handle the click on the plus icon
                                            _showPopupMenu(
                                              context,
                                              bobaSearch[index].name,
                                              'assets/${bobaSearch[index].imageName}.png',
                                              selectedItems,
                                              //addItem(bobaSearch[index].name);
                                            );
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 12.0,
                                            child: Icon(
                                              Icons.add,
                                              size: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Additional containers below the scrollable list
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // Scrollable view of containers
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(10, (index) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 206, 189, 152),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          width: 2), // Black border
                                      borderRadius: BorderRadius.circular(
                                          12), // Rounded corners
                                    ),
                                    child: Center(
                                      child: Text('Item $index'),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 20, // Adjust height as needed
                        color: Colors.white,
                        child: const Padding(
                          padding:
                              EdgeInsets.all(8.0), // Adjust padding as needed
                        ),
                      ),
                      Container(
                        height: 330,
                        color: const Color.fromARGB(255, 206, 189, 152),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Featured Items:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      9,
                                      (index) {
                                        List<String> predefinedTitles = [
                                          "Share Tea",
                                          "Ding Tea",
                                          "Tea Amo",
                                          "Vivi Tea",
                                          "Serenitea",
                                          "Nintai Tea",
                                          "Kung Fu Tea",
                                          "Happy Lemon",
                                          "Bubble Tea",
                                        ];
                                        String title = predefinedTitles[
                                            index % predefinedTitles.length];
                                        String imageAsset =
                                            'assets/menu_item_$index.png';
                                        return Container(
                                          width:
                                              200, // Adjust the width according to your needs
                                          margin:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    title,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Container(
                                                    width: 150,
                                                    height: 180,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            imageAsset),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // Action when Buy button is pressed
                                                      // You can customize this according to your needs
                                                    },
                                                    child: const Text(
                                                      "Order for Pick Up",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Positioned(
                                                top: 12.0,
                                                right: 39.0,
                                                child: SizedBox(
                                                  width: 24.0,
                                                  height: 24.0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      // Handle the click on the plus icon
                                                      _showPopupMenu(
                                                          context,
                                                          title,
                                                          imageAsset,
                                                          selectedItems);
                                                    },
                                                    child: const CircleAvatar(
                                                      backgroundColor:
                                                          Colors.black,
                                                      radius: 12.0,
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 10,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 5,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: const Padding(
                          padding:
                              EdgeInsets.all(8.0), // Adjust padding as needed
                          child: Align(
                            alignment: Alignment.topLeft,
                          ),
                        ),
                      ),
                      Container(
                        height: 10,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: const Padding(
                          padding:
                              EdgeInsets.all(8.0), // Adjust padding as needed
                          child: Align(
                            alignment: Alignment.topLeft,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: buildBottomNavBar(context), // Call bottombar func
      ),
    );
  }
}

class ClickableMenuItem extends StatefulWidget {
  final String name;
  final String imageName;
  final String labelText;
  final List<BoxShadow> initialBoxShadow;
  final child; // Added labelText property

  const ClickableMenuItem({
    super.key,
    required this.name,
    required this.imageName,
    required this.labelText,
    this.initialBoxShadow = const [],
    this.child,
    //required List<BoxShadow> boxShadow,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ClickableMenuItemState createState() => _ClickableMenuItemState();
}

class _ClickableMenuItemState extends State<ClickableMenuItem> {
  bool isSelected = false;
  late List<BoxShadow> boxShadow;

  TextEditingController nameController = TextEditingController();
  TextEditingController labelTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    labelTextController.text = widget.labelText;
    boxShadow = widget.initialBoxShadow;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        key: UniqueKey(),
        width: 200.0,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 206, 189, 152),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            // Circular App Bar-like structure
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 206, 189, 152),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: const EdgeInsets.all(5.8),
              height: 45, //MUST BE AT LEAST 50
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        widget.name,
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),

            // Item Content
            SizedBox(
              child: Center(
                child: Image.asset(
                  widget.imageName,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover, //imgs have same dimensions!
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Function to update boxShadow dynamically
  void updateBoxShadow(List<BoxShadow> newBoxShadow) {
    setState(() {
      boxShadow = newBoxShadow;
    });
  }
}
