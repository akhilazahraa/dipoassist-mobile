import 'package:dipoassist/main_page/screens/pengaturan.dart';
import 'package:flutter/material.dart';
import 'package:dipoassist/main_page/screens/laporkan.dart';
import 'package:dipoassist/main_page/screens/beranda.dart';
import 'package:dipoassist/main_page/screens/riwayat.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Beranda(), // Beranda
    const RiwayatPage(), // Riwayat (baru)
    const Laporkan(), // Laporkan (baru)
    const PengaturanPage(), // Pengaturan
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed, // Penting untuk lebih dari 3 item
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Laporkan'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
