import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../widgets/centro_card.dart';
import 'centro_detail.dart';

class CentrosListScreen extends StatelessWidget {
  final AppData appData;
  final VoidCallback onRefresh;

  const CentrosListScreen({
    super.key,
    required this.appData,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centros Especializados'),
        actions: [
          IconButton(
            tooltip: 'Recargar datos',
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: appData.centros.length,
        itemBuilder: (context, index) {
          final centro = appData.centros[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CentroDetailScreen(
                  centro: centro,
                  appData: appData,
                ),
              ),
            ),
            child: CentroCard(
              centro: centro,
              association: appData.associationForCentro(centro),
            ),
          );
        },
      ),
    );
  }
}
