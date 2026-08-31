import 'package:catatan_polnes/main.dart';
import 'package:catatan_polnes/domain/entity/catatan.dart';
import 'package:catatan_polnes/presentation/state/daftar_catatan_notifier.dart';
import 'package:catatan_polnes/presentation/widget/kartu_catatan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Latihan 2.3 - Format Tanggal (dd MMM yyyy)', () {
    test('formatTanggal memformat tanggal ke dd MMM yyyy dengan benar', () {
      final DateTime t1 = DateTime(2026, 8, 30);
      expect(formatTanggal(t1), '30 Agu 2026');

      final DateTime t2 = DateTime(2026, 1, 5);
      expect(formatTanggal(t2), '05 Jan 2026');

      final DateTime t3 = DateTime(2025, 12, 1);
      expect(formatTanggal(t3), '01 Des 2025');
    });
  });

  group('Latihan 2.3 - KartuCatatan Widget', () {
    testWidgets('Menampilkan judul, isi, dan merespon ketukan', (
      WidgetTester tester,
    ) async {
      bool onKetukDipanggil = false;
      final Catatan catatan = Catatan(
        id: '101',
        judul: 'Judul Uji',
        isi: 'Isi konten uji catatan',
        dibuatPada: DateTime(2026, 8, 30),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KartuCatatan(
              catatan: catatan,
              onKetuk: () {
                onKetukDipanggil = true;
              },
              onHapus: () {},
            ),
          ),
        ),
      );

      expect(find.text('Judul Uji'), findsOneWidget);
      expect(find.text('Isi konten uji catatan'), findsOneWidget);

      await tester.tap(find.text('Judul Uji'));
      await tester.pump();

      expect(onKetukDipanggil, isTrue);
    });
  });

  group('Latihan 2.3 - DaftarCatatanNotifier', () {
    test('DaftarCatatanNotifier dapat menambah dan menghapus', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(daftarCatatanProvider.notifier);

      expect(container.read(daftarCatatanProvider).length, 0);

      notifier.tambah('Judul 1', 'Isi 1');
      expect(container.read(daftarCatatanProvider).length, 1);
      expect(container.read(daftarCatatanProvider)[0].judul, 'Judul 1');

      final id = container.read(daftarCatatanProvider)[0].id;
      notifier.hapus(id);
      expect(container.read(daftarCatatanProvider).length, 0);
    });
  });

  group('Latihan 2.3 - Integrasi', () {
    testWidgets('Menambah catatan melalui FAB muncul di daftar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle();

      expect(find.text('Belum ada catatan.'), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextField, 'Judul Catatan'),
        'Catatan Baru',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Isi Catatan'),
        'Isi catatan',
      );
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      expect(find.text('Catatan Baru'), findsOneWidget);
      expect(find.text('Isi catatan'), findsOneWidget);
    });
  });
}
