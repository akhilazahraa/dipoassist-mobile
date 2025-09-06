import 'package:flutter/material.dart';

class Beranda extends StatelessWidget {
  const Beranda({super.key});

  @override
  Widget build(BuildContext context) {
    // Ukuran layar untuk penyesuaian dinamis
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // Kita menggunakan Stack untuk menumpuk widget
      // 1. Latar belakang hijau di bagian bawah
      // 2. Konten utama di bagian atas
      body: Stack(
        children: [
          // Lapisan 1: Latar Belakang Hijau di Atas
          Container(
            height: screenHeight * 0.35, // Latar belakang hijau mengisi 35% atas layar
            decoration: const BoxDecoration(
              color: Color(0xFF00A795), // Warna hijau toska
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          // Lapisan 2: Konten Utama yang bisa di-scroll
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Header Kustom ---
                    _buildCustomHeader(),
                    const SizedBox(height: 20),

                    // --- Kartu Prediksi Utama ---
                    _buildPredictionCard(),
                    const SizedBox(height: 30),

                    // --- Tombol Aksi Cepat ---
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk header "Selamat Datang" dan ikon pengaturan
  Widget _buildCustomHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang,',
                style: TextStyle(
                  fontFamily: 'Figtree',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                'Nanda!',
                style: TextStyle(
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
              // TODO: Tambahkan aksi saat ikon pengaturan ditekan
            },
          ),
        ],
      ),
    );
  }

  // Widget untuk kartu besar di tengah
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
            // Placeholder untuk grafik sinyal
            // Ganti Icon ini dengan Image.asset atau package chart seperti fl_chart
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

  // Widget untuk baris tombol aksi (Riwayat, Laporkan, Pilih)
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
          icon: Icons.bar_chart_rounded,
          label: 'Riwayat Sinyal',
          onTap: () {
            // TODO: Aksi saat tombol Riwayat Sinyal ditekan
          },
        ),
        _buildActionButton(
          icon: Icons.warning_amber_rounded,
          label: 'Laporkan Masalah',
          onTap: () {
            // TODO: Aksi saat tombol Laporkan Masalah ditekan
          },
        ),
        _buildActionButton(
          icon: Icons.tune_rounded,
          label: 'Pilih Kata / Frasa',
          onTap: () {
            // TODO: Aksi saat tombol Pilih ditekan
          },
        ),
      ],
    );
  }

  // Widget pembantu yang bisa digunakan kembali untuk membuat setiap tombol aksi
  Widget _buildActionButton({
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