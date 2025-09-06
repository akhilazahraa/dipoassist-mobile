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
    const Beranda(),
    const RiwayatPage(),
    const Laporkan(),
    const PengaturanPage(),
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
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white, // background flat
        elevation: 10, // sedikit shadow biar modern
        selectedItemColor: const Color(0xFF00A795), // hijau aktif
        unselectedItemColor: Colors.grey[600], // abu-abu modern
        selectedLabelStyle: const TextStyle(
          fontFamily: "Rubik",
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: "Rubik",
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
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
