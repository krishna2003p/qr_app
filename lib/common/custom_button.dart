import 'package:flutter/material.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class CustomLoadingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  CustomLoadingButton({super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
  });

  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: _btnController,
      borderRadius: 10,
      successColor: Colors.green,
      onPressed: () {
        onPressed();
        _btnController.success();
      },
      color: color,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
