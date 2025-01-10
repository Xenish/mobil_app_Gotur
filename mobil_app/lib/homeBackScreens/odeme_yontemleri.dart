import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatefulWidget {
  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  List<String> savedCards = []; // Kaydedilen kartlar burada tutulacak

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
          'Ödeme Yöntemleri',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSavedCardsList(),
                SizedBox(height: 20),
                _buildAddCardButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Kaydedilen kartlar listesi
  Widget _buildSavedCardsList() {
    if (savedCards.isEmpty) {
      return Center(
        child: Text(
          'Henüz Kart Kaydedilmemiş',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: savedCards.length,
        itemBuilder: (context, index) {
          return _buildCardItem(savedCards[index]);
        },
      ),
    );
  }

  // Kaydedilen kart kartı
  Widget _buildCardItem(String cardDetails) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        cardDetails,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }

  // Kart ekle butonu
  Widget _buildAddCardButton() {
    return ElevatedButton(
      onPressed: () {
        _showCardInputDialog(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
      ),
      child: Text(
        'Kart Ekle',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  // Kart ekleme diyalogu
  Future<void> _showCardInputDialog(BuildContext context) async {
    TextEditingController cardNumberController = TextEditingController();
    TextEditingController cardHolderController = TextEditingController();
    TextEditingController expiryDateController = TextEditingController();
    TextEditingController cvvController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kart Bilgileri'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(
                  controller: cardNumberController,
                  label: 'Kart Numarası',
                  hintText: 'Kart numarasını girin',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 8.0),
                _buildTextField(
                  controller: cardHolderController,
                  label: 'Kart Sahibi',
                  hintText: 'Kart sahibinin adını girin',
                ),
                SizedBox(height: 8.0),
                _buildTextField(
                  controller: expiryDateController,
                  label: 'Son Kullanma Tarihi',
                  hintText: 'MM/YY',
                  keyboardType: TextInputType.datetime,
                ),
                SizedBox(height: 8.0),
                _buildTextField(
                  controller: cvvController,
                  label: 'CVV',
                  hintText: 'CVV kodu',
                  obscureText: true,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Kaydet'),
              onPressed: () {
                if (cardNumberController.text.isNotEmpty &&
                    cardHolderController.text.isNotEmpty &&
                    expiryDateController.text.isNotEmpty &&
                    cvvController.text.isNotEmpty) {
                  setState(() {
                    savedCards.add(
                        'Kart Sahibi: ${cardHolderController.text}, Kart Numarası: ${cardNumberController.text}');
                  });

                  Navigator.of(context).pop();

                  _showSuccessAlert(context);
                } else {
                  // Hata mesajı veya validasyon işlemi yapılabilir
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Kart bilgileri girildikten sonra başarılı kaydedildi mesajı
  void _showSuccessAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Başarıyla Kaydedildi'),
          content: Text('Kartınız başarıyla kaydedildi.'),
          actions: <Widget>[
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // TextField bileşeni
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
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
}
