import 'package:flutter/material.dart';
import 'package:mobil_app/database/full_adress.dart';
import 'package:mobil_app/homeBackScreens/adresler.dart';
import 'package:mobil_app/homeBackScreens/canli_destek.dart';
import 'package:mobil_app/homeBackScreens/gecmis_siparisler.dart';
import 'package:mobil_app/homeBackScreens/odeme_yontemleri.dart';
import 'package:mobil_app/screens/delivery_screen.dart';
import 'package:mobil_app/screens/order_screen.dart';
import 'screens/main_screen.dart';
import 'package:mobil_app/screens/login_screen.dart';
import 'package:mobil_app/screens/signup_screen.dart';
import 'package:mobil_app/screens/cart_Screen.dart';
import 'models/user_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Veritabanından kullanıcı verilerini ve adresleri yükle
  await UserData.loadFromDatabase();
  await FullAddress.loadFromDatabase();
  await UserData.saveToDatabase('ilker', '12');
  // Yeni bir adres tanımla
  // Yeni bir adres tanımla
  await FullAddress.saveToDatabase([
    "karlıktepe",
    "soğanlık",
    "ada",
    "13",
    "6",
    "13",
    "kartal",
    "istanbul"
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/cart': (context) => CartScreen(), // Sepet ekranı
        '/order': (context) => OrdersScreen(),
        '/orders': (context) => PastOrdersScreen(),
        '/payments': (context) => PaymentMethodsScreen(),
        '/support': (context) => LiveSupportScreen(),
        '/addresses': (context) => AddressScreen(),
        'delivery' : (context) => DeliveryScreen()
      },
    );
  }
}
