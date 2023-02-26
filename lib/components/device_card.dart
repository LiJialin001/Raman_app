import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../models/models.dart';

class DeviceCard extends StatelessWidget {
  final DeviceModel device;

  const DeviceCard({
    super.key,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 250,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/device.png',),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.srgbToLinearGamma()
          ),
          color: Colors.black.withOpacity(0.6),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Stack(
          children: [
            Text(
              'ID: ' + device.id,
              style: RamanAppTheme.darkTextTheme.bodyText1,
            ),
            Positioned(
              top: 20,
              child: Text(
                device.name,
                style: RamanAppTheme.darkTextTheme.headline2,
              ),
            ),
            Positioned(
              bottom: 30,
              right: 0,
              child: Text(
                '设备状态: ' + device.deviceState,
                style: RamanAppTheme.darkTextTheme.bodyText1,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              child: Text(
                '激光功率: ' + device.laserPower.toString(),
                style: RamanAppTheme.darkTextTheme.bodyText1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
