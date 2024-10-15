import 'package:flutter/material.dart';
import '../../models/barang.dart';

class BarangForm extends StatefulWidget {
  final Barang? barang;

  const BarangForm({Key? key, this.barang}) : super(key: key);

  @override
  _BarangFormState createState() => _BarangFormState();
}

class _BarangFormState extends State<BarangForm> {
  final _formKey = GlobalKey<FormState>();
  late String kode; // Field kode untuk disimpan tetapi tidak ditampilkan
  late String nama;
  late String kategori;
  late double harga;

  @override
  void initState() {
    super.initState();
    if (widget.barang != null) {
      // Menggunakan data dari barang yang ada
      kode = widget.barang!.kode; // Ambil kode dari objek yang ada
      nama = widget.barang!.nama;
      kategori = widget.barang!.kategori;
      harga = widget.barang!.harga;
    } else {
      // Mengatur nilai default untuk barang baru
      kode = ''; // Atur default untuk kode
      nama = '';
      kategori = '';
      harga = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.barang == null ? 'Tambah Barang' : 'Edit Barang'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Field kode tidak ditampilkan di UI
            // Anda bisa menyimpan kode di sini tetapi tidak membuat TextFormField untuk menampilkannya

            TextFormField(
              initialValue: nama,
              decoration: const InputDecoration(labelText: 'Nama'),
              onSaved: (value) => nama = value!,
              validator: (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null,
            ),
            TextFormField(
              initialValue: kategori,
              decoration: const InputDecoration(labelText: 'Kategori'),
              onSaved: (value) => kategori = value!,
              validator: (value) => value!.isEmpty ? 'Kategori tidak boleh kosong' : null,
            ),
            TextFormField(
              initialValue: harga.toString(),
              decoration: const InputDecoration(labelText: 'Harga'),
              keyboardType: TextInputType.number, // Mengizinkan input angka
              onSaved: (value) => harga = double.parse(value!),
              validator: (value) => value!.isEmpty ? 'Harga tidak boleh kosong' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final newBarang = Barang(
                id: widget.barang?.id ?? 0, // Gunakan 0 atau id default untuk barang baru
                kode: kode, // Simpan kode di objek Barang
                nama: nama,
                kategori: kategori,
                harga: harga,
              );
              Navigator.pop(context, newBarang);
            }
          },
          child: const Text('Simpan'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
      ],
    );
  }
}
