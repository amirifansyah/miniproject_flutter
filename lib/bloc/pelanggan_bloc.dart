import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/pelanggan.dart' as pelanggan_model; 
import '../services/api_service.dart';

class PelangganCubit extends Cubit<List<pelanggan_model.Pelanggan>> {
  final ApiService apiService;

  PelangganCubit(this.apiService) : super([]);

  void fetchPelanggan() async {
    final pelanggan = await apiService.getPelanggan();
    emit(pelanggan);
  }

  Future<void> createPelanggan(pelanggan_model.Pelanggan pelanggan) async {
    await apiService.createPelanggan(pelanggan);
    fetchPelanggan(); 
  }

  Future<void> updatePelanggan(pelanggan_model.Pelanggan pelanggan) async {
    await apiService.updatePelanggan(pelanggan);
    fetchPelanggan(); 
  }

  Future<void> deletePelanggan(String idPelanggan) async {
    await apiService.deletePelanggan(idPelanggan);
    fetchPelanggan(); 
  }
}
