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

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      id: json['id'] as int, 
      kode: json['kode'] as String, 
      nama: json['nama'] as String, 
      kategori: json['kategori'] as String, 
      harga: double.tryParse(json['harga'].toString()) ?? 0.0, 
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
