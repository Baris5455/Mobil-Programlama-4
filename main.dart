import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid & Horizontal ListView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GridAndHorizontalListViewPage(),
    );
  }
}
class Product { // Ürün sınıfı: Ürün adı ve fiyatı içerir
  final String name;
  final double price;

  Product({required this.name, required this.price});
}
class GridAndHorizontalListViewPage extends StatefulWidget {
  const GridAndHorizontalListViewPage({super.key}); 
  @override
  GridAndHorizontalListViewPageState createState() => GridAndHorizontalListViewPageState();
}
class GridAndHorizontalListViewPageState extends State<GridAndHorizontalListViewPage> {
  int? _highlightedIndex; // Vurgulanan grid öğesinin indeksi
  final List<Product> products = [  // Grid ve ListView öğeleri için ürün listesi
    Product(name: "Telefon", price: 19999.99),
    Product(name: "Laptop", price: 39999.99),
    Product(name: "Mouse", price: 799.99),
    Product(name: "Kulaklık", price: 599.99),
    Product(name: "Powerbank", price: 449.99),
    Product(name: "Monitor", price: 7499.99),
    Product(name: "Hoparlör", price: 1199.99),
    Product(name: "Yazıcı", price: 1999.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: Colors.amber,
        title: const Text("Grid & Horizontal ListView"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Expanded( // GridView üst kısımda
            flex: 2,  // GridView'e ListView'den 2 kat fazla alan verir
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 sütunlu grid
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 2 / 1, // Kartların en-boy oranı
              ),
              padding: const EdgeInsets.all(8.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  color: _highlightedIndex == index 
                      ? Colors.redAccent // Seçili öğe için vurgu rengi
                      : Colors.deepPurple[100 * ((index % 8) + 1)],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        products[index].name, // Ürün ismi
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₺${products[index].price.toStringAsFixed(2)}', // Ürün fiyatı
                        style: const TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16), // Grid ve ListView arasında boşluk
          SizedBox( // Horizontal ListView alt kısımda
            height: 120, // Yatay ListView yüksekliği
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _highlightedIndex = index; // Tıklanan öğeyi vurgula
                    });
                  },
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.orange[100 * ((index % 6) + 1)],
                    child: Center(
                      child: Text(
                        products[index].name, // ListView öğesi ürün ismi
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}