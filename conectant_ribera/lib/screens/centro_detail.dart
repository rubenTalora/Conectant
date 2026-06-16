import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/centro.dart';
import 'association_detail.dart';

class CentroDetailScreen extends StatelessWidget {
  final Centro centro;
  final AppData appData;

  const CentroDetailScreen({
    super.key,
    required this.centro,
    required this.appData,
  });

  @override
  Widget build(BuildContext context) {
    final association = appData.associationForCentro(centro);

    return Scaffold(
      appBar: AppBar(
        title: Text(centro.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              centro.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(centro.address, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(centro.description),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/${centro.id}.png',
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 300,
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(
                              Icons.location_on,
                              size: 56,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    if (association != null) ...[
                      const Text(
                        'Asociación',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal[50],
                          child: Text(association.name[0]),
                        ),
                        title: Text(association.name),
                        subtitle: Text(association.type),
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
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
