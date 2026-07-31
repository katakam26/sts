import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

// Initial state, before the intro is started
class SplashInitial extends SplashState {}

// Intro is running: shimmer sweeps and role cards are revealing
class SplashShimmering extends SplashState {}

// Intro finished, the app may hand off to the auth flow
class SplashCompleted extends SplashState {}
