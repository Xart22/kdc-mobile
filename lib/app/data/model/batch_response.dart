import 'dart:convert';

BatchResponse batchResponseFromJson(String str) =>
    BatchResponse.fromJson(json.decode(str));

String batchResponseToJson(BatchResponse data) => json.encode(data.toJson());

class BatchResponse {
  final String status;
  final String message;
  final List<Batch> data;

  BatchResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BatchResponse.fromJson(Map<String, dynamic> json) => BatchResponse(
        status: json["status"],
        message: json["message"],
        data: List<Batch>.from(json["data"].map((x) => Batch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Batch {
  final int id;
  final String startTime;
  final String endTime;
  final int? no;

  Batch({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.no,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        id: json["id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        no: json["no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": startTime,
        "end_time": endTime,
        "no": no,
      };
}
