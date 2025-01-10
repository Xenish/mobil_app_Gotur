import 'package:flutter/material.dart';
import 'package:mobil_app/screens/delivery_screen.dart';
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

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;
  bool showInputFields = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Ödeme Ekranı',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                _buildPaymentMethodSelector(context),
                if (selectedPaymentMethod != null)
                  SizedBox(height: 16.0),
                if (selectedPaymentMethod != null)
                  _buildSelectedPaymentContainer(),
                if (showInputFields)
                  SizedBox(height: 16.0),
                if (showInputFields)
                  _buildInputContainer(),
                Spacer(),
                Row(
                  children: [
                    Expanded(child: _buildDeliveryAddress()),
                    SizedBox(width: 16.0),
                    _buildCompletePaymentButton(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  
Widget _buildPaymentMethodSelector(BuildContext context) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.indigo,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('Nakit', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = 'Nakit';
                      showInputFields = false;
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Kredi Kartı', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = 'Kredi Kartı';
                      showInputFields = true;
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Yemek Kartı', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = 'Yemek Kartı';
                      showInputFields = false;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.indigo),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'Ödeme Yöntemini Seçiniz',
        style: TextStyle(color: Colors.indigo),
      ),
    ),
  );
}


  Widget _buildSelectedPaymentContainer() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.indigo),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      'Seçilen: $selectedPaymentMethod',
      style: TextStyle(color: Colors.indigo),
    ),
  );
}

  Widget _buildInputContainer() {
  return FractionallySizedBox(
    widthFactor: 0.7, // Genişliği %70 olarak ayarladık
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.indigo),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildTextField(label: 'Adınız', hintText: 'Adınızı girin'),
          SizedBox(height: 8.0),
          _buildTextField(label: 'Soyadınız', hintText: 'Soyadınızı girin'),
          SizedBox(height: 8.0),
          _buildTextField(label: 'Kart Numarası', hintText: 'Kart numarasını girin'),
          SizedBox(height: 8.0),
          _buildTextField(label: 'Son Kullanma Tarihi', hintText: 'MM/YY', keyboardType: TextInputType.datetime),
          SizedBox(height: 8.0),
          _buildTextField(label: 'CVV', hintText: 'CVV kodu', obscureText: true),
        ],
      ),
    ),
  );
}


  Widget _buildTextField({
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white60),
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.indigo,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
Widget _buildDeliveryAddress() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16.0),
    height: 70.0,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.circular(30.0),
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
  );
}

Widget _buildCompletePaymentButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Başarılı!'),
            content: Text('Ödemeniz alındı.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeliveryScreen(isNavigated: true,)),
                  );
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.indigo,
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
    ),
    child: Text(
      'Ödemeyi Tamamla',
      style: TextStyle(color: Colors.white),
    ),
  );
}

Widget _buildAddressAndPaymentButtons(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,  // Ekstra boşluk bırakmaması için.
    children: [
      // Adres Kutucuğu
      _buildDeliveryAddress(),

      // Boşluk
      SizedBox(height: 8.0),

      // Ödemeyi Tamamla Butonu
      _buildCompletePaymentButton(context),
    ],
  );
}

}