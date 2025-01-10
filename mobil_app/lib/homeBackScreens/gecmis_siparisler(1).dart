import 'package:flutter/material.dart';

class PastOrdersScreen extends StatelessWidget {
  final List<String> pastOrders = []; // Geçmiş siparişler burada tutulacak

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
        title: Text(
          'Geçmiş Siparişler',
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
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
              children: [
                if (pastOrders.isEmpty) 
                  _buildNoOrdersMessage(),
                if (pastOrders.isNotEmpty) 
                  _buildPastOrdersList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Geçmiş siparişlerin listesi
  Widget _buildPastOrdersList() {
    return Expanded(
      child: ListView.builder(
        itemCount: pastOrders.length,
        itemBuilder: (context, index) {
          return _buildOrderCard(pastOrders[index]);
        },
      ),
    );
  }

  // Sipariş kartı
  Widget _buildOrderCard(String orderDetails) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        orderDetails,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }

  // Geçmiş sipariş yok mesajı
  Widget _buildNoOrdersMessage() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'Geçmiş Sipariş Yok',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    );
  }
}
