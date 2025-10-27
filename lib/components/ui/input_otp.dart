import 'package:flutter/material.dart';

class InputOtp extends StatelessWidget {
  final int length;

  const InputOtp({Key? key, this.length = 4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (_) => Container(width: 40, height: 48, margin: EdgeInsets.all(4), decoration: BoxDecoration(border: Border.all(color: Colors.grey)),),
      ),
    );
  }
}

