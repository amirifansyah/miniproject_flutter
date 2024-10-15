import 'package:flutter/material.dart';
import '../../models/barang.dart';

class BarangDetailPage extends StatelessWidget {
  final Barang barang;

  const BarangDetailPage({Key? key, required this.barang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Barang')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode: ${barang.kode}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Nama: ${barang.nama}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Kategori: ${barang.kategori}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Harga: ${barang.harga}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
