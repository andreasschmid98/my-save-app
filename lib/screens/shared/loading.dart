import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: SpinKitThreeBounce(
            color: Colors.black,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
