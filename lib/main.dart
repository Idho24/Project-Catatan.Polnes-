import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/router/app_router.dart';
import 'presentation/state/daftar_catatan_notifier.dart';
import 'presentation/theme/app_theme.dart';

void main() async {
  const String nama = 'Politeknik Negeri Samarinda';
  const String kota = 'Samarinda';
  const int tahun = 1985;
  const double ipk = 3.75;
  const bool aktif = true;
  final DateTime waktuMulai = DateTime.now();
  const int jumlahSemester = 6;

  debugPrint(sapa('Budi'));
  debugPrint(sapa('Sari', sapaan: 'Selamat pagi'));
  debugPrint('${luas(panjang: 5, lebar: 3)}');
  debugPrint('${kuadrat(7)}');

  debugPrint('$nama, $kota, berdiri $tahun');
  debugPrint('IPK: $ipk, aktif: $aktif, semester: $jumlahSemester');
  debugPrint('Dimulai: $waktuMulai');

  // Null Safety check:
  const String judul = 'Catatan';
  const String? catatan = null;

  debugPrint('${judul.length}');
  debugPrint('${catatan?.length ?? 0}');
  debugPrint('${panjangAman(null)}');
  debugPrint("${panjangAman('Rapat Jurusan')}");

  final angka = [3, 1, 4, 1, 5, 9, 2, 6];
  // ignore: equal_elements_in_set
  final unik = {3, 1, 4, 1, 5};
  final nilai = {'Andi': 85, 'Budi': 78, 'Citra': 92};

  final genap = angka.where((n) => n.isEven).toList();
  final listKuadrat = angka.map((n) => n * n).toList();
  final total = angka.fold<int>(0, (jml, n) => jml + n);
  final terurut = [...angka]..sort();

  debugPrint('Genap   : $genap');
  debugPrint('Kuadrat : $listKuadrat');
  debugPrint('Total   : $total');
  debugPrint('Terurut : $terurut');
  debugPrint('Set unik: $unik');

  debugPrint(
    'Lulus   : ${nilai.entries.where((e) => e.value >= 80).map((e) => e.key).toList()}',
  );

  // Langkah 6 — Sealed Class dan Pattern Matching
  debugPrint(deskripsikan(Memuat()));
  debugPrint(deskripsikan(Berhasil(<String>[])));
  debugPrint(deskripsikan(Berhasil(<String>['a', 'b', 'c'])));
  debugPrint(deskripsikan(Gagal('token habis', kode: 401)));
  debugPrint(deskripsikan(Gagal('server mati')));
  debugPrint(deskripsikan(Dibatalkan()));

  // Langkah 7 — Asinkron
  await berurutan();
  await bersamaan();

  runApp(const ProviderScope(child: MyApp()));
}

sealed class HasilMuat {}

class Memuat extends HasilMuat {}

class Berhasil extends HasilMuat {
  final List<String> data;
  Berhasil(this.data);
}

class Gagal extends HasilMuat {
  final String pesan;
  final int? kode;
  Gagal(this.pesan, {this.kode});
}

class Dibatalkan extends HasilMuat {}

String deskripsikan(HasilMuat hasil) => switch (hasil) {
  Memuat() => 'Sedang memuat...',
  Berhasil(data: final List<String> d) when d.isEmpty => 'Belum ada catatan',
  Berhasil(data: final List<String> d) => 'Ada ${d.length} catatan',
  Gagal(pesan: final String p, kode: 401) => 'Sesi berakhir: $p',
  Gagal(pesan: final String p) => 'Terjadi kesalahan: $p',
  Dibatalkan() => 'Proses dibatalkan oleh pengguna',
};

Future<String> ambilData() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Data dari server';
}

Future<String> ambilProfil() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Profil pengguna';
}

Future<void> berurutan() async {
  final mulai = DateTime.now();
  final a = await ambilData();
  final b = await ambilProfil();
  final durasi = DateTime.now().difference(mulai);
  debugPrint('Berurutan : $a | $b | ${durasi.inMilliseconds} ms');
}

Future<void> bersamaan() async {
  final mulai = DateTime.now();
  final hasil = await Future.wait([ambilData(), ambilProfil()]);
  final durasi = DateTime.now().difference(mulai);
  debugPrint(
    'Bersamaan : ${hasil[0]} | ${hasil[1]} | ${durasi.inMilliseconds} ms',
  );
}

String sapa(String nama, {String sapaan = 'Halo'}) {
  return '$sapaan, $nama!';
}

double luas({required double panjang, required double lebar}) {
  return panjang * lebar;
}

int kuadrat(int n) => n * n;

int panjangAman(String? teks) {
  if (teks == null) return 0;
  return teks.length;
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'Catatan POLNES',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.terang(),
      darkTheme: AppTheme.gelap(),
      themeMode: themeMode,
      routerConfig: appRouter,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: MediaQuery.of(context).textScaler
                .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.8),
          ),
          child: child!,
        );
      },
    );
  }
}
