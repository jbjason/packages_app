// ignore_for_file: depend_on_referenced_packages, unused_import
import 'package:flutter/material.dart';
import 'package:packages_app/core/util/mycolor.dart';
import 'package:packages_app/core/util/mydimens.dart';
import 'package:packages_app/features/loading_percent/presentation/widgets/loading_percent_painter.dart';
import 'dart:math' as math;

enum LoadingType { horizontal, vertical, circular }

class LoadingPercentScreen extends StatefulWidget {
  const LoadingPercentScreen({super.key});
  @override
  State<LoadingPercentScreen> createState() => _LoadingPercentScreenState();
}

class _LoadingPercentScreenState extends State<LoadingPercentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    if (mounted) _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyDimens().getNormalAppBar("Loading Percent", [], context, true),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  _getHorizontalVerticalLoading(
                    type: LoadingType.horizontal,
                    height: 30,
                    width: size.width,
                    loadingPercent: _controller.value,
                    showLoadingPercent: true,
                  ),
                  const SizedBox(height: 20),
                  _getHorizontalVerticalLoading(
                    type: LoadingType.vertical,
                    height: 120,
                    width: 30,
                    loadingPercent: _controller.value,
                    showLoadingPercent: true,
                    indicatorGradientColor: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [MyColor.skyPrimary, MyColor.skySecondary],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _getCircleLoading(
                    height: size.height * .28,
                    width: size.height * .28,
                    loadingPercent: _controller.value,
                  ),
                  const SizedBox(height: 20),
                  _getSqareLoading(
                    height: 100,
                    width: 100,
                    loadingPercent: _controller.value,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSqareLoading({
    required double height,
    required double width,
    required double loadingPercent,
    double borderRadius = 12,
    Color indicatorColor = MyColor.skyPrimary,
    Color backColor = MyColor.inActiveColor,
  }) =>
      Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: SweepGradient(
                stops: [_getPercent(1, loadingPercent), 0],
                colors: [indicatorColor, backColor],
              ),
            ),
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: Colors.white,
              ),
              child: Center(child: Text(_getExactPercent(loadingPercent))),
            ),
          ),
        ],
      );

  Widget _getCircleLoading({
    required double height,
    required double width,
    required double loadingPercent,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: CustomPaint(
        painter: LoadingPercentPainter(
          strokeWidth: 5.5,
          circleRadius: 12,
          loadingPercent: loadingPercent,
          indicatorGradientColor: [
            Colors.deepOrangeAccent,
            Colors.greenAccent,
            Color(0xFF913A84),
            Colors.deepOrangeAccent,
          ],
        ),
        child: Center(child: Text(_getExactPercent(loadingPercent))),
      ),
    );
  }

  Widget _getHorizontalVerticalLoading({
    required LoadingType type,
    required double height,
    required double width,
    double borderRadius = 0,
    required double loadingPercent,
    required bool showLoadingPercent,
    Color backColor = MyColor.inActiveColor,
    Gradient indicatorGradientColor = const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [MyColor.skyPrimary, MyColor.skySecondary],
    ),
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
      child: Stack(
        children: [
          Align(
            alignment: indicatorAlignment,
            child: Container(
              height: indicatorHeightPercent,
              width: indicatorWidthPercent,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: indicatorGradientColor,
              ),
            ),
          ),
          if (showLoadingPercent)
            Center(
              child: Text(
                _getExactPercent(loadingPercent),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  double _getPercent(double width, double loadingPercent) {
    if (loadingPercent > 1) return width;
    if (loadingPercent < 0) return 0;
    return width * loadingPercent;
  }

  String _getExactPercent(double loadingPercent) =>
      "${_getPercent(100, loadingPercent).toInt()}%";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
