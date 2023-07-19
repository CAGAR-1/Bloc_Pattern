part of 'internet_bloc.dart';

@immutable
abstract class InternetEvent {}

class InternetLossEvent extends InternetEvent {}
class InternetGainedEvent extends InternetEvent {}
