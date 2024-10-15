import 'package:flutter/material.dart';
import '../../models/pelanggan.dart';

class PelangganDetailPage extends StatelessWidget {
  final Pelanggan pelanggan;

  const PelangganDetailPage({Key? key, required this.pelanggan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pelanggan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${pelanggan.id}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('ID Pelanggan: ${pelanggan.idPelanggan}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Nama: ${pelanggan.nama}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Domisili: ${pelanggan.domisili}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Jenis Kelamin: ${pelanggan.jenisKelamin == 'L' ? "Laki-laki" : "Perempuan"}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
