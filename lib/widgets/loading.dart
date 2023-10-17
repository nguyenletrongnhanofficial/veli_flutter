import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          ModalBarrier(
            color: Colors.white.withOpacity(0.5), 
            dismissible: false, 
          ),
          const Center(
            child:
                CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
