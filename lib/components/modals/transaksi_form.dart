import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../models/transaksi.dart';
import '../../models/item_penjualan.dart';
import '../../models/pelanggan.dart';
import '../../models/barang.dart';

class TransaksiForm extends StatefulWidget {
  final Transaksi? initialData;
  final List<Pelanggan> pelangganData;
  final List<Barang> barangsData;

  const TransaksiForm({
    Key? key,
    this.initialData,
    required this.pelangganData,
    required this.barangsData,
  }) : super(key: key);

  @override
  _TransaksiFormState createState() => _TransaksiFormState();
}

class _TransaksiFormState extends State<TransaksiForm> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> formData;
  double subtotal = 0.0;

  @override
  void initState() {
    super.initState();
    formData = widget.initialData != null
        ? {
            'tanggal': widget.initialData!.tanggal,
            'kode_pelanggan': widget.initialData!.kodePelanggan,
            'items': widget.initialData!.items.map((item) {
              return {
                'kode_barang': item.kodeBarang,
                'qty': item.qty.toString(),
              };
            }).toList(),
          }
        : {'tanggal': '', 'kode_pelanggan': '', 'items': []};

    calculateSubtotal(formData['items']);
  }

  void calculateSubtotal(List items) {
    double total = 0.0;
    for (var item in items) {
      var barang = widget.barangsData.firstWhere(
        (b) => b.kode == item['kode_barang'],
        orElse: () => Barang(id: 0, kode: '', nama: '', kategori: '', harga: 0.0),
      );

      if (barang.id != 0) {
        int qty = int.tryParse(item['qty']) ?? 0;
        total += barang.harga * qty;
      }
    }
    setState(() {
      subtotal = total;
    });
  }

  void handleItemChange(int index, String field, dynamic value) {
    setState(() {
      formData['items'][index][field] = value;
      if (field == 'kode_barang') {
        var barang = widget.barangsData.firstWhere(
          (b) => b.kode == value,
          orElse: () => Barang(id: 0, kode: '', nama: '', kategori: '', harga: 0.0),
        );
        formData['items'][index]['harga'] = barang.harga.toString();
      }
    });
    calculateSubtotal(formData['items']);
  }

  void handleQtyChange(int index, String value) {
    setState(() {
      formData['items'][index]['qty'] = value.isEmpty ? '0' : value;
    });
    calculateSubtotal(formData['items']);
  }

  void addItem() {
    setState(() {
      formData['items'].add({'kode_barang': '', 'qty': '0'});
    });
    calculateSubtotal(formData['items']);
  }

  void deleteItem(int index) {
    setState(() {
      formData['items'].removeAt(index);
    });
    calculateSubtotal(formData['items']);
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final submittedItems = formData['items'].map<ItemPenjualan>((item) {
        return ItemPenjualan(
          kodeBarang: item['kode_barang'],
          qty: int.tryParse(item['qty']) ?? 1,
        );
      }).toList();

      final transaksi = Transaksi(
        id: widget.initialData?.id ?? 0,
        idNota: widget.initialData?.idNota ?? '',
        tanggal: formData['tanggal'],
        kodePelanggan: formData['kode_pelanggan'],
        items: submittedItems,
        subtotal: subtotal,
      );

      Navigator.of(context).pop(transaksi); // Kembali dengan data transaksi
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        formData['tanggal'] = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialData != null ? 'Edit Penjualan' : 'Tambah Penjualan'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Tanggal',
                      hintText: 'Pilih tanggal',
                    ),
                    controller: TextEditingController(text: formData['tanggal']),
                    validator: (value) => value!.isEmpty ? 'Tanggal tidak boleh kosong' : null,
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                value: formData['kode_pelanggan'].isEmpty ? null : formData['kode_pelanggan'],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      formData['kode_pelanggan'] = value;
                    });
                  }
                },
                decoration: const InputDecoration(labelText: 'Pelanggan'),
                items: widget.pelangganData.map((pelanggan) {
                  return DropdownMenuItem<String>(
                    value: pelanggan.idPelanggan,
                    child: Text(pelanggan.nama),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Pilih Pelanggan' : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Subtotal: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(subtotal)}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              ...formData['items'].asMap().entries.map((entry) {
                int index = entry.key;
                var item = entry.value;
                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: item['kode_barang'].isEmpty ? null : item['kode_barang'],
                        onChanged: (value) {
                          if (value != null) {
                            handleItemChange(index, 'kode_barang', value);
                          }
                        },
                        decoration: const InputDecoration(labelText: 'Kode Barang'),
                        items: widget.barangsData.map((barang) {
                          return DropdownMenuItem<String>(
                            value: barang.kode,
                            child: Text(barang.nama),
                          );
                        }).toList(),
                        validator: (value) => value == null ? 'Pilih Barang' : null,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        initialValue: item['qty'].toString(),
                        onChanged: (value) => handleQtyChange(index, value),
                        decoration: const InputDecoration(labelText: 'Qty'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteItem(index),
                    ),
                  ],
                );
              }).toList(),
              TextButton(
                onPressed: addItem,
                child: Text('Tambah Item'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: handleSubmit,
          child: const Text('Simpan'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Tutup dialog
          child: const Text('Tutup'),
        ),
      ],
    );
  }
}
