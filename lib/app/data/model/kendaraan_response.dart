import 'dart:convert';

KendaraanResponseModel kendaraanResponseModelFromJson(String str) =>
    KendaraanResponseModel.fromJson(json.decode(str));

String kendaraanResponseModelToJson(KendaraanResponseModel data) =>
    json.encode(data.toJson());

class KendaraanResponseModel {
  String status;
  String message;
  List<Kendaraan> data;

  KendaraanResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory KendaraanResponseModel.fromJson(Map<String, dynamic> json) =>
      KendaraanResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<Kendaraan>.from(
            json["data"].map((x) => Kendaraan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Kendaraan {
  int id;
  DateTime tanggal;
  int noUrut;
  String noPolisi;
  int jenisKendaraanId;
  int tujuanId;
  int transportId;
  int used;
  dynamic queueId;
  Transport transport;
  Tujuan tujuan;
  JenisKendaraan jenisKendaraan;
  String jamMasuk;

  Kendaraan({
    required this.id,
    required this.tanggal,
    required this.noUrut,
    required this.noPolisi,
    required this.jenisKendaraanId,
    required this.tujuanId,
    required this.transportId,
    required this.used,
    required this.queueId,
    required this.transport,
    required this.tujuan,
    required this.jenisKendaraan,
    required this.jamMasuk,
  });

  factory Kendaraan.fromJson(Map<String, dynamic> json) => Kendaraan(
        id: json["id"],
        tanggal: DateTime.parse(json["tanggal"]),
        noUrut: json["no_urut"],
        noPolisi: json["no_polisi"],
        jenisKendaraanId: json["jenis_kendaraan_id"],
        tujuanId: json["tujuan_id"],
        transportId: json["transport_id"],
        used: json["used"],
        queueId: json["queue_id"],
        transport: Transport.fromJson(json["transport"]),
        tujuan: Tujuan.fromJson(json["tujuan"]),
        jenisKendaraan: JenisKendaraan.fromJson(json["jenis_kendaraan"]),
        jamMasuk: json["jam_masuk"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "no_urut": noUrut,
        "no_polisi": noPolisi,
        "jenis_kendaraan_id": jenisKendaraanId,
        "tujuan_id": tujuanId,
        "transport_id": transportId,
        "used": used,
        "queue_id": queueId,
        "transport": transport.toJson(),
        "tujuan": tujuan.toJson(),
        "jenis_kendaraan": jenisKendaraan.toJson(),
        "jam_masuk": jamMasuk,
      };
}

class JenisKendaraan {
  int id;
  String jenisKendaraan;

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

class Transport {
  int id;
  String transport;

  Transport({
    required this.id,
    required this.transport,
  });

  factory Transport.fromJson(Map<String, dynamic> json) => Transport(
        id: json["id"],
        transport: json["transport"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transport": transport,
      };
}

class Tujuan {
  int id;
  String tujuan;

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
