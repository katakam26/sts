import 'dart:async';

import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../models/stat_item.dart';
import 'stat_card_widget.dart';

/// The headline stats as a swipeable carousel that advances on its own every
/// three seconds and rewinds to the first card once the last one is reached.
class StatsCarouselWidget extends StatefulWidget {
  static const Duration autoAdvanceInterval = Duration(seconds: 3);

  const StatsCarouselWidget({super.key});

  @override
  State<StatsCarouselWidget> createState() => _StatsCarouselWidgetState();
}

class _StatsCarouselWidgetState extends State<StatsCarouselWidget> {
  // Shows roughly two and a half cards, so there is always a partial card
  // hinting that the row can be swiped.
  static const double _viewportFraction = 0.42;

  final PageController _controller =
      PageController(viewportFraction: _viewportFraction);
  Timer? _timer;
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients || !_controller.position.haveDimensions) return;
    final page = _controller.page;
    if (page != null && page != _page) {
      setState(() => _page = page);
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.autoAdvanceInterval, (_) => _advance());
  }

  void _advance() {
    if (!_controller.hasClients || !_controller.position.haveDimensions) return;

    final position = _controller.position;
    // Comparing against maxScrollExtent rather than an index, because with a
    // fractional viewport the final card is reached before the final page.
    final atEnd = position.pixels >= position.maxScrollExtent - 1.0;

    if (atEnd) {
      // Drivers is showing: rewind to Total Buses.
      _controller.animateToPage(
        0,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOut,
      );
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final items = StatItem.all;

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.17,
          child: NotificationListener<ScrollNotification>(
            // A manual swipe restarts the clock, so the carousel does not yank
            // out from under the user mid-gesture.
            onNotification: (notification) {
              if (notification is ScrollEndNotification) _startTimer();
              return false;
            },
            child: PageView.builder(
              controller: _controller,
              padEnds: false,
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.025),
                  child: StatCardWidget(
                    icon: items[index].icon,
                    iconColor: items[index].accent,
                    iconBgColor: items[index].accent.withValues(alpha: 0.1),
                    value: items[index].value,
                    label: items[index].label,
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.012),
        _buildIndicator(items.length, screenWidth),
      ],
    );
  }

  Widget _buildIndicator(int count, double screenWidth) {
    final active = _page.round();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.008),
            width: i == active ? screenWidth * 0.05 : screenWidth * 0.016,
            height: screenWidth * 0.016,
            decoration: BoxDecoration(
              color: i == active
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(screenWidth * 0.01),
            ),
          ),
      ],
    );
  }
}
