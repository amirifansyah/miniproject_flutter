import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pelanggan.dart' as pelanggan_model; // Menggunakan alias
import '../models/barang.dart';
import '../models/transaksi.dart';
import '../models/item_penjualan.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  // Pelanggan
  Future<List<pelanggan_model.Pelanggan>> getPelanggan() async {
    final response = await http.get(Uri.parse('$baseUrl/pelanggan'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((pel) => pelanggan_model.Pelanggan.fromJson(pel))
          .toList();
    } else {
      throw Exception('Failed to load pelanggan: ${response.statusCode}');
    }
  }

  Future<void> createPelanggan(pelanggan_model.Pelanggan pelanggan) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pelanggan'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pelanggan.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create pelanggan: ${response.body}');
    }
  }

  Future<void> deletePelanggan(String idPelanggan) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/pelanggan/$idPelanggan'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete pelanggan: ${response.body}');
    }
  }

  Future<void> updatePelanggan(pelanggan_model.Pelanggan pelanggan) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pelanggan/${pelanggan.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pelanggan.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update pelanggan: ${response.body}');
    }
  }

  // Barang
  Future<List<Barang>> getBarang() async {
    final response = await http.get(Uri.parse('$baseUrl/barang'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((bar) => Barang.fromJson(bar)).toList();
    } else {
      throw Exception('Failed to load barang: ${response.statusCode}');
    }
  }

  Future<void> createBarang(Barang barang) async {
    final response = await http.post(
      Uri.parse('$baseUrl/barang'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(barang.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create barang: ${response.body}');
    }
  }

  Future<void> updateBarang(Barang barang) async {
    final response = await http.put(
      Uri.parse('$baseUrl/barang/${barang.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(barang.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update barang: ${response.body}');
    }
  }

  Future<void> deleteBarang(String idBarang) async {
    final response = await http.delete(Uri.parse('$baseUrl/barang/$idBarang'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete barang: ${response.body}');
    }
  }

  // Transaksi
  Future<List<Transaksi>> getTransaksi({int page = 1}) async {
    final response = await http.get(Uri.parse('$baseUrl/penjualan?page=$page'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((transaksi) => Transaksi.fromJson(transaksi))
          .toList();
    } else {
      throw Exception('Failed to load transaksi: ${response.statusCode}');
    }
  }

  Future<void> createTransaksi({
    required String tanggal,
    required String kodePelanggan,
    required List<ItemPenjualan> itemPenjualans,
    required double subtotal,
  }) async {
    final formattedTransaksi = {
      "tanggal": tanggal,
      "kode_pelanggan": kodePelanggan,
      "items": itemPenjualans.map((item) {
        return {"kode_barang": item.kodeBarang, "qty": item.qty.toString()};
      }).toList(),
      "subtotal": subtotal
    };

    final response = await http.post(
      Uri.parse('$baseUrl/penjualan'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(formattedTransaksi),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create transaksi: ${response.body}');
    }
  }

  Future<void> updateTransaksi(Transaksi transaksi) async {
  final formattedTransaksi = {
    "tanggal": transaksi.tanggal,
    "kode_pelanggan": transaksi.kodePelanggan,
    "items": transaksi.items.map((item) {
      return {
        "kode_barang": item.kodeBarang,
        "qty": item.qty.toString(),
      };
    }).toList(),
    "subtotal": transaksi.subtotal,
  };

  final response = await http.put(
    Uri.parse('$baseUrl/penjualan/${transaksi.id}'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(formattedTransaksi),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update transaksi: ${response.body}');
  }
}


  Future<void> deleteTransaksi(String idNota) async {
    final response = await http.delete(Uri.parse('$baseUrl/penjualan/$idNota'));
    print('Delete response status: ${response.statusCode}'); // Log status code
    if (response.statusCode != 204) {
      throw Exception('Failed to delete transaksi: ${response.body}');
    }
  }
}
