import 'package:bloc/bloc.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  // How long the shimmer intro stays on screen before handing off to auth.
  static const Duration introDuration = Duration(milliseconds: 3200);

  SplashBloc() : super(SplashInitial()) {
    on<StartSplashEvent>(_onStartSplash);
    on<SkipSplashEvent>(_onSkipSplash);
  }

  Future<void> _onStartSplash(
      StartSplashEvent event,
      Emitter<SplashState> emit,
      ) async {
    if (state is SplashCompleted) return;

    emit(SplashShimmering());
    await Future.delayed(introDuration);

    // Guard against SkipSplashEvent having already finished the intro.
    if (state is SplashCompleted) return;
    emit(SplashCompleted());
  }

  Future<void> _onSkipSplash(
      SkipSplashEvent event,
      Emitter<SplashState> emit,
      ) async {
    if (state is SplashCompleted) return;
    emit(SplashCompleted());
  }
}
