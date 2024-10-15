class Pelanggan {
  final int id;
  final String idPelanggan;
  final String nama;
  final String domisili;
  final String jenisKelamin;

  Pelanggan({
    required this.id,
    required this.idPelanggan,
    required this.nama,
    required this.domisili,
    required this.jenisKelamin,
  });

  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    return Pelanggan(
      id: json['id'],
      idPelanggan: json['id_pelanggan'],
      nama: json['nama'],
      domisili: json['domisili'],
      jenisKelamin: json['jenis_kelamin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_pelanggan': idPelanggan,
      'nama': nama,
      'domisili': domisili,
      'jenis_kelamin': jenisKelamin,
    };
  }
}
