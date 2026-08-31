class Catatan {
  final String id;
  final String judul;
  final String isi;
  final DateTime dibuatPada;
  final bool disematkan;

  const Catatan({
    required this.id,
    required this.judul,
    required this.isi,
    required this.dibuatPada,
    this.disematkan = false,
  });

  factory Catatan.baru({required String judul, required String isi}) {
    return Catatan(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      judul: judul.trim(),
      isi: isi,
      dibuatPada: DateTime.now(),
    );
  }

  bool get judulValid => judul.trim().isNotEmpty && judul.trim().length <= 80;

  Catatan copyWith({String? judul, String? isi, bool? disematkan}) {
    return Catatan(
      id: id,
      judul: judul ?? this.judul,
      isi: isi ?? this.isi,
      dibuatPada: dibuatPada,
      disematkan: disematkan ?? this.disematkan,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Catatan &&
          other.id == id &&
          other.judul == judul &&
          other.isi == isi &&
          other.disematkan == disematkan;

  @override
  int get hashCode => Object.hash(id, judul, isi, disematkan);

  @override
  String toString() => 'Catatan(id: $id, judul: $judul)';
}

String formatTanggal(DateTime dateTime) {
  const List<String> daftarBulan = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];
  final String hari = dateTime.day.toString().padLeft(2, '0');
  final String bulan = daftarBulan[dateTime.month - 1];
  final String tahun = dateTime.year.toString();
  return '$hari $bulan $tahun';
}
