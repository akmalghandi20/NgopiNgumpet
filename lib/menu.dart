import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String selectedCategory = 'Coffee';

  final List<Map<String, String>> coffeeItems = [
    {'image': 'assets/americano.jpg', 'price': 'Rp 15,000', 'name': 'Americano'},
    {'image': 'assets/capuccino.jpg', 'price': 'Rp 18,000', 'name': 'Capuccino'},
    {'image': 'assets/japanese_v60.jpg', 'price': 'Rp 25,000', 'name': 'Japanese V60'},
    {'image': 'assets/kopi_susu.jpg', 'price': 'Rp 15,000', 'name': 'Kopi Susu'},
    {'image': 'assets/kopi_tubruk.jpg', 'price': 'Rp 10,000', 'name': 'Kopi Tubruk'},
    {'image': 'assets/vietnam_drip.jpg', 'price': 'Rp 15,000', 'name': 'Vietnam Drip'},
  ];

  final List<Map<String, String>> nonCoffeeItems = [
    {'image': 'assets/red_velvet.jpg', 'price': 'Rp 18,000', 'name': 'Red Velvet'},
    {'image': 'assets/susu_simbak.jpg', 'price': 'Rp 10,000', 'name': 'Susu Simbak'},
    {'image': 'assets/milo.jpg', 'price': 'Rp 18,000', 'name': 'Milo'},
  ];

  List<Map<String, String>> get menuItems {
    return selectedCategory == 'Coffee' ? coffeeItems : nonCoffeeItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('Coffee'),
                  selected: selectedCategory == 'Coffee',
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = 'Coffee';
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Non Coffee'),
                  selected: selectedCategory == 'Non Coffee',
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = 'Non Coffee';
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Jumlah kolom
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return MenuItem(
                    image: menuItems[index]['image']!,
                    price: menuItems[index]['price']!,
                    name: menuItems[index]['name']!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String image;
  final String price;
  final String name;

  const MenuItem({
    required this.image,
    required this.price,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0), 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                fit: BoxFit.cover, 
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
