import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/centro_card.dart';
import 'centro_detail.dart';

class CentrosListScreen extends StatelessWidget {
  const CentrosListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centros Especializados'),
      ),
      body: ListView.builder(
        itemCount: centros.length,
        itemBuilder: (context, index) {
          final centro = centros[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CentroDetailScreen(centro: centro),
              ),
            ),
            child: CentroCard(centro: centro),
          );
        },
      ),
    );
  }
}
