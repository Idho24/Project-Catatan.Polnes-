import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catatan_polnes/domain/entity/catatan.dart';
import 'package:catatan_polnes/presentation/layar/layar_beranda.dart';
import 'package:catatan_polnes/presentation/state/daftar_catatan_notifier.dart';

class MockDaftarCatatanNotifier extends DaftarCatatanNotifier {
  final List<Catatan> data;
  MockDaftarCatatanNotifier(this.data);
  @override
  List<Catatan> build() => data;
}

void main() {
  testWidgets('Langkah 8: Verifikasi Aksesibilitas', (
    WidgetTester tester,
  ) async {
    final catatan = Catatan(
      id: '1',
      judul: 'Belajar Flutter',
      isi: 'Materi Aksesibilitas',
      dibuatPada: DateTime(2026, 9, 6),
      disematkan: true,
    );

    // Aktifkan semantik untuk pengujian
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          daftarCatatanProvider.overrideWith(
            () => MockDaftarCatatanNotifier([catatan]),
          ),
        ],
        child: const MaterialApp(home: LayarBeranda()),
      ),
    );

    // 1. Verifikasi Tooltip pada tombol hapus
    expect(find.byTooltip('Hapus catatan'), findsOneWidget);

    // 2. Verifikasi Label Semantik
    final expectedLabel = 'Catatan: Belajar Flutter, 6 September, disematkan';
    expect(find.bySemanticsLabel(expectedLabel), findsOneWidget);

    // Verifikasi bahwa node tersebut adalah button
    final semantics = tester.getSemantics(find.bySemanticsLabel(expectedLabel));
    expect(
      semantics.getSemanticsData().flagsCollection.isButton,
      isTrue,
    );

    handle.dispose();
  });
}
