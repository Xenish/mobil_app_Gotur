import 'package:flutter/material.dart';

class DeliveryScreen extends StatelessWidget {
  final bool isNavigated; // Yönlendirme ile gelip gelinmediğini belirten parametre

  // Bu parametreyi constructor'dan alıyoruz.
  DeliveryScreen({this.isNavigated = false});

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
        child: SafeArea(
          child: Column(
            children: [
              // Sipariş Durumu Kutucuğu
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Sipariş Durumu',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildStatusTile('Hazırlandı'),
                            _buildStatusTile('Hazırlanıyor'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Kurye Durumu Kutucuğu
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Kurye Durumu',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildStatusTile('Sipariş Atandı'),
                            _buildStatusTile('Yola Çıktı'),
                            _buildStatusTile('Adreste'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Teslim Durumu Kutucuğu
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Teslim Durumu',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildStatusTile('Tahmini Varış Süresi'),
                            _buildStatusTile('Teslim Edildi'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Durumları listelemek için yardımcı fonksiyon
  Widget _buildStatusTile(String status) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.indigo.shade700,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          status,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
