// Widget test untuk halaman Product & Profile - PPM Sesi 2.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ppm_sesi_2/main.dart';

/// Memuat app dengan ukuran layar tinggi supaya semua konten terlihat.
Future<void> pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1200, 2600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const MyApp());
}

void main() {
  testWidgets('Menampilkan data mahasiswa dan produk', (tester) async {
    await pumpApp(tester);

    // Judul AppBar.
    expect(
      find.text('PPM Sesi 2 - $namaMahasiswa ($nimMahasiswa)'),
      findsOneWidget,
    );

    // Data profil.
    expect(find.text(namaMahasiswa), findsOneWidget);
    expect(find.text('NIM: $nimMahasiswa'), findsOneWidget);
    expect(find.text(prodiKelas), findsOneWidget);

    // Data produk.
    expect(find.text('Headphone Wireless Pro'), findsOneWidget);
    expect(find.text('Elektronik'), findsOneWidget);
  });

  testWidgets('Tombol + dan - mengubah jumlah dan total harga', (tester) async {
    await pumpApp(tester);

    // Awal: jumlah 1, total Rp 75.000.
    expect(find.text('Rp 75.000'), findsWidgets);

    // Tambah jumlah -> 2.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
    expect(find.text('Rp 150.000'), findsOneWidget);

    // Kurangi kembali -> 1.
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('Rp 75.000'), findsWidgets);

    // Di jumlah 1 tombol - dinonaktifkan, jumlah tidak boleh kurang dari 1.
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Tombol favorite mengubah ikon dan jumlah like', (tester) async {
    await pumpApp(tester);

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.text('128'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.text('129'), findsOneWidget);

    // Tekan lagi -> batal favorite, like berkurang.
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.text('128'), findsOneWidget);
  });

  testWidgets('Tombol Tambah ke Keranjang menampilkan SnackBar', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Tambah ke Keranjang'));
    await tester.pump(); // Mulai animasi SnackBar.

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.textContaining('ditambahkan ke keranjang'), findsOneWidget);
  });
}
