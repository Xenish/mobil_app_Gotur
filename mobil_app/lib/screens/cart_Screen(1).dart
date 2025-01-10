import 'package:flutter/material.dart';
import 'package:mobil_app/screens/payment_screen.dart';

class CartItem {
  final String name;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });
}

class Cart {
  static final List<CartItem> _items = [];

  static List<CartItem> get items => _items;

  static void addItem(String name, String image, double price) {
    final existingItem = _items.firstWhere(
      (item) => item.name == name,
      orElse: () => CartItem(name: name, image: image, price: price),
    );

    if (_items.contains(existingItem)) {
      existingItem.quantity++;
    } else {
      _items.add(existingItem);
    }
  }

  static void removeItem(CartItem item) {
    _items.remove(item);
  }

  static double get totalPrice => _items.fold(
        0.0,
        (sum, item) => sum + item.price * item.quantity,
      );
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _incrementQuantity(CartItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void _decrementQuantity(CartItem item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        Cart.removeItem(item);
      }
    });
  }

  void _removeItem(CartItem item) {
    setState(() {
      Cart.removeItem(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sepetim', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Stack(
        children: [
          // Arka plan resmi
          Positioned.fill(
            child: Image.asset(
              'images/background.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          // Sepet ekranı içerikleri
          Column(
            children: [
              Cart.items.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          'Sepetiniz boş.',
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: Cart.items.length,
                        itemBuilder: (context, index) {
                          final item = Cart.items[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: ListTile(
                              leading: Image.asset(
                                item.image,
                                width: 50.0,
                                height: 50.0,
                                fit: BoxFit.cover,
                              ),
                              title: Text(item.name),
                              subtitle: Text(
                                'Birim Fiyat: ${item.price.toStringAsFixed(2)} ₺\nToplam: ${(item.price * item.quantity).toStringAsFixed(2)} ₺',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () => _decrementQuantity(item),
                                  ),
                                  Text(
                                    '${item.quantity}',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () => _incrementQuantity(item),
                                  ),
                                ],
                              ),
                              onLongPress: () => _removeItem(item),
                            ),
                          );
                        },
                      ),
                    ),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Toplam: ${Cart.totalPrice.toStringAsFixed(2)} ₺',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                      ),
                      child: Text('Satın Al', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
