import 'package:flutter/material.dart';
import 'package:nssg/utils/app_colors.dart';

double buildResponsiveWidth(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  if (size.width > 720) {
    return 800;
  } else if (size.width < 720) {
    return size.width;
  } else {
    return size.width;
  }
}

Widget loadingView() {
  return Align(
      alignment: Alignment.center,
      child: StretchedDots(

          color: AppColors.primaryColor, size: 60));
}


class StretchedDots extends StatefulWidget {
  final double size;
  // final int time;
  final Color color;
  final double innerHeight;
  final double dotWidth;

  const StretchedDots({
    Key? key,
    required this.size,
    required this.color,
    // required this.time,
  })  : innerHeight = size / 1.3,
        dotWidth = size / 8,
        super(key: key);

  @override
  State<StretchedDots> createState() => _StretchedDotsState();
}

class _StretchedDotsState extends State<StretchedDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final Cubic firstCurve = Curves.easeInCubic;
  final Cubic seconCurve = Curves.easeOutCubic;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final double innerHeight = widget.innerHeight;
    final double dotWidth = widget.dotWidth;
    final Color color = widget.color;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) => Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        child: SizedBox(
          height: innerHeight,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  BuildDot(
                    controller: _animationController,
                    innerHeight: innerHeight,

                    firstInterval: Interval(
                      0.0,
                      0.15,
                      curve: firstCurve
                    ),
                    secondInterval: Interval(
                      0.15,
                      0.30,
                      curve: seconCurve,
                    ),
                    thirdInterval: Interval(
                      0.5,
                      0.65,
                      curve: firstCurve,
                    ),
                    forthInterval: Interval(
                      0.65,
                      0.80,
                      curve: seconCurve,
                    ),
                    dotWidth: dotWidth,
                    color: color,
                  ),
                  BuildDot(
                    controller: _animationController,
                    innerHeight: innerHeight,
                    firstInterval: Interval(
                      0.05,
                      0.20,
                      curve: firstCurve,
                    ),
                    secondInterval: Interval(
                      0.20,
                      0.35,
                      curve: seconCurve,
                    ),
                    thirdInterval: Interval(
                      0.55,
                      0.70,
                      curve: firstCurve,
                    ),
                    forthInterval: Interval(
                      0.70,
                      0.85,
                      curve: seconCurve,
                    ),
                    dotWidth: dotWidth,
                    color: color,
                  ),
                  BuildDot(
                    controller: _animationController,
                    innerHeight: innerHeight,
                    firstInterval: Interval(
                      0.10,
                      0.25,
                      curve: firstCurve,
                    ),
                    secondInterval: Interval(
                      0.25,
                      0.40,
                      curve: seconCurve,
                    ),
                    thirdInterval: Interval(
                      0.60,
                      0.75,
                      curve: firstCurve,
                    ),
                    forthInterval: Interval(
                      0.75,
                      0.90,
                      curve: seconCurve,
                    ),
                    dotWidth: dotWidth,
                    color: color,
                  ),
                  BuildDot(
                    controller: _animationController,
                    innerHeight: innerHeight,
                    firstInterval: Interval(
                      0.15,
                      0.30,
                      curve: firstCurve,
                    ),
                    secondInterval: Interval(
                      0.30,
                      0.45,
                      curve: seconCurve,
                    ),
                    thirdInterval: Interval(
                      0.65,
                      0.80,
                      curve: firstCurve,
                    ),
                    forthInterval: Interval(
                      0.80,
                      0.95,
                      curve: seconCurve,
                    ),
                    dotWidth: dotWidth,
                    color: color,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}


class BuildDot extends StatelessWidget {
  final AnimationController controller;
  final double dotWidth;
  final Color color;
  final double innerHeight;

  final Interval firstInterval;
  final Interval secondInterval;
  final Interval thirdInterval;
  final Interval forthInterval;

  const BuildDot({
    Key? key,
    required this.controller,
    required this.dotWidth,
    required this.color,
    required this.innerHeight,
    required this.firstInterval,
    required this.secondInterval,
    required this.thirdInterval,
    required this.forthInterval,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double offset = innerHeight / 4.85;
    final double height = innerHeight / 1.7;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        controller.value < firstInterval.end
            ? Align(
          alignment: Alignment.bottomCenter,
          child: Transform.translate(
            offset: Tween<Offset>(
              begin: Offset.zero,
              end: Offset(0, -offset),
            )
                .animate(
              CurvedAnimation(
                parent: controller,
                curve: firstInterval,
              ),
            )
                .value,
            child: RoundedRectangle.vertical(
              width: dotWidth,
              // height: height,
              color: color,
              height: Tween<double>(begin: dotWidth, end: height)
                  .animate(
                CurvedAnimation(
                  parent: controller,
                  curve: firstInterval,
                ),
              )
                  .value,
            ),
          ),
        )
            : Visibility(
          visible: controller.value <= secondInterval.end,
          child: Align(
            alignment: Alignment.topCenter,
            child: Transform.translate(
              offset: Tween<Offset>(
                  begin: Offset(0, offset), end: Offset.zero)
                  .animate(
                CurvedAnimation(
                  parent: controller,
                  curve: secondInterval,
                ),
              )
                  .value,
              child: RoundedRectangle.vertical(
                width: dotWidth,
                // height: height,
                color: color,
                height: Tween<double>(
                  begin: height,
                  end: dotWidth,
                )
                    .animate(CurvedAnimation(
                  parent: controller,
                  curve: secondInterval,
                ))
                    .value,
              ),
            ),
          ),
        ),
        controller.value < thirdInterval.end
            ? Visibility(
          visible: controller.value >= secondInterval.end,
          replacement: SizedBox(
            width: dotWidth,
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Transform.translate(
              // offset: Offset(0, offset),
              offset: Tween<Offset>(
                begin: Offset.zero,
                end: Offset(0, offset),
              )
                  .animate(
                CurvedAnimation(
                  parent: controller,
                  curve: thirdInterval,
                ),
              )
                  .value,
              child: RoundedRectangle.vertical(
                width: dotWidth,
                // height: height,
                height: Tween<double>(
                  begin: dotWidth,
                  end: height,
                )
                    .animate(CurvedAnimation(
                  parent: controller,
                  curve: thirdInterval,
                ))
                    .value,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        )
            : Align(
          alignment: Alignment.bottomCenter,
          child: Transform.translate(
            offset: Tween<Offset>(
              begin: Offset(0, -offset),
              end: Offset.zero,
            )
                .animate(
              CurvedAnimation(
                parent: controller,
                curve: forthInterval,
              ),
            )
                .value,
            child: RoundedRectangle.vertical(
              width: dotWidth,
              height: Tween<double>(
                begin: height,
                end: dotWidth,
              )
                  .animate(
                CurvedAnimation(
                  parent: controller,
                  curve: forthInterval,
                ),
              )
                  .value,
              color: AppColors.loaderColor,
            ),
          ),
        ),
      ],
    );
  }
}



class RoundedRectangle extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final bool vertical;
  const RoundedRectangle.vertical({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  })  : vertical = true,
        super(key: key);

  const RoundedRectangle.horizontal({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  })  : vertical = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          vertical ? width : height,
        ),
      ),
    );
  }
}
