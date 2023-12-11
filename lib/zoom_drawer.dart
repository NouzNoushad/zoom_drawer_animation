import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_drawer_animation/provider/page_provider.dart';

import 'main_screen.dart';
import 'menu_screen.dart';
import 'selected_screens.dart';

class ZoomDrawerAnimation extends StatefulWidget {
  const ZoomDrawerAnimation({super.key});

  @override
  State<ZoomDrawerAnimation> createState() => _ZoomDrawerAnimationState();
}

class _ZoomDrawerAnimationState extends State<ZoomDrawerAnimation>
    with SingleTickerProviderStateMixin {
  double drawerLength = 220;
  // animations
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> slideAnimation;
  late Animation<double> rotationAnimation;
  late Animation<double> borderAnimation;

  buildScreens(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return SelectedScreen(
          text: 'Home Screen',
          controller: controller,
        );
      case 1:
        return SelectedScreen(
          text: 'Favorite Screen',
          controller: controller,
        );
      case 2:
        return SelectedScreen(
          text: 'Settings Screen',
          controller: controller,
        );
      case 3:
        return SelectedScreen(
          text: 'Profile Screen',
          controller: controller,
        );
      default:
        return Container();
    }
  }

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    var curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(curve);
    rotationAnimation = Tween<double>(begin: 0, end: -0.15).animate(curve);
    slideAnimation = Tween<double>(begin: 0, end: drawerLength).animate(curve);
    borderAnimation = Tween<double>(begin: 0, end: 30).animate(curve);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          MenuScreen(
            drawerLength: drawerLength,
          ),
          AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Transform(
                  alignment: const Alignment(0, -0.1),
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..scale(scaleAnimation.value)
                    ..translate(slideAnimation.value)
                    ..rotateZ(rotationAnimation.value),
                  child: MainScreen(
                    borderRadius: borderAnimation.value,
                    child: Consumer<PageProvider>(
                        builder: (context, state, child) {
                      return Container(
                        color: Colors.white,
                        child: buildScreens(state.selectedIndex),
                      );
                    }),
                  ),
                );
              }),
        ],
      )),
    );
  }
}
