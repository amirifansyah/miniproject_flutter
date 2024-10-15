class ItemPenjualan {
  String kodeBarang;
  int qty;

  ItemPenjualan({
    required this.kodeBarang,
    required this.qty,
  });

  factory ItemPenjualan.fromJson(Map<String, dynamic> json) {
    return ItemPenjualan(
      kodeBarang: json['kode_barang'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode_barang': kodeBarang,
      'qty': qty,
    };
  }
}
