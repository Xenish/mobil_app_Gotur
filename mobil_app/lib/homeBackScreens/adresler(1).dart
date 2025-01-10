import 'package:flutter/material.dart';
import 'package:mobil_app/database/full_adress.dart';
import 'package:mobil_app/models/user_data.dart'; // Kullanıcı tanımı için burayı ekleyin

import 'package:mobil_app/database/full_adress.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  String? selectedAddress = '';

  // MetinController'ları tanımla
  TextEditingController _titleController = TextEditingController();
  TextEditingController _neighborhoodController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _buildingController = TextEditingController();
  TextEditingController _floorController = TextEditingController();
  TextEditingController _apartmentController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressDetailController = TextEditingController();

  // Adres bilgilerini birleştirme fonksiyonu
  void _combineAddress() {
    setState(() {
      FullAddress.fullAddress = '''
      ${_titleController.text.isNotEmpty ? _titleController.text + ', ' : ''}
      ${_neighborhoodController.text.isNotEmpty ? _neighborhoodController.text + ', ' : ''}
      ${_streetController.text.isNotEmpty ? _streetController.text + ', ' : ''}
      ${_buildingController.text.isNotEmpty ? _buildingController.text + ', ' : ''}
      ${_floorController.text.isNotEmpty ? _floorController.text + ', ' : ''}
      ${_apartmentController.text.isNotEmpty ? _apartmentController.text + ', ' : ''}
      ${_districtController.text.isNotEmpty ? _districtController.text + ', ' : ''}
      ${_cityController.text.isNotEmpty ? _cityController.text + ', ' : ''}
      ${_addressDetailController.text.isNotEmpty ? _addressDetailController.text : ''}
      ''';
    });
  }

  // Adres Kaydetme Fonksiyonu
  void _saveAddress() {
    setState(() {
      selectedAddress = FullAddress.fullAddress;
    });
  }

  void addAddress(BuildContext context) {
    setState(() {
      selectedAddress = FullAddress.fullAddress; // Update selectedAddress
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Adres Eklendi"),
          content: Text("Adres başarıyla eklendi."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Controller'ları temizle
    _titleController.dispose();
    _neighborhoodController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _floorController.dispose();
    _apartmentController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _addressDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adres Bilgileri', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Adres başlığı, mahalle, cadde yatay hizada
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Adres Başlığı',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.indigo,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _neighborhoodController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Mahalle',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.indigo,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _streetController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Cadde',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.indigo,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),

                // Bina numarası, kat, daire yatay hizada
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _buildingController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Bina Numarası',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.indigo,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _floorController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Kat',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.indigo,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _apartmentController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Daire',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.indigo,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),

                // İl, İlçe yatay hizada
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _districtController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'İlçe',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.indigo,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _cityController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'İl',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.indigo,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),

                // Adres Detayı
                TextField(
                  controller: _addressDetailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Adres Tarifi',
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.indigo,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),

                // Adres Kaydet Butonu
                ElevatedButton(
                  onPressed: () => addAddress(context),
                  child: Text('Adres Ekle', style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
