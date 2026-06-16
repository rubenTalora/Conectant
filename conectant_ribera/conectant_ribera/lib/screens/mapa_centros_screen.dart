import 'package:flutter/material.dart';

class MapaCentrosScreen extends StatelessWidget {
  const MapaCentrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de Centros')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Mapa de Centros',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('En desarrollo...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
