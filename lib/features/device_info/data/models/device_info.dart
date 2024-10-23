class DeviceInfo {
  final String id;
  final String version;
  final String device;
  final String model;
  final String product;
  final String manufacturer;
  final String sdkVersion;
  const DeviceInfo({
    required this.id,
    required this.version,
    required this.device,
    required this.model,
    required this.product,
    required this.manufacturer,
    required this.sdkVersion,
  });

  DeviceInfo copyWith({
    String? id,
    String? version,
    String? device,
    String? model,
    String? product,
    String? manufacturer,
    String? sdkVersion,
  }) {
    return DeviceInfo(
      id: id ?? this.id,
      version: version ?? this.version,
      device: device ?? this.device,
      model: model ?? this.model,
      product: product ?? this.product,
      manufacturer: manufacturer ?? this.manufacturer,
      sdkVersion: sdkVersion ?? this.sdkVersion,
    );
  }

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      id: map['id'].toString(),
      version: map['version'].toString(),
      device: map['device'].toString(),
      model: map['model'].toString(),
      product: map['product'].toString(),
      manufacturer: map['manufacturer'].toString(),
      sdkVersion: map['sdkVersion'].toString(),
    );
  }

  factory DeviceInfo.fromJson(dynamic source) =>
      DeviceInfo.fromMap(source as Map<String, dynamic>);
}
