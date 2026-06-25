import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_credentials.dart';

class SupabaseConfig {
  static const url = SupabaseCredentials.url;
  static const anonKey = SupabaseCredentials.anonKey;

  static bool get isConfigured =>
      url.isNotEmpty &&
      url != 'https://TU-PROYECTO.supabase.co' &&
      anonKey.isNotEmpty &&
      anonKey != 'TU_ANON_KEY';

  static Future<void> initialize() async {
    if (!isConfigured) {
      throw StateError(
        'Supabase no está configurado. Edita lib/data/supabase_credentials.dart con tu URL y anon key.',
      );
    }

    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }

  static SupabaseClient get client {
    if (!isConfigured) {
      throw StateError(
        'Supabase no está configurado. Edita lib/data/supabase_credentials.dart con tu URL y anon key.',
      );
    }
    return Supabase.instance.client;
  }
}
