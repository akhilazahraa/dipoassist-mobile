import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // Package untuk format tanggal dan waktu

// 1. BUAT MODEL CLASS UNTUK DATA RIWAYAT (Best Practice)
// Ini memastikan data Anda terstruktur dan aman dari error.
class SignalHistory {
  final String predictedText;
  final DateTime timestamp;

  SignalHistory({required this.predictedText, required this.timestamp});

  factory SignalHistory.fromJson(Map<String, dynamic> json) {
    return SignalHistory(
      predictedText: json['predictedText'] ?? 'Data Tidak Ditemukan',
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  // 2. STATE MANAGEMENT UNTUK MENANGANI DATA DARI API
  late Future<List<SignalHistory>> _historyFuture;

  @override
  void initState() {
    super.initState();
    // Memanggil fungsi untuk mengambil data saat halaman pertama kali dibuka
    _historyFuture = _fetchHistory();
  }

  // 3. FUNGSI UNTUK MENGAMBIL DATA DARI API
  Future<List<SignalHistory>> _fetchHistory() async {
    // GANTI URL INI DENGAN URL API ANDA YANG SEBENARNYA
    final url = Uri.parse('https://api.jsonbin.io/v3/b/66d8b9d3e41b4d34e417124f');
    
    // Header opsional jika API Anda memerlukan otorisasi
    final headers = {
      'X-Master-Key': '\$2a\$10\$962a1cf1228d45f448e32uR5ad7Gbpk2e5SoiJGWm2Pmmv224a9Im'
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // Jika request berhasil, parse JSON
        final jsonData = json.decode(response.body);
        final List<dynamic> historyData = jsonData['record']['history']; // Sesuaikan dengan struktur JSON Anda
        
        // Ubah setiap item JSON menjadi objek SignalHistory
        return historyData.map((item) => SignalHistory.fromJson(item)).toList();
      } else {
        // Jika server mengembalikan error
        throw Exception('Gagal memuat data dari server');
      }
    } catch (e) {
      // Jika terjadi error lain (misal: tidak ada koneksi internet)
      throw Exception('Gagal terhubung: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Sinyal',
          style: TextStyle(
            fontFamily: 'Figtree',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      // 4. MENGGUNAKAN FutureBuilder UNTUK MENANGANI STATE (LOADING, ERROR, DATA)
      body: FutureBuilder<List<SignalHistory>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          // Saat data masih dimuat
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Jika terjadi error
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _historyFuture = _fetchHistory(); // Coba lagi
                      });
                    },
                    child: const Text('Coba Lagi'),
                  )
                ],
              ),
            );
          }
          // Jika data berhasil dimuat
          if (snapshot.hasData) {
            final historyList = snapshot.data!;
            // Jika data kosong
            if (historyList.isEmpty) {
              return const Center(
                child: Text(
                  'Belum ada riwayat sinyal.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }
            // Jika data ada, tampilkan dengan ListView.builder
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                return _buildHistoryItem(historyList[index]);
              },
            );
          }
          // State default (seharusnya tidak pernah tercapai)
          return const Center(child: Text('Terjadi kesalahan.'));
        },
      ),
    );
  }

  // 5. WIDGET UNTUK MEMBUAT SETIAP ITEM RIWAYAT SESUAI DESAIN
  Widget _buildHistoryItem(SignalHistory item) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // Format tanggal menggunakan package intl
                  DateFormat('dd/M/yy').format(item.timestamp),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.predictedText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Figtree',
                  ),
                ),
              ],
            ),
            Text(
              // Format waktu menggunakan package intl
              DateFormat('HH:mm').format(item.timestamp) + ' WIB',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}