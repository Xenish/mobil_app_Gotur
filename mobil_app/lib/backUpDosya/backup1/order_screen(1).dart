// orders_screen.dart
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  final List<String> categories = [
    'Temel Gıda',
    'Kahvaltılık',
    'Yiyecek',
    'Atıştırmalık',
    'Meyve',
    'Sebze',
    'Su',
    'İçecek',
    'Süt Ürünleri',
    'Fırın',
    'Et&Tavuk',
    'Fit&Form',
    'Kişisel Bakım',
    'Ev Bakım',
    'Evcil Hayvan',
    'Bebek',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 24.0, // Dikey boşluk
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        String boxName = categories[index];
        return Column(
          children: [
            Expanded(
              child: Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 8.0), // Kutunun altına boşluk
            Text(
              boxName,
              style: TextStyle(color: Colors.black, fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
