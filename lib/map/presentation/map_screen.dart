import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:lottie/lottie.dart' as lottie;

import '../../chat/presentation/chat_screen.dart';
import '../model/marker_data.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  bool _isLoadingPosition = false;
  final TextEditingController _messageController = TextEditingController();
  late final _animatedMapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    cancelPreviousAnimations: true,
  );
  LatLng? _myLocation;
  List<MarkerData> _markerData = [];
  List<Marker> _markers = [];

  bool _isCurrentLocationInMarkers(
      LatLng? currentLocation, List<MarkerData> markerDataList) {
    if (currentLocation == null) return false;

    for (var marker in markerDataList) {
      if (marker.position.latitude == currentLocation.latitude &&
          marker.position.longitude == currentLocation.longitude) {
        return true;
      }
    }

    return false;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission are permanently denied');
    }

    return Geolocator.getCurrentPosition();
  }

  void _showCurrentLocation() async {
    setState(() {
      _isLoadingPosition = true;
    });
    try {
      Position position = await _determinePosition();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      _animatedMapController.animateTo(dest: currentLatLng, zoom: 16.7);
      setState(() {
        _myLocation = currentLatLng;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoadingPosition = false;
      });
    }
  }

  Future<void> _fetchLocation() async {
    try {
      Position position = await _determinePosition();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      setState(() {
        _myLocation = currentLatLng;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchLocation().then((_) {
      setState(() {});
    });
  }

  // void _addMarker(LatLng position, String message) {
  //   final markerData = MarkerData(position: position, message: message);
  //   _markerData.add(markerData);
  //   _markers.add(
  //     Marker(
  //       point: position,
  //       width: 80,
  //       height: 80,
  //       child: GestureDetector(
  //         child: Icon(
  //           Icons.location_on,
  //           color: Colors.green,
  //           size: 40,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _addMarker(BuildContext context, LatLng position) async {
    // Показываем AlertDialog для ввода названия чата
    final TextEditingController _controller = TextEditingController();
    String chatName = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Введите название чата'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Название чата'),
            onChanged: (value) {
              chatName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(chatName);
              },
              child: Text('Добавить'),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null && value.isNotEmpty) {
        final markerData = MarkerData(position: position, message: value);
        _markerData.add(markerData);
        _markers.add(
          Marker(
            point: position,
            width: 80,
            height: 80,
            child: GestureDetector(
              child: Icon(
                Icons.location_on,
                color: Colors.green,
                size: 40,
              ),
            ),
          ),
        );
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ChatScreen();
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _myLocation == null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: lottie.LottieBuilder.asset('assets/loading.json'),
              ),
            )
          : Stack(
              children: [
                FlutterMap(
                  mapController: _animatedMapController.mapController,
                  options: MapOptions(
                    interactionOptions:
                        InteractionOptions(flags: ~InteractiveFlag.rotate),
                    initialZoom: 16.7,
                    initialCenter: _myLocation!,
                    onPositionChanged: (camera, hasGesture) {
                      setState(() {
                        _myLocation = camera.center;
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.point_on_map.app',
                    ),
                    if (_myLocation != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80,
                            height: 80,
                            point: _myLocation!,
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    MarkerLayer(markers: _markers),
                  ],
                ),
                Positioned(
                  bottom: 90,
                  right: 20,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.indigo,
                    onPressed: _showCurrentLocation,
                    child: _isLoadingPosition
                        ? Padding(
                            padding: EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                              color: Colors.red,
                              strokeWidth: 3,
                            ),
                          )
                        : Icon(
                            Icons.location_searching_rounded,
                            color: Colors.red,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 8,
                  right: 8,
                  child: TextButton(
                    onPressed: () {
                      _addMarker(context, _myLocation!);
                    },
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Начать чат в этом месте',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
