class Config {
  static const String baseUrl = "http://172.16.10.1:8080/kdc-be/public/api";

  static const String loginUrl = "$baseUrl/login";
  static const String logoutUrl = "$baseUrl/logout";

  static const String getNoUrut = "$baseUrl/vehicle/get-no-urut";
  static const String createVehicle = "$baseUrl/vehicle/create";
  static const String queuesUrl = "$baseUrl/queues";
  static const String queueByBatchUrl = "$baseUrl/queues/get-data-today";
  static const String batchUrl = "$baseUrl/master-data/batches";
  static const String jenisKendaraanUrl =
      "$baseUrl/master-data/jenis-kendaraan";
  static const String tujuan = "$baseUrl/master-data/tujuan";
  static const String transport = "$baseUrl/master-data/transport";
  static const String kendaraan = "$baseUrl/vehicle";
}
