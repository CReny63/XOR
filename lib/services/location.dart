import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

class LocationProvider with ChangeNotifier {
  GoogleMapController? _mapController;
  LatLng _initialPosition = const LatLng(37.7749, -122.4194); // Default to San Francisco
  Set<Marker> _markers = {};

  String? _location;

  LatLng get initialPosition => _initialPosition;
  Set<Marker> get markers => _markers;
  bool get hasMapController => _mapController != null;

  void setLocation(String location) {
    _location = location;
  }

  Future<void> fetchLocation() async {
    if (_location == null || _location!.isEmpty) return;

    try {
      List<Location> locations = await locationFromAddress(_location!);
      if (locations.isNotEmpty) {
        _initialPosition = LatLng(locations[0].latitude, locations[0].longitude);

        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('location'),
            position: _initialPosition,
          ),
        );

        _mapController?.animateCamera(
          CameraUpdate.newLatLng(_initialPosition),
        );

        notifyListeners();
      }
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('City/Zipcode Search'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog(context);
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 2,
        ),
        onMapCreated: (controller) {
          locationProvider._mapController;
        },
        markers: locationProvider.markers,
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter City or Zipcode'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'City or Zipcode',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final locationProvider = Provider.of<LocationProvider>(context, listen: false);
                locationProvider._location!;
                Navigator.of(context).pop();
              },
              child: Text('Search'),
            ),
          ],
        );
      },
    );
  }
}
