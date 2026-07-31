import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

/// Sweeps a moving highlight band across [child].
///
/// The child is re-tinted between [baseColor] and [highlightColor], so it works
/// both as a gloss over solid artwork (logo, headings) and as the animation for
/// skeleton placeholders like [ShimmerBox].
class ShimmerEffect extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final Duration delay;
  final bool enabled;

  const ShimmerEffect({
    super.key,
    required this.child,
    this.baseColor = const Color(0xFFE7E7EC),
    this.highlightColor = Colors.white,
    this.duration = const Duration(milliseconds: 2200),
    this.delay = Duration.zero,
    this.enabled = true,
  });

  /// Brand coloured sweep, for orange content on a light background.
  const ShimmerEffect.brand({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 2200),
    this.delay = Duration.zero,
    this.enabled = true,
  })  : baseColor = AppColors.primary,
        highlightColor = AppColors.primaryLight;

  /// White sweep for content sitting on the brand gradient. The base is held
  /// off pure white so the passing highlight actually reads as a highlight.
  const ShimmerEffect.onBrand({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 2200),
    this.delay = Duration.zero,
    this.enabled = true,
  })  : baseColor = const Color(0xB3FFFFFF), // white @ 70%
        highlightColor = Colors.white;

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    if (widget.enabled) _start();
  }

  Future<void> _start() async {
    if (widget.delay != Duration.zero) {
      await Future.delayed(widget.delay);
      if (!mounted) return;
    }
    _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant ShimmerEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled == oldWidget.enabled) return;
    if (widget.enabled) {
      _start();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.baseColor,
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
                widget.baseColor,
              ],
              // Wide highlight band so the sweep is unmistakable.
              stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
              transform: _SlidingGradientTransform(_controller.value),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Moves the gradient from fully off-screen left to fully off-screen right.
class _SlidingGradientTransform extends GradientTransform {
  final double progress;

  const _SlidingGradientTransform(this.progress);

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    // Travel one width either side. A wider throw parks the highlight
    // off-screen for most of the cycle, which is what made it easy to miss.
    return Matrix4.translationValues(
      bounds.width * (progress * 2 - 1),
      0.0,
      0.0,
    );
  }
}

/// A rounded placeholder block meant to be wrapped in a [ShimmerEffect].
class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.cardBorder,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
