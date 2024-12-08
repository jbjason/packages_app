import 'package:flutter/material.dart';
import 'package:packages_app/core/util/mycolor.dart';
import 'package:packages_app/core/util/mydimens.dart';
import 'package:packages_app/features/loading_percent/presentation/widgets/loading_percent_painter.dart';

enum LoadingPercentType { horizontal, vertical, circular, square }

class LoadingPercentScreen extends StatefulWidget {
  const LoadingPercentScreen(
      {super.key,
      required this.type,
      this.showLoadingPercent = true,
      this.straightLinePercentIndicator,
      this.circularPercentIndicator,
      this.squarePercentIndicator});
  final LoadingPercentType type;
  final bool showLoadingPercent;
  final StraightLinePercentIndicator? straightLinePercentIndicator;
  final CircularPercentIndicator? circularPercentIndicator;
  final SquarePercentIndicator? squarePercentIndicator;
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
                  StraightLinePercentIndicator(
                    type: LoadingPercentType.horizontal,
                    height: 30,
                    width: size.width,
                    showLoadingPercent: widget.showLoadingPercent,
                    loadingPercent: _controller.value,
                    viewLoadingPercent: _getExactPercent(_controller.value),
                  ),
                  const SizedBox(height: 20),
                  StraightLinePercentIndicator(
                    type: LoadingPercentType.vertical,
                    height: 120,
                    width: 30,
                    showLoadingPercent: widget.showLoadingPercent,
                    loadingPercent: _controller.value,
                    viewLoadingPercent: _getExactPercent(_controller.value),
                  ),
                  const SizedBox(height: 20),
                  CircularPercentIndicator(
                    height: size.height * .28,
                    width: size.height * .28,
                    loadingPercent: _controller.value,
                    viewLoadingPercent: _getExactPercent(_controller.value),
                  ),
                  const SizedBox(height: 20),
                  SquarePercentIndicator(
                    height: 60,
                    width: 60,
                    loadingPercent: _getPercent(1, _controller.value),
                    viewLoadingPercent: _getExactPercent(_controller.value),
                  ),
                ],
              ),
            ),
          ),
        ),
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

class StraightLinePercentIndicator extends StatelessWidget {
  const StraightLinePercentIndicator({
    super.key,
    required this.type,
    required this.height,
    required this.width,
    this.borderRadius = 0,
    required this.loadingPercent,
    required this.viewLoadingPercent,
    required this.showLoadingPercent,
    this.inactiveTrackColor = MyColor.inActiveColor,
    this.activeTrackColor = const [MyColor.skyPrimary, MyColor.skySecondary],
  });

  final LoadingPercentType type;
  final double height;
  final double width;
  final double borderRadius;
  final double loadingPercent;
  final String viewLoadingPercent;
  final bool showLoadingPercent;
  final Color inactiveTrackColor;
  final List<Color> activeTrackColor;

  @override
  Widget build(BuildContext context) {
    bool isHorizontal = type == LoadingPercentType.horizontal;
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
        color: inactiveTrackColor,
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
                gradient: LinearGradient(colors: activeTrackColor),
              ),
            ),
          ),
          if (showLoadingPercent)
            Center(
              child: Text(
                viewLoadingPercent,
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
}

class CircularPercentIndicator extends StatelessWidget {
  const CircularPercentIndicator({
    super.key,
    required this.height,
    required this.width,
    required this.loadingPercent,
    this.inActiveTrackColor = MyColor.inActiveColor,
    this.activeTrackColor = const [
      Colors.deepOrangeAccent,
      Colors.greenAccent,
      Color(0xFF913A84),
      Colors.deepOrangeAccent
    ],
    required this.viewLoadingPercent,
  });
  final double height;
  final double width;
  final double loadingPercent;
  final Color inActiveTrackColor;
  final List<Color> activeTrackColor;
  final String viewLoadingPercent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CustomPaint(
        painter: LoadingPercentPainter(
          strokeWidth: 5.5,
          circleRadius: 12,
          loadingPercent: loadingPercent,
          inActiveTrackColor: inActiveTrackColor,
          indicatorGradientColor: _getGradientColor,
        ),
        child: Center(child: Text(viewLoadingPercent)),
      ),
    );
  }

  List<Color> get _getGradientColor {
    if (activeTrackColor.isEmpty) {
      return [Colors.blue, Colors.blue];
    } else if (activeTrackColor.length == 1) {
      return [activeTrackColor[0], activeTrackColor[0]];
    } else {
      return activeTrackColor;
    }
  }
}

class SquarePercentIndicator extends StatelessWidget {
  const SquarePercentIndicator(
      {super.key,
      required this.height,
      required this.width,
      required this.loadingPercent,
      required this.viewLoadingPercent,
      this.borderRadius = 12,
      this.indicatorColor = MyColor.skyPrimary,
      this.backColor = MyColor.inActiveColor});
  final double height;
  final double width;
  final double loadingPercent;
  final String viewLoadingPercent;
  final double borderRadius;
  final Color indicatorColor;
  final Color backColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: SweepGradient(
              stops: [loadingPercent, 0],
              colors: [indicatorColor, backColor],
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Colors.white,
            ),
            child: Center(child: Text(viewLoadingPercent)),
          ),
        ),
      ],
    );
  }
}
