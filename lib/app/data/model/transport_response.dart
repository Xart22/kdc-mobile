import 'dart:convert';

TransportResponse transportResponseFromJson(String str) =>
    TransportResponse.fromJson(json.decode(str));

String transportResponseToJson(TransportResponse data) =>
    json.encode(data.toJson());

class TransportResponse {
  final String status;
  final String message;
  final List<Transport> data;

  TransportResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TransportResponse.fromJson(Map<String, dynamic> json) =>
      TransportResponse(
        status: json["status"],
        message: json["message"],
        data: List<Transport>.from(
            json["data"].map((x) => Transport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Transport {
  final int id;
  final String transport;

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
