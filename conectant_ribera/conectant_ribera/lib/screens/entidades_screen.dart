import 'package:flutter/material.dart';

import '../data/app_data.dart';
import 'association_detail.dart';

class EntidadesScreen extends StatelessWidget {
  final AppData appData;
  final VoidCallback onRefresh;

  const EntidadesScreen({
    super.key,
    required this.appData,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (appData.associations.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Asociaciones'),
          actions: [
            IconButton(
              tooltip: 'Recargar datos',
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: const Center(child: Text('No hay asociaciones disponibles')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asociaciones'),
        actions: [
          IconButton(
            tooltip: 'Recargar datos',
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: appData.associations.length,
        itemBuilder: (context, i) {
          final association = appData.associations[i];
          final linkedCentros = appData.centrosForAssociation(association);

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AssociationDetailScreen(
                      association: association,
                      appData: appData,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      association.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${association.type} · ${linkedCentros.length} centro${linkedCentros.length == 1 ? '' : 's'}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (linkedCentros.isEmpty)
                      const Text(
                        'Sin centros asociados',
                        style: TextStyle(color: Colors.grey),
                      )
                    else
                      Column(
                        children: linkedCentros.map((centro) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundColor: Colors.teal[50],
                              child: Text(centro.name[0].toUpperCase()),
                            ),
                            title: Text(centro.name),
                            subtitle: Text(centro.address),
                            trailing: const Icon(Icons.chevron_right),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
