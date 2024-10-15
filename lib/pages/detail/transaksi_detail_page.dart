// pages/detail/transaksi_detail_page.dart
import 'package:flutter/material.dart';
import '../../models/transaksi.dart';

class TransaksiDetailPage extends StatelessWidget {
  final Transaksi transaksi;

  const TransaksiDetailPage({
    Key? key,
    required this.transaksi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID Nota: ${transaksi.idNota}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Tanggal: ${transaksi.tanggal}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Kode Pelanggan: ${transaksi.kodePelanggan}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Nama Pelanggan: ${transaksi.pelanggan?.nama ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Subtotal: ${transaksi.subtotal}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Items:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SingleChildScrollView(
              child: DataTable(
                columnSpacing: 0, // Menghapus jarak antara kolom
                columns: [
                  DataColumn(label: Container(width: 200, child: Text('Kode Barang'))), // Lebar kolom yang lebih besar
                  DataColumn(label: Container(width: 150, child: Text('Qty'))), // Lebar kolom yang lebih besar
                ],
                rows: transaksi.items.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(Text(item.kodeBarang)),
                      DataCell(Text('${item.qty}')),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
