# AGENTS.md — catatan_polnes

## Perintah Verifikasi

Jalankan setelah setiap perubahan. Jangan menyatakan pekerjaan selesai sebelum ketiganya lulus:

```bash
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

## Konteks Proyek

Aplikasi catatan untuk praktikum **Pemrograman Perangkat Bergerak**,
Politeknik Negeri Samarinda.

**Pengembang:** Muhamad Ainur Ridho
**NIM:** [Masukkan NIM Kamu]
**Fitur:** Ubah Judul Catatan

**Flutter:** 3.44
**Dart:** 3.12
## Konvensi Kode

* Nama berkas menggunakan `snake_case`.
* Nama kelas menggunakan `PascalCase`.
* **DILARANG** memakai `print()`; gunakan `debugPrint()` saat pengembangan.
* **DILARANG** menulis kunci API atau kredensial di dalam kode.
* Ikuti aturan pada `analysis_options.yaml`.

## Batasan Perubahan

* Jangan menyentuh direktori `android/` dan `web/` kecuali diminta.
* Jangan menambah dependensi tanpa persetujuan.

## Aturan Arsitektur

* **Domain:** Mandiri (tidak bergantung pada `data` atau `presentation`).
* **Data:** Bergantung pada `domain` (implementasi repository).
* **Presentation:** Bergantung pada `domain` dan `data` (melalui Provider).
