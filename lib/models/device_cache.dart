import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

// 创建CacheManager对象
final cacheManager = CacheManager(Config('device_cache_key'));

// 缓存自定义对象
BluetoothDevice myDevice = BluetoothDevice(name: '默认值', address: '默认值');
var encoder = JsonEncoder();
var data = encoder.convert(myDevice);

Future<Uint8List> strToList(String value1) async {
  value1 = value1.trim();
  List<int> list = value1.codeUnits;
  Uint8List bytes = Uint8List.fromList(list);
  return bytes;
}

var file = cacheManager.putFile('device', strToList(data) as Uint8List);

// 从缓存中获取自定义对象
var fileGet = cacheManager.getFileFromCache('device');
