import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../state/daftar_catatan_notifier.dart';
import '../theme/tokens.dart';
import '../widget/kartu_catatan.dart';
import '../widget/keadaan_kosong.dart';

class LayarBeranda extends ConsumerWidget {
  const LayarBeranda({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catatan = ref.watch(daftarCatatanProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan POLNES'),
        actions: [
          IconButton(
            icon: Icon(
              ref.watch(themeModeProvider) == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              final currentMode = ref.read(themeModeProvider);
              final newMode = currentMode == ThemeMode.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
              ref.read(themeModeProvider.notifier).ubah(newMode);
            },
          ),
        ],
      ),
      body: catatan.isEmpty
          ? const KeadaanKosong(
              ikon: Icons.note_add_outlined,
              judul: 'Belum ada catatan',
              penjelasan:
                  'Ketuk tombol tambah untuk membuat catatan pertama Anda.',
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              itemCount: catatan.length,
              itemBuilder: (context, i) => Semantics(
                label:
                    'Catatan: ${catatan[i].judul}, ${catatan[i].dibuatPada.day} ${_namaBulan(catatan[i].dibuatPada.month)}${catatan[i].disematkan ? ', disematkan' : ''}',
                button: true,
                onTapHint: 'membuka detail catatan',
                child: KartuCatatan(
                  key: ValueKey(catatan[i].id),
                  catatan: catatan[i],
                  onKetuk: () => context.pushNamed(
                    'detailCatatan',
                    pathParameters: {'id': catatan[i].id},
                  ),
                  onHapus: () {
                    ref
                        .read(daftarCatatanProvider.notifier)
                        .hapus(catatan[i].id);
                  },
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('tambahCatatan'),
        tooltip: 'Tambah catatan',
        child: const Icon(Icons.add),
      ),
    );
  }

  String _namaBulan(int month) {
    return const [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ][month - 1];
  }
}
