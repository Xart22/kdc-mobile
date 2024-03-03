import 'dart:convert';

TujuanResponse tujuanResponseFromJson(String str) =>
    TujuanResponse.fromJson(json.decode(str));

String tujuanResponseToJson(TujuanResponse data) => json.encode(data.toJson());

class TujuanResponse {
  final String status;
  final String message;
  final List<Tujuan> data;

  TujuanResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TujuanResponse.fromJson(Map<String, dynamic> json) => TujuanResponse(
        status: json["status"],
        message: json["message"],
        data: List<Tujuan>.from(json["data"].map((x) => Tujuan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Tujuan {
  final int id;
  final String tujuan;
  Tujuan({
    required this.id,
    required this.tujuan,
  });

  factory Tujuan.fromJson(Map<String, dynamic> json) => Tujuan(
        id: json["id"],
        tujuan: json["tujuan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tujuan": tujuan,
      };
}
