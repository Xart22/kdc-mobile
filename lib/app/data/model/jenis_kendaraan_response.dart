import 'dart:convert';

JenisKendaraanResponse jenisKendaraanResponseFromJson(String str) =>
    JenisKendaraanResponse.fromJson(json.decode(str));

String jenisKendaraanResponseToJson(JenisKendaraanResponse data) =>
    json.encode(data.toJson());

class JenisKendaraanResponse {
  final String status;
  final String message;
  final List<JenisKendaraan> data;

  JenisKendaraanResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory JenisKendaraanResponse.fromJson(Map<String, dynamic> json) =>
      JenisKendaraanResponse(
        status: json["status"],
        message: json["message"],
        data: List<JenisKendaraan>.from(
            json["data"].map((x) => JenisKendaraan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class JenisKendaraan {
  final int id;
  final String jenisKendaraan;
  JenisKendaraan({
    required this.id,
    required this.jenisKendaraan,
  });

  factory JenisKendaraan.fromJson(Map<String, dynamic> json) => JenisKendaraan(
        id: json["id"],
        jenisKendaraan: json["jenis_kendaraan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis_kendaraan": jenisKendaraan,
      };
}
