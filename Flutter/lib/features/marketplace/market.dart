import 'package:flutter/material.dart';

class Marketplace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marketplace App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Marketplace App'),
        ),
        body: ListView(
          children: [
            MarketplaceItem(
              sellerName: 'Ngọc Võ',
              time: '7:45',
              date: '19/03/2004',
              productName: 'Ghế văn phòng',
              price: '250,000 VNĐ',
            ),
            MarketplaceItem(
              sellerName: 'man',
              time: '',
              date: '',
              productName: 'Bàn học sinh',
              price: '80,000 VNĐ',
            ),
            MarketplaceItem(
              sellerName: 'Nguyễn H.Anh',
              time: '',
              date: '19/03/2024',
              productName: 'Truyện tranh Doraemon',
              price: '50,000 VNĐ',
            ),
            MarketplaceItem(
              sellerName: 'Huy Ngọc Trần',
              time: '',
              date: '14/02/2024',
              productName: 'Bàn phím cơ',
              price: '500,000 VNĐ',
            ),
          ],
        ),
      ),
    );
  }
}

class MarketplaceItem extends StatelessWidget {
  final String sellerName;
  final String time;
  final String date;
  final String productName;
  final String price;

  MarketplaceItem({
    required this.sellerName,
    required this.time,
    required this.date,
    required this.productName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sellerName,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              time + ' ' + date,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              productName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              price,
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}