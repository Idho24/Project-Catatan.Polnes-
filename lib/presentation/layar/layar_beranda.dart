import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../state/daftar_catatan_notifier.dart';
import '../widget/kartu_catatan.dart';
import '../widget/kolom_pencarian.dart';

class LayarBeranda extends ConsumerStatefulWidget {
  const LayarBeranda({super.key});

  @override
  ConsumerState<LayarBeranda> createState() => _LayarBerandaState();
}

class _LayarBerandaState extends ConsumerState<LayarBeranda> {
  int _pencacah = 0;

  void _tambahPencacah() {
    setState(() {
      _pencacah += 2; // Syarat #4: Kelipatan 2
    });
  }

  @override
  Widget build(BuildContext context) {
    // Syarat #5: Logika sederhana Genap/Ganjil di dalam build
    final String status = _pencacah % 2 == 0 ? 'Genap' : 'Ganjil';

    return Scaffold(
      appBar: AppBar(
        // Syarat #1: Judul AppBar Nama dan NIM
        title: const Text('Muhamad Ainur Ridho - [NIM Anda]'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Syarat #3: Teks di tengah layar
                const Text(
                  'Praktikum PPB — Pertemuan 1',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nilai Pencacah: $_pencacah ($status)',
                  style: const TextStyle(fontSize: 16),
                ),
                const Divider(height: 32),
                KolomPencarian(
                  onBerubah: (value) {
                    // Implementasi pencarian
                  },
                ),
              ],
            ),
          ),
          const Expanded(child: DaftarCatatanView()),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Tombol untuk Pencacah
          FloatingActionButton(
            heroTag: 'counterBtn',
            onPressed: _tambahPencacah,
            tooltip: 'Tambah Pencacah (+2)',
            mini: true,
            child: const Icon(Icons.exposure_plus_2),
          ),
          const SizedBox(height: 12),
          // Tombol untuk Tambah Catatan (Hasil Akhir)
          FloatingActionButton(
            heroTag: 'addNoteBtn',
            onPressed: () => context.push('/tambah'),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class DaftarCatatanView extends ConsumerWidget {
  const DaftarCatatanView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final daftarCatatan = ref.watch(daftarCatatanProvider);

    if (daftarCatatan.isEmpty) {
      return const Center(child: Text('Belum ada catatan.'));
    }

    return ListView.builder(
      itemCount: daftarCatatan.length,
      itemBuilder: (context, index) {
        final catatan = daftarCatatan[index];
        return KartuCatatan(
          catatan: catatan,
          onKetuk: () => context.push('/catatan/${catatan.id}'),
          onHapus: () {
            ref.read(daftarCatatanProvider.notifier).hapus(catatan.id);
          },
        );
      },
    );
  }
}
