import 'package:flutter/material.dart';
import 'package:dipoassist/services/auth_service.dart';
import 'package:dipoassist/main_page/screens/login.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  Future<void> _logout(BuildContext context) async {
    await AuthService.clearToken();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  String _getInitials(String fullName) {
    List<String> parts = fullName.trim().split(" ");
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: AuthService.getUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data!;
        final String name = user["name"] ?? "User";
        final String? imageUrl = user["image_url"];
        final String initials = _getInitials(name);

        return Scaffold(
          appBar: AppBar(
            title: const Text("Pengaturan Akun"),
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          body: Column(
            children: [
              // Header Profil
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade400, Colors.teal.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl)
                          : null,
                      child: imageUrl == null
                          ? Text(
                              initials,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Menu
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.vpn_key,
                              color: Colors.teal,
                            ),
                            title: const Text("Akun"),
                            subtitle: const Text("Edit profile, tanggal lahir"),
                            onTap: () {},
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.lock, color: Colors.teal),
                            title: const Text("Keamanan"),
                            subtitle: const Text("Kelola password"),
                            onTap: () {},
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(
                              Icons.notifications,
                              color: Colors.teal,
                            ),
                            title: const Text("Notifikasi"),
                            subtitle: const Text(
                              "Kelola nada dering notifikasi",
                            ),
                            onTap: () {},
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(
                              Icons.help_outline,
                              color: Colors.teal,
                            ),
                            title: const Text("Bantuan"),
                            subtitle: const Text("Pusat bantuan aplikasi"),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton.icon(
                      onPressed: () => _logout(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
