import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/barang_bloc.dart'; 
import '../models/barang.dart';
import '../components/modals/barang_form.dart';
import '../pages/detail/barang_detail_page.dart';

class BarangPage extends StatefulWidget {
  const BarangPage({super.key});

  @override
  _BarangPageState createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  @override
  void initState() {
    super.initState();
    context.read<BarangCubit>().fetchBarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Barang')),
      body: BlocBuilder<BarangCubit, List<Barang>>(
        builder: (context, barangList) {
          if (barangList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: barangList.length,
            itemBuilder: (context, index) {
              final barang = barangList[index];
              return ListTile(
                title: Text(barang.nama),
                subtitle: Text('${barang.kategori} | Harga: ${barang.harga}'),
                onTap: () => _showDetailPage(context, barang), 
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showBarangForm(context, barang), 
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteBarang(context, barang),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBarangForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showBarangForm(BuildContext context, [Barang? barang]) async {
    final newBarang = await showDialog<Barang>(
      context: context,
      builder: (context) => BarangForm(barang: barang),
    );

    if (newBarang != null) {
      if (barang == null) {
        context.read<BarangCubit>().createBarang(newBarang);
        _showSnackbar(context, 'Barang berhasil ditambahkan.');
      } else {
        context.read<BarangCubit>().updateBarang(newBarang);
        _showSnackbar(context, 'Barang berhasil diupdate.');
      }
    }
  }

  void _showDetailPage(BuildContext context, Barang barang) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BarangDetailPage(barang: barang), 
      ),
    );
  }

  void _deleteBarang(BuildContext context, Barang barang) {
    context.read<BarangCubit>().deleteBarang(barang.id.toString());
    _showSnackbar(context, 'Barang berhasil dihapus.');
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
