import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final ValueChanged<int> onTabSelected;
  final int currentIndex;
  const BottomNav(
      {super.key, required this.onTabSelected, this.currentIndex = 0});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.currentIndex;
  }

  void _onTap(int i) {
    setState(() => _index = i);
    widget.onTabSelected(i);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _index,
      onTap: _onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Centros'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
        BottomNavigationBarItem(
            icon: Icon(Icons.business), label: 'Asociaciones'),
      ],
    );
  }
}
