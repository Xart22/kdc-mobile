import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.5),
      child: Center(
          child: SpinKitWaveSpinner(
        color: const Color(0xFFFFFFFF),
        size: 80.0,
        waveColor: const Color(0xFFED1C24),
        trackColor: const Color(0xFFED1C24).withOpacity(0.5),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: Image.asset('assets/icons/aj.png'),
      )),
    );
  }
}
