import 'item_penjualan.dart';
import 'pelanggan.dart';

class Transaksi {
  final int id; 
  final String idNota;
  final String tanggal;
  final String kodePelanggan;
  final List<ItemPenjualan> items;
  final Pelanggan? pelanggan; 
  final double subtotal; 

  Transaksi({
    required this.id,
    required this.idNota,
    required this.tanggal,
    required this.kodePelanggan,
    required this.items,
    this.pelanggan,
    required this.subtotal,
  });

  Map<String, dynamic> toJson() {
    return {
      'tanggal': tanggal,
      'kode_pelanggan': kodePelanggan,
      'item_penjualans': items.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
    };
  }

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['item_penjualans'] as List;
    List<ItemPenjualan> itemList = itemsFromJson.map((i) => ItemPenjualan.fromJson(i)).toList();

    return Transaksi(
      id: json['id'],
      idNota: json['id_nota'],
      tanggal: json['tanggal'],
      kodePelanggan: json['kode_pelanggan'],
      items: itemList,
      pelanggan: json['pelanggan'] != null ? Pelanggan.fromJson(json['pelanggan']) : null,
      subtotal: double.parse(json['subtotal']),
    );
  }
}
