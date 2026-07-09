import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FloatingImage extends StatelessWidget {
  final String asset;
  final double width;
  final Duration duration;
  final double offsetY;
  final double rotationDeg;
  final BoxFit fit;
  final BlendMode? blendMode;

  const FloatingImage({
    super.key,
    required this.asset,
    required this.width,
    this.duration = const Duration(seconds: 5),
    this.offsetY = 12.0,
    this.rotationDeg = 1.2,
    this.fit = BoxFit.contain,
    this.blendMode,
  });

  @override
  Widget build(BuildContext context) {
    Widget img = Image.asset(asset, width: width, fit: fit);

    if (blendMode != null) {
      img = ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.transparent, blendMode!),
        child: img,
      );
    }

    return img
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(
          begin: 0, end: -offsetY,
          duration: duration,
          curve: Curves.easeInOut,
        )
        .rotate(
          begin: -rotationDeg * 0.0175,
          end: rotationDeg * 0.0175,
          duration: duration,
          curve: Curves.easeInOut,
        );
  }
}

class FlyingImage extends StatelessWidget {
  final String asset;
  final double width;

  const FlyingImage({super.key, required this.asset, required this.width});

  @override
  Widget build(BuildContext context) {
    return Image.asset(asset, width: width, fit: BoxFit.contain)
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(begin: 0, end: -8, duration: 5.seconds, curve: Curves.easeInOut)
        .moveX(begin: 0, end: 8, duration: 5.seconds, curve: Curves.easeInOut);
  }
}

class TwinklingImage extends StatelessWidget {
  final String asset;
  final double size;
  final Duration delay;

  const TwinklingImage({
    super.key,
    required this.asset,
    required this.size,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(asset, width: size, height: size, fit: BoxFit.contain)
        .animate(delay: delay, onPlay: (c) => c.repeat(reverse: true))
        .scaleXY(begin: 0.85, end: 1.15, duration: 3.seconds, curve: Curves.easeInOut)
        .fadeIn(begin: 0.4, duration: 3.seconds, curve: Curves.easeInOut);
  }
}

class SwayingWidget extends StatelessWidget {
  final Widget child;
  const SwayingWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .rotate(
          begin: -0.022, end: 0.022,
          duration: 4.seconds,
          curve: Curves.easeInOut,
        );
  }
}
