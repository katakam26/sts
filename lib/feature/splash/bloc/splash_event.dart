import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

// Event for starting the splash intro (shimmer + role reveal)
class StartSplashEvent extends SplashEvent {}

// Event for skipping the remaining intro, e.g. user tapped the screen
class SkipSplashEvent extends SplashEvent {}
