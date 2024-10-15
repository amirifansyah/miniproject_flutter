class Barang {
  final int id;
  final String kode;
  final String nama;
  final String kategori;
  final double harga;

  Barang({
    required this.id,
    required this.kode,
    required this.nama,
    required this.kategori,
    required this.harga,
  });

  // Metode untuk konversi dari JSON dan sebaliknya
  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      id: json['id'] as int, // Pastikan id di-cast ke int
      kode: json['kode'] as String, // Pastikan kode di-cast ke String
      nama: json['nama'] as String, // Pastikan nama di-cast ke String
      kategori: json['kategori'] as String, // Pastikan kategori di-cast ke String
      harga: double.tryParse(json['harga'].toString()) ?? 0.0, // Konversi harga ke double
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode': kode,
      'nama': nama,
      'kategori': kategori,
      'harga': harga,
    };
  }
}
