import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

const Color backNotHover = Color(0xFF5B7994);
const Color frontNotHover = Color(0xFFB3C4D4);
// const Color frontHover = Color(0xFF456685);
const Color frontHover = Color(0xFF456685);

class AppButtonController extends GetxController
    with GetTickerProviderStateMixin {
  final RxBool _isHovering = false.obs;
  bool get isHovering => _isHovering.value;
  set isHovering(bool value) => _isHovering.value = value;

  late final AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(vsync: this);
    super.onInit();
  }
}

class AppButton extends StatelessWidget {
  final double fullWidth;
  final double fullHeight;
  final Function() onPressed;
  final String text;

  const AppButton(
      {super.key,
      this.fullWidth = 150,
      this.fullHeight = 150 / 3,
      required this.onPressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    final AppButtonController controller =
        Get.put<AppButtonController>(AppButtonController(), tag: text);
    final Duration duration = 150.ms;
    final Duration colorDelay = 100.ms;

    return InkWell(
        onTapDown: (TapDownDetails details) {
          controller.animationController.forward();
        },
        onTapUp: (TapUpDetails details) {
          controller.animationController.reverse();
          onPressed();
        },
        onHover: (value) => controller.isHovering = value,
        hoverColor: Colors.transparent,
        child: Obx(() {
          final double targetCondition = controller.isHovering ? 1.0 : 0.0;
          return SizedBox(
            width: fullWidth,
            height: fullHeight,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: fullWidth / 6,
                  right: fullWidth / 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: backNotHover,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                      .animate(
                          target: targetCondition,
                          controller: controller.animationController)
                      .scaleX(duration: duration, begin: 1, end: 1.45)
                      .color(
                        duration: duration,
                        delay: colorDelay,
                        begin: backNotHover,
                        end: const Color(0xFFB3C4D4),
                        blendMode: BlendMode.srcATop,
                      ),
                ),
                Positioned(
                        top: fullHeight / 13,
                        bottom: fullHeight / 13,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: fullWidth,
                          height: fullHeight - fullHeight / 5,
                          decoration: BoxDecoration(
                            color: frontNotHover,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ))
                    .animate(
                        target: targetCondition,
                        controller: controller.animationController)
                    .scaleX(duration: duration, begin: 1, end: 0.9)
                    .color(
                        duration: duration,
                        delay: colorDelay,
                        begin: frontNotHover,
                        end: frontHover,
                        blendMode: BlendMode.srcATop),
                Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )
                      .animate(
                          target: targetCondition,
                          controller: controller.animationController)
                      .color(
                          duration: duration,
                          delay: colorDelay,
                          begin: frontHover,
                          end: frontNotHover,
                          blendMode: BlendMode.srcATop),
                )
              ],
            ),
          );
        }));
  }
}
