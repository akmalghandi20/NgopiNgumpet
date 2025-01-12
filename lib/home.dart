import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar perangkat
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white10,
    appBar: AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),  // Tambahkan padding yang lebih besar
        child: Image.asset(
          'assets/warmaskinn.png',
          height: 45,  // Sesuaikan tinggi gambar
        ),
      ),
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: Colors.black,  // Warna garis hitam
          height: 0.1,  // Ketebalan garis hitam
        ),
      ),
    ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Deskripsi dan Foto
            Center(
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ClipRRect(
                      child: Image.asset(
                        'assets/warmaskin.png',
                        height: screenWidth * 0.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),

        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          ),

            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Produk Unggulan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildProductCard(
                        "Americano",
                        'assets/americano.jpg',
                        screenWidth * 0.3,
                        screenWidth * 0.3),
                  ),
                  Expanded(
                    child: _buildProductCard(
                        "Capuccino",
                        'assets/capuccino.jpg',
                        screenWidth * 0.3,
                        screenWidth * 0.3),
                  ),
                  Expanded(
                    child: _buildProductCard(
                        "Kopi Susu",
                        'assets/kopi_susu.jpg',
                        screenWidth * 0.3,
                        screenWidth * 0.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(
      String title, String imagePath, double imageWidth, double imageHeight) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(imageWidth * 0.2),
              child: Image.asset(
                imagePath,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
