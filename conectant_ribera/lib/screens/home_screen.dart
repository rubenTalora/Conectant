import 'package:flutter/material.dart';
import 'centros_list.dart';
import 'mapa_centros_screen.dart';
import 'entidades_screen.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const CentrosListScreen();
      case 1:
        return const MapaCentrosScreen();
      case 2:
        return const EntidadesScreen();
      default:
        return const CentrosListScreen();
    }
  }

  void _onTabSelected(int i) {
    setState(() => _currentIndex = i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody()),
      bottomNavigationBar:
          BottomNav(onTabSelected: _onTabSelected, currentIndex: _currentIndex),
    );
  }
}
