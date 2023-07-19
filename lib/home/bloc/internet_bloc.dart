import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetInitial()) {
    on<InternetLossEvent>(internetLossEvent);
    on<InternetGainedEvent>(internetGainedEvent);
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetGainedEvent());
      } else {
        add(InternetLossEvent());
      }
    });
  }

  FutureOr<void> internetLossEvent(
      InternetLossEvent event, Emitter<InternetState> emit) {
    emit(InternetLostState());
  }

  FutureOr<void> internetGainedEvent(
      InternetGainedEvent event, Emitter<InternetState> emit) {
    emit(InternetGainedState());
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    // TODO: implement close
    return super.close();
  }
}
