import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({super.key});

  @override
  _PesananScreenState createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  final _namaController = TextEditingController();
  final List<Map<String, dynamic>> _menuPesanan =
      []; // List untuk menyimpan menu dan jumlah

  Future<void> _submitForm() async {
    if (_namaController.text.isNotEmpty && _menuPesanan.isNotEmpty) {
      try {
        CollectionReference dbLagrande =
            FirebaseFirestore.instance.collection('db_lagrande');

        await dbLagrande.add({
          'namapemesan': _namaController.text,
          'menuPesanan': _menuPesanan,
        });

        // Tampilkan popup berhasil
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Berhasil'),
            content: const Text('Pesanan berhasil dikirim!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );

        _namaController.clear();
        setState(() {
          _menuPesanan.clear();
        });
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Gagal mengirim pesanan: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Gagal'),
          content: const Text('Silakan lengkapi semua kolom!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Pemesan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Daftar Menu Pesanan
            Expanded(
              child: ListView.builder(
                itemCount: _menuPesanan.length,
                itemBuilder: (context, index) {
                  final menuItem = _menuPesanan[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        // Kolom input menu
                        Expanded(
                          flex: 3,
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Menu Pesanan',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              setState(() {
                                menuItem['menu'] = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),

                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (menuItem['jumlah'] > 1) {
                                    menuItem['jumlah']--;
                                  }
                                });
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              '${menuItem['jumlah']}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  menuItem['jumlah']++;
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              _menuPesanan.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _menuPesanan.add({'menu': '', 'jumlah': 1});
                  });
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: const Text(
                  "Tambah Menu",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 98, 68, 57),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Center(
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 98, 68, 57),
                ),
                child: const Text(
                  'KIRIM',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
