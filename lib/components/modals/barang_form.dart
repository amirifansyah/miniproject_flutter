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
  late String kode; 
  late String nama;
  late String kategori;
  late double harga;

  @override
  void initState() {
    super.initState();
    if (widget.barang != null) {
      kode = widget.barang!.kode; 
      nama = widget.barang!.nama;
      kategori = widget.barang!.kategori;
      harga = widget.barang!.harga;
    } else {
      
      kode = ''; 
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
              keyboardType: TextInputType.number, 
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
                id: widget.barang?.id ?? 0, 
                kode: kode, 
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
