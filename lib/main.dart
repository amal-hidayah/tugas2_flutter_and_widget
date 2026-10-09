import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Helper untuk memformat angka menjadi "Rp 1.234.567".
String formatRupiah(num value) {
  final digits = value.round().toString();
  final withSeparator = digits.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]}.',
  );
  return 'Rp $withSeparator';
}

// ============================ DATA MAHASISWA ============================
const String namaMahasiswa = 'Amal Hidayah';
const String nimMahasiswa = '20240040100';
const String prodiKelas = 'Teknik Informatika / TI24G';

// ============================== ROOT APP ================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepOrange,
    );

    return MaterialApp(
      title: 'PPM Sesi 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF8F6),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}

// ============================== HOME PAGE ===============================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PPM Sesi 2 - $namaMahasiswa ($nimMahasiswa)',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PromoBanner(),
            ProfileCard(),
            SizedBox(height: 16),
            ProductCard(),
          ],
        ),
      ),
    );
  }
}

// ============================= PROMO BANNER =============================
// Menggunakan Stack + Positioned.
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Latar belakang gradien.
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF7043), Color(0xFFD84315)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Ikon dekoratif di kanan atas.
            const Positioned(
              right: -10,
              top: -10,
              child: Icon(
                Icons.local_offer,
                size: 120,
                color: Colors.white24,
              ),
            ),
            // Teks promo di kiri atas.
            const Positioned(
              left: 20,
              top: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PROMO SPESIAL',
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Diskon 30%',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Khusus produk pilihan hari ini',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            // Tombol di kanan bawah.
            Positioned(
              right: 16,
              bottom: 16,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Promo berlaku sampai akhir hari ini!'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFD84315),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Ambil Promo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================= PROFILE CARD =============================
// StatelessWidget: menampilkan nama, NIM, prodi/kelas, foto/ikon, 5 bintang.
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Foto / ikon profil.
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF7043), Color(0xFFD84315)],
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 32,
                    backgroundColor: Color(0xFFFFF3E0),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFFD84315),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Identitas mahasiswa.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        namaMahasiswa,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _InfoLine(icon: Icons.badge, text: 'NIM: $nimMahasiswa'),
                      const SizedBox(height: 2),
                      _InfoLine(icon: Icons.school, text: prodiKelas),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            // 5 ikon bintang.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const StarRating(rating: 4.5),
                Text(
                  '4.5 / 5.0',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Baris kecil berisi ikon + teks informasi.
class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text, style: theme.textTheme.bodyMedium),
        ),
      ],
    );
  }
}

/// Menampilkan tepat 5 ikon bintang sesuai rating.
class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(5, (index) {
        final double value = rating - index;
        final IconData icon;
        if (value >= 1) {
          icon = Icons.star;
        } else if (value >= 0.5) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }
        return Icon(icon, color: Colors.amber, size: 22);
      }),
    );
  }
}

// ============================= PRODUCT CARD =============================
// StatefulWidget: tombol favorite, jumlah like, kuantitas, total harga.
class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  static const String namaProduk = 'Headphone Wireless Pro';
  static const String kategoriProduk = 'Elektronik';
  static const int hargaSatuan = 75000;

  bool _isFavorite = false;
  int _likeCount = 128;
  int _quantity = 1;

  int get _totalHarga => hargaSatuan * _quantity;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      if (_isFavorite) {
        _likeCount++;
      } else {
        _likeCount = (_likeCount - 1).clamp(0, 1 << 31);
      }
    });
  }

  void _tambahJumlah() {
    setState(() {
      _quantity++;
    });
  }

  void _kurangiJumlah() {
    // Jumlah minimal adalah 1.
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _tambahKeKeranjang() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$namaProduk x$_quantity (${formatRupiah(_totalHarga)}) '
          'ditambahkan ke keranjang!',
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar / placeholder produk + tombol favorite + kategori (Stack).
          Stack(
            children: [
              Container(
                height: 190,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFCCBC), Color(0xFFFF8A65)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.headphones,
                  size: 96,
                  color: Colors.white,
                ),
              ),
              // Badge kategori.
              Positioned(
                left: 12,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.category,
                        size: 14,
                        color: Color(0xFFD84315),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        kategoriProduk,
                        style: const TextStyle(
                          color: Color(0xFFD84315),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Tombol Favorite (ikon hati + jumlah like).
              Positioned(
                right: 12,
                top: 12,
                child: Material(
                  color: Colors.white,
                  elevation: 2,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: _toggleFavorite,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isFavorite
                                ? Colors.red
                                : Colors.grey.shade600,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$_likeCount',
                            style: TextStyle(
                              color: _isFavorite
                                  ? Colors.red
                                  : Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Detail produk.
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        namaProduk,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      formatRupiah(hargaSatuan),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Harga satuan',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const Divider(height: 24),
                // Pengatur jumlah produk (- dan +), minimal 1.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Jumlah',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        _QuantityButton(
                          icon: Icons.remove,
                          onPressed: _quantity > 1 ? _kurangiJumlah : null,
                        ),
                        Container(
                          width: 44,
                          alignment: Alignment.center,
                          child: Text(
                            '$_quantity',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _QuantityButton(
                          icon: Icons.add,
                          onPressed: _tambahJumlah,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Total harga.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Harga',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      formatRupiah(_totalHarga),
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Tombol Tambah ke Keranjang.
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _tambahKeKeranjang,
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Tambah ke Keranjang'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Tombol bundar untuk mengatur jumlah produk.
class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null;
    return Container(
      decoration: BoxDecoration(
        color: enabled
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.12)
            : Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        iconSize: 18,
        color: enabled
            ? Theme.of(context).colorScheme.primary
            : Colors.grey.shade500,
        tooltip: icon == Icons.add ? 'Tambah jumlah' : 'Kurangi jumlah',
      ),
    );
  }
}
