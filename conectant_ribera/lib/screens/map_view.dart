import 'package:flutter/material.dart';

class MapView extends StatelessWidget {
  final double lat;
  final double lng;
  final String? title;
  const MapView({super.key, required this.lat, required this.lng, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text('Mapa - En desarrollo', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
