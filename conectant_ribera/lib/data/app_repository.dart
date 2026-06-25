import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/association.dart';
import '../models/centro.dart';
import 'app_data.dart';
import 'supabase_config.dart';

class AppRepository {
  final SupabaseClient _client;

  AppRepository({SupabaseClient? client})
      : _client = client ?? SupabaseConfig.client;

  Future<AppData> loadAppData() async {
    final client = _client;

    try {
      final savedItems = await client
          .from('saved_items')
          .select()
          .order('created_at', ascending: false);

      print('DEBUG: savedItems count: ${savedItems.length}');
      print('DEBUG: savedItems: $savedItems');

      final centros = savedItems
          .where((item) => item['type'] == 'centro')
          .map<Centro>((row) => Centro.fromSavedItem(row))
          .toList();

      final associations = savedItems
          .where((item) => item['type'] == 'entidad')
          .map<Association>((row) => Association.fromSavedItem(row))
          .toList();

      print('DEBUG: centros count: ${centros.length}');
      print('DEBUG: associations count: ${associations.length}');

      return AppData(
        centros: centros,
        associations: associations,
      );
    } catch (e) {
      print('ERROR loading app data: $e');
      rethrow;
    }
  }
}
