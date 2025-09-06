import 'package:dipoassist/main_page/screens/phrases.dart';
import 'package:dipoassist/services/auth_service.dart';
import 'package:flutter/material.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  late Future<Map<String, dynamic>?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = AuthService.getUser();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Latar belakang hijau
          Container(
            height: screenHeight * 0.35,
            decoration: const BoxDecoration(
              color: Color(0xFF00A795),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Header Kustom ---
                    FutureBuilder<Map<String, dynamic>?>(
                      future: _userFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }

                        if (!snapshot.hasData) {
                          return _buildCustomHeader(name: "User");
                        }

                        final user = snapshot.data!;
                        final name = user["name"] ?? "User";
                        return _buildCustomHeader(name: name);
                      },
                    ),
                    const SizedBox(height: 20),

                    // --- Kartu Prediksi Utama ---
                    _buildPredictionCard(),
                    const SizedBox(height: 30),

                    // --- Tombol Aksi Cepat ---
                    _buildActionButtons(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Header custom (dynamic name)
  Widget _buildCustomHeader({required String name}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selamat Datang,',
                style: TextStyle(
                  fontFamily: 'Figtree',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'Figtree',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white, size: 28),
            onPressed: () {
              // TODO: Aksi ke halaman pengaturan
            },
          ),
        ],
      ),
    );
  }

  // Kartu Prediksi
  Widget _buildPredictionCard() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.show_chart_rounded,
              size: 120,
              color: const Color(0xFF00A795).withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Prediksi Kata:',
              style: TextStyle(
                fontFamily: 'Figtree',
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Panggil Dokter',
              style: TextStyle(
                fontFamily: 'Figtree',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tombol Aksi Cepat
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
          context: context,
          icon: Icons.bar_chart_rounded,
          label: 'Riwayat Sinyal',
          onTap: () {},
        ),
        _buildActionButton(
          context: context,
          icon: Icons.warning_amber_rounded,
          label: 'Laporkan Masalah',
          onTap: () {},
        ),
        _buildActionButton(
          context: context,
          icon: Icons.tune_rounded,
          label: 'Pilih Kata / Frasa',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PhrasesScreen()),
            );
          },
        ),
      ],
    );
  }

  // Widget tombol aksi
  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF00A795), size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Figtree',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
