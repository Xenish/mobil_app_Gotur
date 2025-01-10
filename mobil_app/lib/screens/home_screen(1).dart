import 'package:flutter/material.dart';
import 'package:mobil_app/screens/order_screen.dart';
import 'package:mobil_app/homeBackScreens/adresler.dart';
import 'package:mobil_app/homeBackScreens/canli_destek.dart';
import 'package:mobil_app/homeBackScreens/gecmis_siparisler.dart';
import 'package:mobil_app/homeBackScreens/odeme_yontemleri.dart';
import 'package:mobil_app/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FullAddress {
  static String? fullAddress;
  static Database? _database;

  static Future<void> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'full_address.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE full_address (id INTEGER PRIMARY KEY, address TEXT)',
        );
      },
    );
  }

  static Future<void> loadFromDatabase() async {
    if (_database == null) await _initDatabase();

    final result = await _database!.query('full_address', limit: 1);
    if (result.isNotEmpty) {
      fullAddress = result[0]['address'] as String?;
    }
  }
}

class HomeScreen extends StatelessWidget {
  final String username = UserData.username ?? ''; // Kullanıcı adı
  final String selectedAddress = "x"; // Şimdilik sabit bir adres
  
  void navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.jpeg'),
          fit: BoxFit.cover, // Arka planın tüm alanı kaplamasını sağlar
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Bar - "Hoşgeldin Kullanıcı adı"
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              height: 75.0, // Normal bardan %25 daha büyük
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'Hoşgeldin $username',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // 2. Bar - "Seçili Adres: x"
Expanded(
  child: GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddressScreen(),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      height: 20.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Seçili Adres:',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          FutureBuilder(
            future: FullAddress.loadFromDatabase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  'Yükleniyor...',
                  style: const TextStyle(color: Colors.white),
                );
              } else if (snapshot.hasError) {
                return Text(
                  'Hata oluştu!',
                  style: const TextStyle(color: Colors.white),
                );
              } else {
                return Text(
                  FullAddress.fullAddress ?? 'Adres yok',
                  style: const TextStyle(color: Colors.white),
                );
              }
            },
          ),
        ],
      ),
    ),
  ),
),





            // 3 ve 4. Barlar - Yatayda hizalanmış
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 3. Bar
                Expanded(
                  child: Container(
                    height: 200.0, // Normal bardan 4 kat daha büyük
                    margin: const EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildClickableBar(
                          context,
                          'Adreslerim',
                          '/addresses', // Örnek rota
                        ),
                        _buildClickableBar(
                          context,
                          'Geçmiş Siparişler',
                          '/orders',
                        ),
                        _buildClickableBar(
                          context,
                          'Ödeme Yöntemleri',
                          '/payments',
                        ),
                        _buildClickableBar(
                          context,
                          'Canlı Destek',
                          '/support',
                        ),
                      ],
                    ),
                  ),
                ),
                // 4. Bar
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrdersScreen(isNavigated:true),
                        ),
                      );
                    },
                    child: Container(
                      height: 200.0, // Normal bardan 4 kat daha büyük
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Alışverişe Başla',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Tıklanabilir Bar Widget'ı
  Widget _buildClickableBar(BuildContext context, String title, String route) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          switch (route) {
            case '/addresses':
              return AddressScreen();
            case '/orders':
              return PastOrdersScreen();
            case '/payments':
              return PaymentMethodsScreen();
            case '/support':
              return LiveSupportScreen();
            default:
              return const Scaffold(
                body: Center(child: Text('Ekran Bulunamadı')),
              );
          }
        }),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        height: 40.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 4,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.indigo,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
