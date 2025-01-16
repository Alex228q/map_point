import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:map_point/widgets/chat_icon.dart';
import 'chat_screen.dart';
import '../models/marker_data.dart';
import 'dart:math' as math;

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
  final List<MarkerData> _markerData = [];
  final List<Marker> _markers = [];

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
    } catch (_) {
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
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    _fetchLocation().then((_) {
      setState(() {});
    });
  }

  double calculateDistance(LatLng pos1, LatLng pos2) {
    const double earthRadius = 6371000;

    double lat1 = pos1.latitude;
    double lon1 = pos1.longitude;
    double lat2 = pos2.latitude;
    double lon2 = pos2.longitude;

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  double _toRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  void _addMarker(BuildContext context, LatLng position) async {
    const double minDistance = 50;
    bool isTooClose = _markerData.any((marker) {
      double distance = calculateDistance(marker.position, position);
      return distance < minDistance;
    });

    if (isTooClose) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Минимальное расстояние от другого чата 50 метров!'),
        ),
      );
      return;
    }

    final TextEditingController controller = TextEditingController();
    String chatName = '';

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return LayoutBuilder(builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight * 0.8,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Тема чата',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 30,
                  controller: controller,
                  onChanged: (value) {
                    chatName = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Введите тему чата',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Закрыть модальное окно
                      },
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(chatName); // Вернуть chatName
                      },
                      child: const Text('Добавить'),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    ).then((value) {
      if (value != null && value.isNotEmpty) {
        final markerData = MarkerData(position: position, topik: value);
        _markerData.add(markerData);
        _markers.add(
          Marker(
            point: position,
            width: 80,
            height: 80,
            child: GestureDetector(
              onTap: () {
                _animatedMapController.animateTo(dest: position, zoom: 16.7);
              },
              onDoubleTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) {
                      return ChatScreen(chatTitle: value);
                    },
                  ),
                );
              },
              child: ChatIcon(
                title: value,
              ),
            ),
          ),
        );
        if (context.mounted) {
          FocusScope.of(context).unfocus();

          Future.delayed(const Duration(milliseconds: 300), () {
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatScreen(
                      chatTitle: value,
                    );
                  },
                ),
              );
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _myLocation == null
          ? Container(
              decoration: const BoxDecoration(
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
                    interactionOptions: const InteractionOptions(
                        flags: ~InteractiveFlag.rotate),
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
                            child: const Icon(
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
                        ? const Padding(
                            padding: EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                              color: Colors.red,
                              strokeWidth: 3,
                            ),
                          )
                        : const Icon(
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
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Начать чат в этом месте',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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
