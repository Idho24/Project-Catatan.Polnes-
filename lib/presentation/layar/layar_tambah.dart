import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../state/daftar_catatan_notifier.dart';
import '../theme/tokens.dart';

class LayarTambah extends ConsumerStatefulWidget {
  const LayarTambah({super.key});

  @override
  ConsumerState<LayarTambah> createState() => _LayarTambahState();
}

class _LayarTambahState extends ConsumerState<LayarTambah> {
  final _judulController = TextEditingController();
  final _isiController = TextEditingController();

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();
    super.dispose();
  }

  void _simpan() {
    final judul = _judulController.text;
    final isi = _isiController.text;

    if (judul.isNotEmpty) {
      ref.read(daftarCatatanProvider.notifier).tambah(judul, isi);
      context.pop();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Judul tidak boleh kosong')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Catatan')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            TextField(
              controller: _judulController,
              decoration: const InputDecoration(
                labelText: 'Judul Catatan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _isiController,
              decoration: const InputDecoration(
                labelText: 'Isi Catatan',
                border: OutlineInputBorder(),
              ),
              maxLines: 10,
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: _simpan,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black87,
                ),
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
