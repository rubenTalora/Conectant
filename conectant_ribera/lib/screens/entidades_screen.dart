import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import 'association_detail.dart';

class EntidadesScreen extends StatelessWidget {
  const EntidadesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (associations.isEmpty) {
      return const Center(child: Text('No hay asociaciones disponibles'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: associations.length,
      itemBuilder: (context, i) {
        final association = associations[i];
        final linkedCentros = centrosForAssociation(association);

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
    );
  }
}
