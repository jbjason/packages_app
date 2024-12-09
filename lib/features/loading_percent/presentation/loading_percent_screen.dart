import 'package:flutter/material.dart';
import 'package:packages_app/core/util/mycolor.dart';
import 'package:packages_app/core/util/mydimens.dart';
import 'package:packages_app/features/loading_percent/presentation/widgets/loading_percent_painter.dart';

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
                  HorizontalPercentIndicator(
                    height: 30,
                    width: size.width,
                    loadingPercent: _controller.value,
                  ),
                  const SizedBox(height: 20),
                  VerticalPercentIndicator(
                    height: 120,
                    width: 30,
                    loadingPercent: _controller.value,
                  ),
                  const SizedBox(height: 20),
                  CircularPercentIndicator(
                    height: size.height * .28,
                    width: size.height * .28,
                    loadingPercent: _controller.value,
                  ),
                  const SizedBox(height: 20),
                  SquarePercentIndicator(
                    height: 60,
                    width: 60,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class HorizontalPercentIndicator extends StatelessWidget {
  const HorizontalPercentIndicator({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 8,
    required this.loadingPercent,
    this.showLoadingPercent = true,
    this.inactiveTrackColor = MyColor.inActiveColor,
    this.activeTrackColor = const [MyColor.skyPrimary, MyColor.skySecondary],
  });
  final double height;
  final double width;
  final double borderRadius;
  final double loadingPercent;
  final bool showLoadingPercent;
  final Color inactiveTrackColor;
  final List<Color> activeTrackColor;
  @override
  Widget build(BuildContext context) {
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
            alignment: Alignment.centerLeft,
            child: Container(
              height: height,
              width: _getPercent(width, loadingPercent),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: LinearGradient(colors: activeTrackColor),
              ),
            ),
          ),
          if (showLoadingPercent)
            Center(
              child: Text(
                _getExactPercent,
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

  String get _getExactPercent => "${_getPercent(100, loadingPercent).toInt()}%";
}

class VerticalPercentIndicator extends StatelessWidget {
  const VerticalPercentIndicator({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 8,
    required this.loadingPercent,
    this.showLoadingPercent = true,
    this.inactiveTrackColor = MyColor.inActiveColor,
    this.activeTrackColor = const [MyColor.skyPrimary, MyColor.skySecondary],
  });
  final double height;
  final double width;
  final double borderRadius;
  final double loadingPercent;
  final bool showLoadingPercent;
  final Color inactiveTrackColor;
  final List<Color> activeTrackColor;
  @override
  Widget build(BuildContext context) {
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
            alignment: Alignment.bottomCenter,
            child: Container(
              height: _getPercent(height, loadingPercent),
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: LinearGradient(colors: activeTrackColor),
              ),
            ),
          ),
          if (showLoadingPercent)
            Center(
              child: Text(
                _getExactPercent,
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

  String get _getExactPercent => "${_getPercent(100, loadingPercent).toInt()}%";
}

// class StraightLinePercentIndicator extends StatelessWidget {
//   const StraightLinePercentIndicator({
//     super.key,
//     required this.type,
//     required this.height,
//     required this.width,
//     this.borderRadius = 8,
//     required this.loadingPercent,
//     required this.viewLoadingPercent,
//     required this.showLoadingPercent,
//     this.inactiveTrackColor = MyColor.inActiveColor,
//     this.activeTrackColor = const [MyColor.skyPrimary, MyColor.skySecondary],
//   });
//   final LoadingPercentType type;
//   final double height;
//   final double width;
//   final double borderRadius;
//   final double loadingPercent;
//   final String viewLoadingPercent;
//   final bool showLoadingPercent;
//   final Color inactiveTrackColor;
//   final List<Color> activeTrackColor;
//   @override
//   Widget build(BuildContext context) {
//     bool isHorizontal = type == LoadingPercentType.horizontal;
//     final indicatorHeightPercent =
//         isHorizontal ? height : _getPercent(height, loadingPercent);
//     final indicatorWidthPercent =
//         isHorizontal ? _getPercent(width, loadingPercent) : width;
//     final indicatorAlignment =
//         isHorizontal ? Alignment.centerLeft : Alignment.bottomCenter;
//     return Container(
//       height: height,
//       width: width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(borderRadius),
//         color: inactiveTrackColor,
//       ),
//       child: Stack(
//         children: [
//           Align(
//             alignment: indicatorAlignment,
//             child: Container(
//               height: indicatorHeightPercent,
//               width: indicatorWidthPercent,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(borderRadius),
//                 gradient: LinearGradient(colors: activeTrackColor),
//               ),
//             ),
//           ),
//           if (showLoadingPercent)
//             Center(
//               child: Text(
//                 viewLoadingPercent,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//   double _getPercent(double width, double loadingPercent) {
//     if (loadingPercent > 1) return width;
//     if (loadingPercent < 0) return 0;
//     return width * loadingPercent;
//   }
// }

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
  });
  final double height;
  final double width;
  final double loadingPercent;
  final Color inActiveTrackColor;
  final List<Color> activeTrackColor;

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
        child: Center(child: Text(_getExactPercent)),
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

  double _getPercent(double width, double loadingPercent) {
    if (loadingPercent > 1) return width;
    if (loadingPercent < 0) return 0;
    return width * loadingPercent;
  }

  String get _getExactPercent => "${_getPercent(100, loadingPercent).toInt()}%";
}

class SquarePercentIndicator extends StatelessWidget {
  const SquarePercentIndicator(
      {super.key,
      required this.height,
      required this.width,
      required this.loadingPercent,
      this.borderRadius = 12,
      this.indicatorColor = MyColor.skyPrimary,
      this.backColor = MyColor.inActiveColor});
  final double height;
  final double width;
  final double loadingPercent;
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
            child: Center(child: Text(_getExactPercent)),
          ),
        ),
      ],
    );
  }

  double _getPercent(double width, double loadingPercent) {
    if (loadingPercent > 1) return width;
    if (loadingPercent < 0) return 0;
    return width * loadingPercent;
  }

  String get _getExactPercent => "${_getPercent(100, loadingPercent).toInt()}%";
}
