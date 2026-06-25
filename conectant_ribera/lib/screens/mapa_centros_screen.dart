import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../data/app_repository.dart';
import '../models/centro.dart';

class MapaCentrosScreen extends StatefulWidget {
  const MapaCentrosScreen({super.key});

  @override
  State<MapaCentrosScreen> createState() => _MapaCentrosScreenState();
}

class _MapaCentrosScreenState extends State<MapaCentrosScreen> {
  final AppRepository _repository = AppRepository();
  List<Centro> _centros = [];
  bool _isLoading = true;
  String? _error;
  Centro? _selectedCentro;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _loadCentros();
  }

  Future<void> _loadCentros() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final appData = await _repository.loadAppData();
      setState(() {
        _centros = appData.centros;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _selectCentro(Centro centro) {
    setState(() {
      _selectedCentro = centro;
    });
    _mapController.move(
      LatLng(centro.lat, centro.lng),
      15.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Centros'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Error al cargar los datos',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadCentros,
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: _centros.isNotEmpty
                              ? LatLng(_centros.first.lat, _centros.first.lng)
                              : const LatLng(40.4168, -3.7038),
                          initialZoom: 13.0,
                          onTap: (_, __) {
                            setState(() {
                              _selectedCentro = null;
                            });
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                'com.example.conectant_ribera',
                          ),
                          MarkerLayer(
                            markers: _centros.map((centro) {
                              final isSelected =
                                  _selectedCentro?.id == centro.id;
                              return Marker(
                                width: 40,
                                height: 40,
                                point: LatLng(centro.lat, centro.lng),
                                child: GestureDetector(
                                  onTap: () {
                                    _selectCentro(centro);
                                  },
                                  child: Icon(
                                    Icons.location_on,
                                    color:
                                        isSelected ? Colors.red : Colors.teal,
                                    size: 40,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 280,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 0.2),
                              ),
                            ),
                            child: const Text(
                              'Centros en el Mapa',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: _centros.length,
                              itemBuilder: (context, index) {
                                final centro = _centros[index];
                                final isSelected =
                                    _selectedCentro?.id == centro.id;
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  elevation: isSelected ? 4 : 1,
                                  color: isSelected
                                      ? Colors.teal.withOpacity(0.1)
                                      : null,
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.location_on,
                                      color:
                                          isSelected ? Colors.red : Colors.teal,
                                    ),
                                    title: Text(
                                      centro.name,
                                      style: TextStyle(
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(centro.address),
                                        const SizedBox(height: 2),
                                        Text(
                                          centro.description,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () => _selectCentro(centro),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
