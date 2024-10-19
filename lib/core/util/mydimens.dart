// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:packages_app/core/util/mycolor.dart';

class MyDimens {
  static const cmDivider = Divider(color: MyColor.inActiveColor, thickness: .5);

  AppBar getNormalAppBar(String title, List<Widget> actions, BuildContext ctx,
          [bool backButton = false]) =>
      AppBar(
        leading: backButton
            ? IconButton(
                onPressed: () => Navigator.pop(ctx),
                icon: const Icon(Icons.arrow_back_ios_new),
              )
            : const SizedBox(),
        title: Text(title),
        centerTitle: true,
        actions: actions,
      );

  SliverAppBar getSliverAppbar(
      String title, List<Widget> actions, BuildContext ctx,
      [bool backButton = false]) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: backButton
          ? IconButton(
              onPressed: () => Navigator.pop(ctx),
              icon: const Icon(Icons.arrow_back_ios_new),
            )
          : const SizedBox(),
      title: Text(title),
      actions: actions,
    );
  }

  static const bodyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white, Colors.white, Color(0xB3FFFFFF), Color(0x62FFFFFF)],
  );

  Gradient getHomeGradient(Color color) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(.9),
          color.withOpacity(.6),
          color.withOpacity(.4)
        ],
      );

  static const bodyShadow = [
    BoxShadow(
      color: Colors.white,
      blurRadius: 40,
      offset: Offset(-5, -2),
    ),
    BoxShadow(
      color: Color.fromARGB(255, 173, 196, 219),
      blurRadius: 10,
      offset: Offset(5, 5),
    ),
  ];
  final secondaryShadow = [
    BoxShadow(
      color: const Color(0xFF3F6080).withOpacity(.8),
      blurRadius: 10,
      offset: const Offset(5, 5),
    ),
  ];

  Container getButtonStyle({required Widget child}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: MyColor.bluePrimary,
          boxShadow: bodyShadow,
        ),
        child: child,
      );
  Widget getTitleText(String title, Color color) => Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold, color: color),
      );
  Widget getSubTitleText(String title, Color color) => Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(fontSize: 9.5, color: color),
      );
}
