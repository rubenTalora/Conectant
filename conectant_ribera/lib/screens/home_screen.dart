import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../data/app_repository.dart';
import '../widgets/bottom_nav.dart';
import 'centros_list.dart';
import 'entidades_screen.dart';
import 'mapa_centros_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<AppData> _appDataFuture;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _appDataFuture = AppRepository().loadAppData();
  }

  void _refreshData() {
    setState(_loadData);
  }

  Widget _buildBody(AppData appData) {
    switch (_currentIndex) {
      case 0:
        return CentrosListScreen(appData: appData, onRefresh: _refreshData);
      case 1:
        return const MapaCentrosScreen();
      case 2:
        return EntidadesScreen(appData: appData, onRefresh: _refreshData);
      default:
        return CentrosListScreen(appData: appData, onRefresh: _refreshData);
    }
  }

  void _onTabSelected(int i) {
    setState(() => _currentIndex = i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<AppData>(
          future: _appDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return _LoadErrorView(
                error: snapshot.error,
                onRetry: _refreshData,
              );
            }

            return _buildBody(snapshot.data!);
          },
        ),
      ),
      bottomNavigationBar: BottomNav(
        onTabSelected: _onTabSelected,
        currentIndex: _currentIndex,
      ),
    );
  }
}

class _LoadErrorView extends StatelessWidget {
  final Object? error;
  final VoidCallback onRetry;

  const _LoadErrorView({
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            const Text(
              'No se han podido cargar los datos de Supabase.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ??
                  'Revisa la URL, la clave pública y las políticas de lectura.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
