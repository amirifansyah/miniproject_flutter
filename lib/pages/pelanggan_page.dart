import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/pelanggan_bloc.dart';
import '../models/pelanggan.dart';
import '../components/modals/pelanggan_form.dart';
import '../pages/detail/pelanggan_detail_page.dart';

class PelangganPage extends StatefulWidget {
  const PelangganPage({super.key});

  @override
  _PelangganPageState createState() => _PelangganPageState();
}

class _PelangganPageState extends State<PelangganPage> {
  @override
  void initState() {
    super.initState();
    context.read<PelangganCubit>().fetchPelanggan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Pelanggan')),
      body: BlocBuilder<PelangganCubit, List<Pelanggan>>(
        builder: (context, pelangganList) {
          if (pelangganList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: pelangganList.length,
            itemBuilder: (context, index) {
              final pelanggan = pelangganList[index];
              return ListTile(
                title: Text(pelanggan.nama),
                subtitle: Text('${pelanggan.domisili} | Jenis Kelamin: ${pelanggan.jenisKelamin == 'L' ? "Laki-laki" : "Perempuan"}'),
                onTap: () => _showDetailPage(context, pelanggan), 
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showPelangganForm(context, pelanggan), 
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deletePelanggan(context, pelanggan),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPelangganForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showPelangganForm(BuildContext context, [Pelanggan? pelanggan]) async {
    final newPelanggan = await showDialog<Pelanggan>(
      context: context,
      builder: (context) => PelangganForm(pelanggan: pelanggan),
    );

    if (newPelanggan != null) {
      if (pelanggan == null) {
        context.read<PelangganCubit>().createPelanggan(newPelanggan);
        _showSnackbar(context, 'Pelanggan berhasil ditambahkan.');
      } else {
        context.read<PelangganCubit>().updatePelanggan(newPelanggan);
        _showSnackbar(context, 'Pelanggan berhasil diupdate.');
      }
    }
  }

  void _showDetailPage(BuildContext context, Pelanggan pelanggan) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PelangganDetailPage(pelanggan: pelanggan),
      ),
    );
  }

  void _deletePelanggan(BuildContext context, Pelanggan pelanggan) {
    context.read<PelangganCubit>().deletePelanggan(pelanggan.id.toString());
    _showSnackbar(context, 'Pelanggan berhasil dihapus.');
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
