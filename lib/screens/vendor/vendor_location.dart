import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';

class VendorLocationPage extends StatefulWidget {
  @override
  _VendorLocationPageState createState() => _VendorLocationPageState();
}

class _VendorLocationPageState extends State<VendorLocationPage> {
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _requestLocationPermissionAndFetch();
  }

  Future<void> _requestLocationPermissionAndFetch() async {
    loc.Location location = loc.Location();

    // Check if service is enabled.
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    // Check for permissions.
    loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }

    // Get current location.
    loc.LocationData locData = await location.getLocation();
    setState(() {
      _currentLocation = LatLng(locData.latitude!, locData.longitude!);
    });
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 15);
    }
  }

  Future<void> _searchLocation() async {
    String query = _searchController.text;
    if (query.isEmpty) return;
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        final LatLng latLng = LatLng(location.latitude, location.longitude);
        _mapController.move(latLng, 15);
      }
    } catch (e) {
      print("Error in geocoding: $e");
      // Optionally, display an error message.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Extend body behind system overlays.
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen background image.
          Image.asset('assets/vendor_bg.png', fit: BoxFit.cover),
          // Content overlay.
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                // Header text: "Choose. your. Center." with "Center." in green.
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Choose. your. ',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Center.',
                        style: TextStyle(color: Color(0xFF1BA133)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Search field.
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search your location',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onSubmitted: (value) => _searchLocation(),
                ),
                SizedBox(height: 20),
                // Map view using flutter_map.
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      _currentLocation == null
                          ? Center(child: CircularProgressIndicator())
                          : FlutterMap(
                            mapController: _mapController,
                            options: MapOptions(
                              initialCenter: _currentLocation ?? LatLng(0, 0),
                              initialZoom: 15,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c'],
                                // Removed attribution parameter.
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: _currentLocation!,
                                    child: Icon(
                                      Icons.location_on,
                                      color: Color(0xFF1BA133),
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                ),
                SizedBox(height: 20),
                // Proceed button.
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your navigation logic to proceed here.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1BA133),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Proceed',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
