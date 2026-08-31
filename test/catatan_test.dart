import 'package:flutter_test/flutter_test.dart';
import 'package:catatan_polnes/domain/entity/catatan.dart';

void main() {
  group('Latihan 2.4 - Unit Test Catatan', () {
    test('Catatan.baru harus melakukan trim pada judul', () {
      final catatan = Catatan.baru(judul: '  Belajar Flutter  ', isi: 'Isi');
      expect(catatan.judul, 'Belajar Flutter');
    });

    test('judulValid harus false jika judul kosong', () {
      final catatan = Catatan(
        id: '1',
        judul: '',
        isi: 'Isi',
        dibuatPada: DateTime.now(),
      );
      expect(catatan.judulValid, isFalse);
    });

    test('judulValid harus false jika judul > 80 karakter', () {
      final catatan = Catatan(
        id: '1',
        judul: 'a' * 81,
        isi: 'Isi',
        dibuatPada: DateTime.now(),
      );
      expect(catatan.judulValid, isFalse);
    });

    test('Catatan dengan data sama harus dianggap sama (equality)', () {
      final waktu = DateTime.now();
      final c1 = Catatan(id: '1', judul: 'A', isi: 'B', dibuatPada: waktu);
      final c2 = Catatan(id: '1', judul: 'A', isi: 'B', dibuatPada: waktu);
      expect(c1, equals(c2));
      expect(c1.hashCode, equals(c2.hashCode));
    });

    test('formatTanggal memformat ke dd MMM yyyy', () {
      final waktu = DateTime(2026, 8, 30);
      expect(formatTanggal(waktu), '30 Agu 2026');
    });
  });
}
