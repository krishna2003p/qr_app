import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'loader_provider.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(
      builder: (context, loaderProvider, child) {
        return loaderProvider.isLoading
            ? Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: SpinKitFoldingCube(
                  color: Colors.blue,
                  size: 50,
                ),
              ),
            ),
          ),
        )
            : SizedBox.shrink();
      },
    );
  }
}
