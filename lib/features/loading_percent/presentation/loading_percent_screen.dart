import 'package:flutter/material.dart';
import 'package:packages_app/core/util/mycolor.dart';
import 'package:packages_app/core/util/mydimens.dart';

enum LoadingType { horizontal, vertical, circular }

class LoadingPercentScreen extends StatelessWidget {
  const LoadingPercentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyDimens().getNormalAppBar("Loading Percent", [], context, true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getHorizontalVerticalLoading(
                  type: LoadingType.horizontal,
                  height: 30,
                  width: size.width,
                  loadingPercent: .3,
                ),
                _getHorizontalVerticalLoading(
                    type: LoadingType.vertical,
                    height: 80,
                    width: 30,
                    loadingPercent: .6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getHorizontalVerticalLoading({
    required LoadingType type,
    required double height,
    required double width,
    Color backColor = MyColor.inActiveColor,
    double borderRadius = 12,
    Color indicatorColor = MyColor.bluePrimary,
    required double loadingPercent,
  }) {
    bool isHorizontal = type == LoadingType.horizontal;
    final indicatorHeightPercent =
        isHorizontal ? height : _getPercent(height, loadingPercent);
    final indicatorWidthPercent =
        isHorizontal ? _getPercent(width, loadingPercent) : width;
    final indicatorAlignment =
        isHorizontal ? Alignment.centerLeft : Alignment.bottomCenter;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backColor,
      ),
      child: Container(
        height: 20, //indicatorHeightPercent,
        width: 20, // indicatorWidthPercent,
        alignment: indicatorAlignment,
        // constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: indicatorColor,
        ),
      ),
    );
  }

  double _getPercent(double width, double loadingPercent) {
    if (loadingPercent > 1) return width;
    if (loadingPercent < 0) return 0;
    return width * loadingPercent;
  }
}
