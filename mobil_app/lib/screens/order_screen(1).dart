import 'package:flutter/material.dart';
import 'package:mobil_app/backScreens/icecek.dart';
import 'package:mobil_app/backScreens/meyve.dart';
import 'package:mobil_app/backScreens/sebze.dart';
import 'package:mobil_app/backScreens/su.dart';
import 'package:mobil_app/backScreens/sutUrunleri.dart';
import 'package:mobil_app/backScreens/temelgida.dart'; 
import 'package:mobil_app/backScreens/kahvaltilik.dart';
import 'package:mobil_app/backScreens/atistirmalik.dart';

class OrdersScreen extends StatelessWidget {
  final bool isNavigated; // Yönlendirme ile gelip gelinmediğini belirten parametre
  final List<String> categories = [
    'Temel Gıda',
    'Kahvaltılık',
    'Atıştırmalık',
    'Meyve',
    'Sebze',
    'Su',
    'İçecek',
    'Süt Ürünleri',
  ];

  // Bu parametreyi constructor'dan alıyoruz.
  OrdersScreen({this.isNavigated = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isNavigated // Eğer yönlendirme ile gelindiyse AppBar ekle
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.indigo),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Götür',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.indigo,
                      size: 28,
                    ),
                  ),
                ],
              ),
            )
          : null, // Eğer yönlendirme ile gelinmediyse AppBar eklemeyiz
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 4 yerine 3
            crossAxisSpacing: 10.0, // Daha dar boşluklar
            mainAxisSpacing: 16.0, // Dikey boşluk
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            String boxName = categories[index];
            String imagePath;

            // Her kategori için farklı bir resim yolunu belirle
            switch (boxName) {
              case 'Temel Gıda':
                imagePath = 'images_category/temel_gida.png'; // Temel Gıda için görsel
                break;
              case 'Kahvaltılık':
                imagePath = 'images_category/kahvaltilik.png'; // Kahvaltılık için görsel
                break;
              case 'Atıştırmalık':
                imagePath = 'images_category/atistirmalik.png'; // Atıştırmalık için görsel
                break;
              case 'Meyve':
                imagePath = 'images_category/meyve.png'; // Meyve için görsel
                break;
              case 'Sebze':
                imagePath = 'images_category/sebze.png'; // Sebze için görsel
                break;
              case 'Su':
                imagePath = 'images_category/su.png'; // Su için görsel
                break;
              case 'İçecek':
                imagePath = 'images_category/icecek.png'; // İçecek için görsel
                break;
              case 'Süt Ürünleri':
                imagePath = 'images_category/sut_urunleri.png'; // Süt Ürünleri için görsel
                break;
              default:
                imagePath = ''; // Varsayılan görsel
            }

            return Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      switch (boxName) {
                        case 'Temel Gıda':
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TemelGidaScreen()));
                          break;
                        case 'Kahvaltılık':
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Kahvaltilik()));
                          break;
                        case 'Atıştırmalık':
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Atistirmalik()));
                          break;
                        case 'Meyve':
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Meyve()));
                          break;
                        case 'Sebze':
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Sebze()));
                          break;
                        case 'Su':
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Su()));
                          break;
                        case 'İçecek':
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Icecek()));
                          break;
                        case 'Süt Ürünleri':
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SutUrunleri()));
                          break;
                        default:
                          print('Kategori bulunamadı');
                          break;
                      }
                    },
                    child: Container(
                      height: 60.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6.0),
                Container(
                  height: 28.0, width: 90,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      boxName,
                      style: const TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
