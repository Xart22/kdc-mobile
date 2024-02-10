import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kdc_mobile/app/helper/loading.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/scan_qrcode_controller.dart';

class ScanQrcodeView extends GetView<ScanQrcodeController> {
  const ScanQrcodeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center:
          MediaQuery.of(context).size.center(Offset.zero) - const Offset(0, 50),
      width: 250,
      height: 250,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isTablet.value) {
          return tableScanner(context);
        } else {
          return mobileScanner(scanWindow);
        }
      }),
    );
  }

  Widget tableScanner(context) {
    return TextFormField(
        enabled: true,
        autofocus: true,
        autocorrect: false,
        focusNode: FocusNode(),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (val) {
          //hide keyboard
          FocusScope.of(context).unfocus();
          print(val); // the scan value`},
        });
  }

  Widget mobileScanner(Rect scanWindow) {
    return Builder(
      builder: (context) {
        return Stack(
          fit: StackFit.expand,
          children: [
            MobileScanner(
              scanWindow: scanWindow,
              controller: controller.controllerScanner,
              onScannerStarted: (arguments) {
                controller.arguments.value = arguments!;
              },
              errorBuilder: (context, error, child) {
                return const Center(
                  child: Text('Error occurred'),
                );
              },
              onDetect: controller.onDetect,
            ),
            Obx(() => controller.arguments.value.size.width == 0
                ? const Loading()
                : CustomPaint(
                    painter: BarcodeOverlay(
                      barcode: controller.barcode.value,
                      arguments: controller.arguments.value,
                      boxFit: BoxFit.contain,
                      capture: controller.capture.value,
                    ),
                  )),
            CustomPaint(
              painter: ScannerOverlay(scanWindow),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                color: Colors.black.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        height: 50,
                        child: FittedBox(
                          child: Text(
                            'Scan QR Code',
                            overflow: TextOverflow.fade,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() =>
                controller.isLoading.value ? const Loading() : Container()),
          ],
        );
      },
    );
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRect(scanWindow);

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BarcodeOverlay extends CustomPainter {
  BarcodeOverlay({
    required this.barcode,
    required this.arguments,
    required this.boxFit,
    required this.capture,
  });

  final BarcodeCapture capture;
  final Barcode barcode;
  final MobileScannerArguments arguments;
  final BoxFit boxFit;

  @override
  void paint(Canvas canvas, Size size) {
    if (barcode.corners.isEmpty) {
      return;
    }
    final adjustedSize = applyBoxFit(boxFit, arguments.size, size);

    double verticalPadding = size.height - adjustedSize.destination.height;
    double horizontalPadding = size.width - adjustedSize.destination.width;
    if (verticalPadding > 0) {
      verticalPadding = verticalPadding / 2;
    } else {
      verticalPadding = 0;
    }

    if (horizontalPadding > 0) {
      horizontalPadding = horizontalPadding / 2;
    } else {
      horizontalPadding = 0;
    }

    final double ratioWidth;
    final double ratioHeight;

    ratioWidth = arguments.size.width / adjustedSize.destination.width;
    ratioHeight = arguments.size.height / adjustedSize.destination.height;

    final List<Offset> adjustedOffset = [];
    for (final offset in barcode.corners) {
      adjustedOffset.add(
        Offset(
          offset.dx / ratioWidth + horizontalPadding,
          offset.dy / ratioHeight + verticalPadding,
        ),
      );
    }
    final cutoutPath = Path()..addPolygon(adjustedOffset, true);

    final backgroundPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    canvas.drawPath(cutoutPath, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
