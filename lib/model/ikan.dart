class Ikan {
  int? id;
  String? namaIkan;
  String? jenisIkan;
  String? warnaIkan;
  String? habitatIkan;
  Ikan(
      {this.id,
      this.namaIkan,
      this.jenisIkan,
      this.warnaIkan,
      this.habitatIkan});
  factory Ikan.fromJson(Map<String, dynamic> obj) {
    return Ikan(
        id: int.parse(obj['id']),
        namaIkan: obj['nama'],
        jenisIkan: obj['jenis'],
        warnaIkan: obj['warna'],
        habitatIkan: obj['habitat']);
  }
}
