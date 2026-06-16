import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/association.dart';
import '../models/centro.dart';
import 'app_data.dart';
import 'supabase_config.dart';

class AppRepository {
  final SupabaseClient? _client;

  AppRepository({SupabaseClient? client})
      : _client = client ?? SupabaseConfig.client;

  Future<AppData> loadAppData() async {
    final client = _client;
    if (client == null) {
      throw StateError(
        'Supabase no está configurado. Lanza la app con SUPABASE_URL y SUPABASE_ANON_KEY.',
      );
    }

    final associationRows =
        await client.from('associations').select().order('name');
    final centroRows = await client.from('centros').select().order('name');

    return AppData(
      centros: centroRows.map<Centro>((row) => Centro.fromMap(row)).toList(),
      associations: associationRows
          .map<Association>(
            (row) => Association.fromMap(row),
          )
          .toList(),
    );
  }
}
