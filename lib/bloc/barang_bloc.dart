import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/barang.dart';
import '../services/api_service.dart';

class BarangCubit extends Cubit<List<Barang>> {
  final ApiService apiService;

  BarangCubit(this.apiService) : super([]);

  void fetchBarang() async {
    final barang = await apiService.getBarang();
    emit(barang);
  }

  Future<void> createBarang(Barang barang) async {
    await apiService.createBarang(barang);
    fetchBarang(); 
  }

  Future<void> updateBarang(Barang barang) async {
    await apiService.updateBarang(barang);
    fetchBarang(); 
  }

  Future<void> deleteBarang(String idBarang) async {
    await apiService.deleteBarang(idBarang);
    fetchBarang(); 
  }
}
