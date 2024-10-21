// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:packages_app/core/util/mycolor.dart';
import 'package:packages_app/core/util/mydimens.dart';
import 'package:vector_math/vector_math_64.dart' as degree;

class ShimmerLoadingScreen extends StatelessWidget {
  const ShimmerLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyDimens().getNormalAppBar("Shimmer Loading", [], context, true),
      body: SafeArea(
        child: ShimmerloadingCard(
          height: 95,
          width: size.width,
          length: 7,
          itemSeparateHeight: 20,
          child: _getChild(size),
        ),
      ),
    );
  }

  Widget _getChild(Size size) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColor.cardBackgroundColor,
          border: Border.all(color: MyColor.inActiveColor, width: .4),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 35,
                  width: 35,
                  child: Container(
                    color: MyColor.inActiveColor,
                    constraints: const BoxConstraints.expand(),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  width: 150,
                  height: 8,
                  color: MyColor.inActiveColor,
                ),
              ],
            ),
            MyDimens.cmDivider,
            Container(
              width: size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyColor.bodyGreyColor,
                borderRadius: BorderRadius.circular(7.5),
              ),
            ),
          ],
        ),
      );
}

class ShimmerloadingCard extends StatefulWidget {
  const ShimmerloadingCard(
      {super.key,
      required this.child,
      required this.height,
      required this.width,
      this.startColor = Colors.white,
      this.endColor = Colors.white38,
      this.length = 1,
      this.itemSeparateHeight = 0,
      this.itemSeparateWidth = 0,
      this.scrollDirection = Axis.vertical});
  final Widget child;
  final double height;
  final double width;
  final Color startColor;
  final Color endColor;
  final int length;
  final double itemSeparateHeight;
  final double itemSeparateWidth;
  final Axis scrollDirection;
  @override
  State<ShimmerloadingCard> createState() => _ShimmerloadingCardState();
}

class _ShimmerloadingCardState extends State<ShimmerloadingCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  //final GlobalKey _sizeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) => _getSize());
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _colorAnimation = ColorTween(begin: widget.startColor, end: widget.endColor)
        .animate(_controller);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.length,
      scrollDirection: widget.scrollDirection,
      shrinkWrap: true,
      separatorBuilder: (_, __) => SizedBox(
        height: widget.itemSeparateHeight,
        width: widget.itemSeparateWidth,
      ),
      itemBuilder: (context, i) => SizedBox(
        height: widget.height,
        width: widget.width,
        child: Stack(
          children: [
            widget.child,
            Positioned(
              left: 0,
              top: -100,
              bottom: -50,
              width: 120,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) => Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateZ(degree.radians(70))
                    ..translate(widget.width * _controller.value,
                        1 - (widget.width * _controller.value)),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 80,
                          color: _colorAnimation.value!,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _getSize() {
  //   RenderBox renderBox =
  //       _sizeKey.currentContext!.findRenderObject() as RenderBox;
  //   Size size = renderBox.size;
  //   widget.onSizeMeasured(size);
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
