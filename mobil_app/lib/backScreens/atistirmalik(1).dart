import 'package:flutter/material.dart';
import 'package:mobil_app/screens/cart_Screen.dart';

class Atistirmalik extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {'name': 'Canga', 'image': 'images_atistirmalik/canga.png', 'price': 18.0},
    {'name': 'Ruffles', 'image': 'images_atistirmalik/ruffles.png', 'price': 39.0},
    {'name': 'Gofret', 'image': 'images_atistirmalik/gofret.png', 'price': 10.0},
    {'name': 'Fındıklı Çikolata', 'image': 'images_atistirmalik/findikli_cikolata.png', 'price': 52.0},
    {'name': 'Doritos', 'image': 'images_atistirmalik/doritos.png', 'price': 49.0},
    {'name': 'Probis', 'image': 'images_atistirmalik/probis.png', 'price': 24.0},
    {'name': 'Çizi', 'image': 'images_atistirmalik/cizi.png', 'price': 10.0},
    {'name': 'Patlamış Mısır', 'image': 'images_atistirmalik/patlamis_misir.png', 'price': 29.0},
  ];

  void _addToCart(BuildContext context, String name, String image, double price) {
  Cart.addItem(name, image, price); // image parametresi eklendi
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$name sepete eklendi!'),
      duration: Duration(seconds: 2),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temel Gıda',style: TextStyle(color: Colors.indigo, fontSize: 25,fontWeight: FontWeight.bold,),),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.indigo), // Change the back button color here
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.indigo,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Arka Plan Resmi
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // İçerikler (Ürün Kutuları)
          GridView.builder(
            padding: const EdgeInsets.fromLTRB(48.0, 48.0, 48.0, 48.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 38.0,
              mainAxisSpacing: 48.0,
              childAspectRatio: 2 / 3,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 4,
                          spreadRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              product['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            product['name']!,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            '${product['price']} ₺',
                            style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 4.0,
                    right: 4.0,
                    child: GestureDetector(
                      onTap: () => _addToCart(context, product['name']!,product['image']!, product['price']!),
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
