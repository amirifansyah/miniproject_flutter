import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/transaksi.dart';
import '../services/api_service.dart';

class TransaksiCubit extends Cubit<List<Transaksi>> {
  final ApiService apiService;

  TransaksiCubit(this.apiService) : super([]);

  Future<void> fetchTransaksi() async {
    try {
      final transaksiList = await apiService.getTransaksi();
      emit(transaksiList);
    } catch (e) {
      print('Error fetching transaksi: $e');
    }
  }

Future<void> createTransaksi(Transaksi transaksi) async {
  try {
    await apiService.createTransaksi(
      tanggal: transaksi.tanggal,
      kodePelanggan: transaksi.kodePelanggan,
      itemPenjualans: transaksi.items, 
      subtotal: transaksi.subtotal,
    );
    await fetchTransaksi(); 
  } catch (e) {
    print('Error creating transaksi: $e');
  }
}


  Future<void> updateTransaksi(Transaksi transaksi) async {
    try {
      await apiService.updateTransaksi(transaksi);
      fetchTransaksi();
    } catch (e) {
      print('Error updating transaksi: $e');
    }
  }

  Future<void> deleteTransaksi(String idNota) async {
    try {
      await apiService.deleteTransaksi(idNota);
      fetchTransaksi();
    } catch (e) {
      print('Error deleting transaksi: $e');
    }
  }
}
