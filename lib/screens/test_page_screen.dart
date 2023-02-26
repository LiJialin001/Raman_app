import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_bluetooth_serial_example/models/device_cache.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/components.dart';
import '../models/models.dart';


class TestPageScreen extends StatefulWidget {
  @override
  _TestPageScreen createState() => new _TestPageScreen();
}

class _TestPageScreen extends State<TestPageScreen> {
  bool isBonded = false;
  bool isTesting = false;
  bool isTestFinish = false;
  String buttonTest = '缺省值';

  DeviceModel blueDevice = DeviceModel(
      id: myDevice.address,
      name: myDevice.name ?? '拉曼谱检测设备',
      deviceState: myDevice.isConnected ? '已连接-待机' : '未连接-请进入设置连接');

  ResultModel ramanResult = ResultModel(
      name: '缺省', result: '正常',
      bacteriaList: [], ramanPic: []);

  @override
  void initState() {
    super.initState();

    if (myDevice.isConnected) {
      isBonded = true;
      buttonTest = isTesting ? '停止检测' : '开始检测';
    } else {
      buttonTest = '去连接设备';
    }
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    isBonded = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.bluetooth_sharp),
        onPressed: () {
          setState(() {
            context.goNamed(
              'item',
              params: {
                'tab': '${RamanAppTab.explore}',
                'id': 'new',
              },
            );
          });
        },
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.only(left: 20,top: 44.0, right: 20),
          scrollDirection: Axis.vertical,
          children: [
            DeviceCard(device: blueDevice),
            const SizedBox(height: 16),
            Divider(),
            buildButton(
                context,
                buttonTest,
                isTesting ? Colors.red : Colors.green),
            const SizedBox(height: 10.0),
            Divider(),
            buildAnalysis(context),
          ],
        ),
      ),
    );
  }

  Widget buildAnalysis(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Scaffold(
        body: Column(
          children: [
            Text(
                isTestFinish ? '检测结果' : '正在检测',
                style: GoogleFonts.lato(fontSize: 22.0,)),
            Row(
              children: [
                Container(
                  height: 25,
                  width: 5,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  '拉曼图谱',
                  style: GoogleFonts.lato(fontSize: 18),
                ),
              ],
            ),

            Row(
              children: [
                Container(
                  height: 25,
                  width: 5,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  '分析结果',
                  style: GoogleFonts.lato(fontSize: 18),
                ),
              ],
            ),
            Text(
              ramanResult.result,
              style: GoogleFonts.lato(fontSize: 12),
            ),
            Text(
              '所含食源性致病菌种类：'+ramanResult.bacteriaList.toString(),
              style: GoogleFonts.lato(fontSize: 12),
            ),

            const SizedBox(height: 5,),
            Row(
              children: [
                Container(
                  height: 25,
                  width: 5,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  '详细报告',
                  style: GoogleFonts.lato(fontSize: 18),
                ),
              ],
            ),
            Text(
              ramanResult.detail,
              style: GoogleFonts.lato(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
      BuildContext context,
      String nextState,
      MaterialColor color) {
    return SizedBox(
      width: 250,
      height: 55,
      child: MaterialButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          nextState,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          setState(() {
            if (isBonded) {
              setState(() {
                if (isTesting) {
                  isTesting = false;
                  // ToDo 发信息并等待
                } else {
                  isTesting = true;
                }
                print('开始检测OR停止' + isTesting.toString());
              });
            } else {
              context.goNamed(
                'home',
                params: {
                  'tab': '${RamanAppTab.setting}',
                },
              );
            }
          });
        },
      ),
    );
  }
}
