import 'package:flutter/material.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan Akun"),
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.vpn_key, color: Colors.teal),
            title: const Text("Akun"),
            subtitle: const Text("Edit profile, tanggal lahir"),
            onTap: () {
              // Aksi ketika ditekan
            },
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.lock, color: Colors.teal),
            title: const Text("Keamanan"),
            subtitle: const Text("Kelola password"),
            onTap: () {
              // Aksi ketika ditekan
            },
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.teal),
            title: const Text("Notifikasi"),
            subtitle: const Text("Kelola nada dering notifikasi"),
            onTap: () {
              // Aksi ketika ditekan
            },
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.teal),
            title: const Text("Bantuan"),
            subtitle: const Text("Pusat bantuan aplikasi"),
            onTap: () {
              // Aksi ketika ditekan
            },
          ),
        ],
      ),
    );
  }
}
