// File: buat_laporan_page.dart

import 'package:flutter/material.dart';

class Laporkan extends StatefulWidget {
  const Laporkan({super.key});

  @override
  State<Laporkan> createState() => _BuatLaporanPageState();
}

class _BuatLaporanPageState extends State<Laporkan> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedCategory;
  bool _isLoading = false;

  final List<String> _categories = ['Alat Tidak Berfungsi', 'Koneksi Bermasalah', 'Bug Aplikasi', 'Lainnya'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitReport() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulasi kirim data ke API
      await Future.delayed(const Duration(seconds: 2));

      print('Laporan Dikirim: ${_titleController.text}, Kategori: $_selectedCategory, Deskripsi: ${_descriptionController.text}');

      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Laporan baru berhasil dibuat!'),
            backgroundColor: Colors.green,
          ),
        );
        // Kembali ke halaman sebelumnya (daftar laporan) setelah berhasil
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Laporan Baru'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Detail Masalah',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Figtree'),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Jelaskan masalah yang Anda hadapi secara detail agar tim kami dapat membantu.',
                  style: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'Figtree'),
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(labelText: 'Kategori Masalah', border: OutlineInputBorder(), prefixIcon: Icon(Icons.category)),
                  items: _categories.map((String category) => DropdownMenuItem<String>(value: category, child: Text(category))).toList(),
                  onChanged: (newValue) => setState(() => _selectedCategory = newValue),
                  validator: (value) => value == null ? 'Kategori harus dipilih' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Judul Laporan', border: OutlineInputBorder(), prefixIcon: Icon(Icons.title)),
                  validator: (value) => (value == null || value.isEmpty) ? 'Judul tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(labelText: 'Deskripsi Lengkap', border: OutlineInputBorder(), alignLabelWithHint: true),
                   validator: (value) => (value == null || value.isEmpty) ? 'Deskripsi tidak boleh kosong' : null,
                ),
                const SizedBox(height: 24),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                        onPressed: _submitReport,
                        icon: const Icon(Icons.send),
                        label: const Text('Kirim Laporan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Figtree'),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}