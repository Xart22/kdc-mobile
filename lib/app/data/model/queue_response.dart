import 'dart:convert';

QueueModel queueModelFromJson(String str) =>
    QueueModel.fromJson(json.decode(str));

String queueModelToJson(QueueModel data) => json.encode(data.toJson());

class QueueModel {
  final List<Queue>? data;

  QueueModel({
    this.data,
  });

  factory QueueModel.fromJson(Map<String, dynamic> json) => QueueModel(
        data: List<Queue>.from(json["data"] != null
            ? json["data"].map((x) => Queue.fromJson(x))
            : []),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Queue {
  final int id;
  final String status;

  Queue({
    required this.id,
    required this.status,
  });

  factory Queue.fromJson(Map<String, dynamic> json) => Queue(
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
}

class CreatedBy {
  final int id;
  final String username;
  final String name;
  final String role;

  CreatedBy({
    required this.id,
    required this.username,
    required this.name,
    required this.role,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "role": role,
      };
}
