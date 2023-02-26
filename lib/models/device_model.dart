
class DeviceModel {
  String id;
  String name;
  String deviceState;
  int laserPower;

  DeviceModel({
    required this.id,
    required this.name,
    required this.deviceState,
    this.laserPower = 0,
  });

}