import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transaksi_bloc.dart';
import '../models/transaksi.dart';
import '../components/modals/transaksi_form.dart';
import '../pages/detail/transaksi_detail_page.dart';
import '../services/api_service.dart';
import '../models/pelanggan.dart';
import '../models/barang.dart';

class TransaksiPage extends StatelessWidget {
  const TransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TransaksiPageContent();
  }
}

class TransaksiPageContent extends StatefulWidget {
  const TransaksiPageContent({super.key});

  @override
  _TransaksiPageContentState createState() => _TransaksiPageContentState();
}

class _TransaksiPageContentState extends State<TransaksiPageContent> {
  List<Pelanggan> pelangganData = [];
  List<Barang> barangsData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    context.read<TransaksiCubit>().fetchTransaksi();
  }

  Future<void> fetchData() async {
    pelangganData = await ApiService().getPelanggan();
    barangsData = await ApiService().getBarang();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Transaksi')),
      body: BlocBuilder<TransaksiCubit, List<Transaksi>>(
        builder: (context, transaksiList) {
          if (transaksiList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: transaksiList.length,
            itemBuilder: (context, index) {
              final transaksi = transaksiList[index];
              return ListTile(
                title: Text(transaksi.idNota),
                subtitle: Text('Tanggal: ${transaksi.tanggal}'),
                onTap: () => _showDetailPage(context, transaksi),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showTransaksiForm(context, transaksi),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteTransaksi(context, transaksi),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTransaksiForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showTransaksiForm(BuildContext context, [Transaksi? transaksi]) async {
    final newTransaksi = await showDialog<Transaksi>(
      context: context,
      builder: (context) => TransaksiForm(
        initialData: transaksi,
        pelangganData: pelangganData,
        barangsData: barangsData,
      ),
    );

    if (newTransaksi != null) {
      if (transaksi == null) {
        context.read<TransaksiCubit>().createTransaksi(newTransaksi);
        _showSnackbar(context, 'Transaksi berhasil ditambahkan.');
      } else {
        context.read<TransaksiCubit>().updateTransaksi(newTransaksi);
        _showSnackbar(context, 'Transaksi berhasil diupdate.');
      }
    }
  }

  void _showDetailPage(BuildContext context, Transaksi transaksi) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransaksiDetailPage(transaksi: transaksi),
      ),
    );
  }

  void _deleteTransaksi(BuildContext context, Transaksi transaksi) {
    context.read<TransaksiCubit>().deleteTransaksi(transaksi.id.toString());
    _showSnackbar(context, 'Transaksi ${transaksi.idNota} berhasil dihapus.');
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
