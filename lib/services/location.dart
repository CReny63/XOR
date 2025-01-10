// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc; // Alias for location package
// import 'package:permission_handler/permission_handler.dart' as perm;
// import 'package:permission_handler/permission_handler.dart';

// class LocationPage extends StatefulWidget {
//   @override
//   _LocationPageState createState() => _LocationPageState();
// }

// class _LocationPageState extends State<LocationPage> {
//   loc.LocationData? _currentLocation;
//   Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();
//     _checkPermissions();
//   }

//   /// Check and request location permissions
//   Future<void> _checkPermissions() async {
//     final loc.Location location = loc.Location();

//     // Requesting location permissions using permission_handler
//     PermissionStatus permissionStatus = await perm.Permission.location.request();

//     if (permissionStatus.isDenied) {
//       _showPermissionDialog();
//       return;
//     }

//     // Check if location services are enabled
//     bool serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         _showServiceErrorDialog();
//         return;
//       }
//     }

//     // Retrieve the current location if permissions are granted
//     _getCurrentLocation();
//   }

//   /// Retrieve the user's current location
//   Future<void> _getCurrentLocation() async {
//     final loc.Location location = loc.Location();

//     try {
//       final loc.LocationData currentLocation = await location.getLocation();
//       setState(() {
//         _currentLocation = currentLocation;
//         _addMarker(LatLng(currentLocation.latitude!, currentLocation.longitude!));
//       });

//       _getNearbyBobaShops(currentLocation.latitude!, currentLocation.longitude!);
//     } catch (e) {
//       _showServiceErrorDialog();
//     }
//   }

//   /// Add a marker to the map
//   void _addMarker(LatLng position) {
//     _markers.add(
//       Marker(
//         markerId: MarkerId('current_location'),
//         position: position,
//         infoWindow: const InfoWindow(title: 'Your Location'),
//       ),
//     );
//     setState(() {});
//   }

//   /// Mock and display nearby boba shops within a 5-mile radius
//   void _getNearbyBobaShops(double latitude, double longitude) {
//     List<Map<String, dynamic>> bobaShops = [
//       {"name": "Boba Place 1", "lat": latitude + 0.01, "lng": longitude + 0.01},
//       {"name": "Boba Place 2", "lat": latitude + 0.02, "lng": longitude - 0.02},
//       {"name": "Boba Place 3", "lat": latitude - 0.01, "lng": longitude - 0.01},
//     ];

//     for (var shop in bobaShops) {
//       double distance = _calculateDistance(latitude, longitude, shop['lat'], shop['lng']);
//       if (distance <= 5.0) {
//         _markers.add(
//           Marker(
//             markerId: MarkerId(shop['name']),
//             position: LatLng(shop['lat'], shop['lng']),
//             infoWindow: InfoWindow(title: shop['name']),
//           ),
//         );
//       }
//     }

//     setState(() {});
//   }

//   /// Calculate the distance between two points in miles
//   double _calculateDistance(double lat1, double lng1, double lat2, double lng2) {
//     const double R = 3958.8; // Radius of Earth in miles
//     double dLat = _degToRad(lat2 - lat1);
//     double dLng = _degToRad(lng2 - lng1);
//     double a = sin(dLat / 2) * sin(dLat / 2) +
//         cos(_degToRad(lat1)) * cos(_degToRad(lat2)) * sin(dLng / 2) * sin(dLng / 2);
//     double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     return R * c;
//   }

//   /// Convert degrees to radians
//   double _degToRad(double deg) {
//     return deg * (pi / 180);
//   }

//   /// Show an error dialog if location services are disabled
//   void _showServiceErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Service Disabled'),
//           content: const Text('Please enable location services to use this feature.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   /// Show a dialog if location permissions are denied
//   void _showPermissionDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Permission Required'),
//           content: const Text('We need access to your location to show nearby boba shops.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Grant Permission'),
//               onPressed: () {
//                 Navigator.pop(context);
//                 _checkPermissions();
//               },
//             ),
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Nearby Boba Shops')),
//       body: _currentLocation == null
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
//                 zoom: 14,
//               ),
//               onMapCreated: (GoogleMapController controller) {
//               },
//               markers: _markers,
//             ),
//     );
//   }
// }
