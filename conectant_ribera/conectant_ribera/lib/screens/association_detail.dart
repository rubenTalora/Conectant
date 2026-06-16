import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/association.dart';
import 'centro_detail.dart';

class AssociationDetailScreen extends StatelessWidget {
  final Association association;
  final AppData appData;

  const AssociationDetailScreen({
    super.key,
    required this.association,
    required this.appData,
  });

  @override
  Widget build(BuildContext context) {
    final linkedCentros = appData.centrosForAssociation(association);

    return Scaffold(
      appBar: AppBar(
        title: Text(association.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.teal[50],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        association.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Chip(
                        label: Text(association.type),
                        backgroundColor: Colors.teal,
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.domain,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${linkedCentros.length} centro${linkedCentros.length == 1 ? '' : 's'} asociado${linkedCentros.length == 1 ? '' : 's'}',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Descripción',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                association.description,
                style: TextStyle(color: Colors.grey[700], height: 1.6),
              ),
              const SizedBox(height: 24),
              const Text(
                'Información de Contacto',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: Text(association.contact),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.language),
                title: const Text('Sitio Web'),
                subtitle: Text(association.website),
              ),
              const SizedBox(height: 24),
              const Text(
                'Centros asociados',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              if (linkedCentros.isEmpty)
                const Text(
                  'Sin centros asociados',
                  style: TextStyle(color: Colors.grey),
                )
              else
                Card(
                  child: Column(
                    children: linkedCentros.map((centro) {
                      return ListTile(
                        leading: const Icon(Icons.domain),
                        title: Text(centro.name),
                        subtitle: Text(centro.address),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CentroDetailScreen(
                                centro: centro,
                                appData: appData,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
