import 'dart:convert';

List<QueueModel> queueModelFromJson(String str) =>
    List<QueueModel>.from(json.decode(str).map((x) => QueueModel.fromJson(x)));

String queueModelToJson(List<QueueModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QueueModel {
  final int id;
  final int gate;
  final int tujuanId;
  final int transportId;
  final int jenisKendaraanId;
  final String noSpk;
  final String noDo;
  final String volume;
  final int batch;
  final String status;
  final String mulaiMuat;
  final String selesaiMuat;
  final Tujuan tujuan;
  final Transport transport;
  final JenisKendaraan jenisKendaraan;

  QueueModel({
    required this.id,
    required this.gate,
    required this.tujuanId,
    required this.transportId,
    required this.jenisKendaraanId,
    required this.noSpk,
    required this.noDo,
    required this.volume,
    required this.batch,
    required this.status,
    required this.mulaiMuat,
    required this.selesaiMuat,
    required this.tujuan,
    required this.transport,
    required this.jenisKendaraan,
  });

  factory QueueModel.fromJson(Map<String, dynamic> json) => QueueModel(
        id: json["id"],
        gate: json["gate"],
        tujuanId: json["tujuanId"],
        transportId: json["transportId"],
        jenisKendaraanId: json["jenis_kendaraanId"],
        noSpk: json["no_spk"],
        noDo: json["no_do"],
        volume: json["volume"],
        batch: json["batch"],
        status: json["status"],
        mulaiMuat: json["mulai_muat"],
        selesaiMuat: json["selesai_muat"],
        tujuan: Tujuan.fromJson(json["tujuan"]),
        transport: Transport.fromJson(json["transport"]),
        jenisKendaraan: JenisKendaraan.fromJson(json["jenis_kendaraan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gate": gate,
        "tujuanId": tujuanId,
        "transportId": transportId,
        "jenis_kendaraanId": jenisKendaraanId,
        "no_spk": noSpk,
        "no_do": noDo,
        "volume": volume,
        "batch": batch,
        "status": status,
        "mulai_muat": mulaiMuat,
        "selesai_muat": selesaiMuat,
        "tujuan": tujuan.toJson(),
        "transport": transport.toJson(),
        "jenis_kendaraan": jenisKendaraan.toJson(),
      };
}

class JenisKendaraan {
  final String jenisKendaraan;

  JenisKendaraan({
    required this.jenisKendaraan,
  });

  factory JenisKendaraan.fromJson(Map<String, dynamic> json) => JenisKendaraan(
        jenisKendaraan: json["jenis_kendaraan"],
      );

  Map<String, dynamic> toJson() => {
        "jenis_kendaraan": jenisKendaraan,
      };
}

class Transport {
  final String transport;

  Transport({
    required this.transport,
  });

  factory Transport.fromJson(Map<String, dynamic> json) => Transport(
        transport: json["transport"],
      );

  Map<String, dynamic> toJson() => {
        "transport": transport,
      };
}

class Tujuan {
  final String tujuan;

  Tujuan({
    required this.tujuan,
  });

  factory Tujuan.fromJson(Map<String, dynamic> json) => Tujuan(
        tujuan: json["tujuan"],
      );

  Map<String, dynamic> toJson() => {
        "tujuan": tujuan,
      };
}
