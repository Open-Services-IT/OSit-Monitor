import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:osit_monitor/controllers/qr_controller.dart';
import '../controllers/app_controller.dart';
import 'qr_data_page.dart';
import '../widgets/dialogs.dart';
import '../constants/colors.dart';

class QrScreen extends StatelessWidget {
  QrScreen({super.key}) : super();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final QrController qrController = Get.put(QrController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (_) => Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          qrController.buildQrView(context, _),
          Stack(
            children: [
              Positioned(
                bottom: 5,
                right: 7,
                child: Image.asset(
                  'assets/logo.png',
                  scale: 7,
                ),
              ),
              const DataPage(),
            ],
          ),
        ]),
        //bottomSheet: SizedBox(height: 30),
        bottomNavigationBar: SizedBox(
          height: AppBar().preferredSize.height + 26,
          child: Container(
            color: Colors.grey.shade500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 20),
                ElevatedButton(
                    style: elevatedButtonStyle(context),
                    onPressed: _.toggleCamera,
                    child: FutureBuilder(
                      future: _.getCameraInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Icon(snapshot.data == _.facingFront
                              ? Icons.camera_rear
                              : Icons.camera_front); //CameraFacing.front
                        } else {
                          return const Icon(Icons.camera_rear);
                        }
                      },
                    )),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: elevatedButtonStyle(context),
                  onPressed: _.toggleAction,
                  child: Icon(_.isPaused ? Icons.play_arrow : Icons.pause),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                    style: elevatedButtonStyle(context),
                    onPressed: _.toggleFlash,
                    child: FutureBuilder(
                      future: _.getFlashStatus(),
                      builder: (context, snapshot) => Icon(
                          snapshot.data ?? false
                              ? Icons.flash_off
                              : Icons.flash_on),
                    )),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}