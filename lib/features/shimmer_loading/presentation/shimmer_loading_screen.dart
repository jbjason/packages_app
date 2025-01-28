// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:packages_app/core/util/mycolor.dart';
import 'package:packages_app/core/util/mydimens.dart';
import 'package:vector_math/vector_math_64.dart' as degree;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShimmerLoadingScreen extends StatelessWidget {
  const ShimmerLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar:
          MyDimens().getNormalAppBar(local.pageTitleShimmer, [], context, true),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShimmerloadingPremium(
              itemHeight: 95,
              length: 4,
              itemSeparateHeightWidth: 20,
              scrollDirection: Axis.vertical,
              child: _getChild(size),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getChild(Size size) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(10),
        height: 95,
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

class ShimmerloadingPremium extends StatefulWidget {
  const ShimmerloadingPremium(
      {super.key,
      required this.child,
      required this.itemHeight,
      this.itemWidth,
      this.highlightColor = Colors.white,
      this.secondaryColor = Colors.white38,
      this.length = 1,
      this.itemSeparateHeightWidth = 0,
      this.scrollDirection = Axis.vertical,
      this.duration = const Duration(milliseconds: 1300)});
  final Widget child;
  final double itemHeight;
  final double? itemWidth;
  final Color highlightColor;
  final Color secondaryColor;
  final int length;
  final double itemSeparateHeightWidth;
  final Axis scrollDirection;
  final Duration duration;
  @override
  State<ShimmerloadingPremium> createState() => _ShimmerloadingPremiumState();
}

class _ShimmerloadingPremiumState extends State<ShimmerloadingPremium>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  bool _isVerticalScroll = true;
  double _shimmerItemWidth = 0;
  //final GlobalKey _sizeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) => _getSize());
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _colorAnimation =
        ColorTween(begin: widget.highlightColor, end: widget.secondaryColor)
            .animate(_controller);
    _controller.repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isVerticalScroll = widget.scrollDirection == Axis.vertical;
    _shimmerItemWidth = widget.itemWidth ?? MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return _isVerticalScroll
        ? Column(children: List.generate(widget.length, (i) => _getShimmeritem))
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(widget.length, (i) => _getShimmeritem)),
          );
  }

  Widget get _getShimmeritem => Container(
        height: widget.itemHeight,
        width: _shimmerItemWidth,
        margin: EdgeInsets.only(
          bottom: _isVerticalScroll ? widget.itemSeparateHeightWidth : 0,
          right: _isVerticalScroll ? 0 : widget.itemSeparateHeightWidth,
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            widget.child,
            Positioned(
              left: 20,
              top: -100,
              bottom: -50,
              width: 120,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) => Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateZ(degree.radians(70))
                    ..translate(_shimmerItemWidth * _controller.value,
                        1 - (_shimmerItemWidth * _controller.value)),
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
      );

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
