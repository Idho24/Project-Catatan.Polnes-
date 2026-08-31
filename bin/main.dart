// ignore_for_file: avoid_print
import 'package:catatan_polnes/domain/entity/catatan.dart';

void main() {
  final a = Catatan.baru(judul: '  Rapat Jurusan  ', isi: 'Agenda kurikulum');
  print(a.judul); // Rapat Jurusan  (spasi hilang)
  print(a.judulValid); // true

  final b = a.copyWith(judul: 'Rapat Prodi');
  print(b.judul); // Rapat Prodi
  print(b.isi); // Agenda kurikulum (tidak berubah)
  print(b.id == a.id); // true (id ikut disalin)

  final waktu = DateTime(2026, 8, 1);
  final c1 = Catatan(id: '1', judul: 'A', isi: 'B', dibuatPada: waktu);
  final c2 = Catatan(id: '1', judul: 'A', isi: 'B', dibuatPada: waktu);
  print(c1 == c2); // true  (karena == ditimpa)
  print({c1, c2}.length); // 1     (karena hashCode ditimpa)
}
