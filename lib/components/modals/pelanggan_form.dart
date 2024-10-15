import 'package:flutter/material.dart';
import '../../models/pelanggan.dart';

class PelangganForm extends StatefulWidget {
  final Pelanggan? pelanggan;

  const PelangganForm({super.key, this.pelanggan});

  @override
  _PelangganFormState createState() => _PelangganFormState();
}

class _PelangganFormState extends State<PelangganForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _domisiliController;
  late String _jenisKelamin;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.pelanggan?.nama ?? '');
    _domisiliController = TextEditingController(text: widget.pelanggan?.domisili ?? '');
    _jenisKelamin = widget.pelanggan?.jenisKelamin ?? 'L'; 
  }

  @override
  void dispose() {
    _namaController.dispose();
    _domisiliController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.pelanggan == null ? 'Tambah Pelanggan' : 'Edit Pelanggan'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _domisiliController,
              decoration: const InputDecoration(labelText: 'Domisili'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Domisili tidak boleh kosong';
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              value: _jenisKelamin,
              items: const [
                DropdownMenuItem(child: Text('Laki-laki'), value: 'L'),
                DropdownMenuItem(child: Text('Perempuan'), value: 'P'),
              ],
              onChanged: (value) {
                setState(() {
                  _jenisKelamin = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
              validator: (value) {
                if (value == null) {
                  return 'Jenis kelamin tidak boleh kosong';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop(Pelanggan(
                id: widget.pelanggan?.id ?? DateTime.now().millisecondsSinceEpoch.toInt(),
                idPelanggan: widget.pelanggan?.idPelanggan ?? 'PELANGGAN_${DateTime.now().millisecondsSinceEpoch}',
                nama: _namaController.text,
                domisili: _domisiliController.text,
                jenisKelamin: _jenisKelamin,
              ));
            }
          },
          child: const Text('Simpan'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Batal'),
        ),
      ],
    );
  }
}
