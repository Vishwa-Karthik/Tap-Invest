import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  final String message;
  final Exception? exception;
  const Failures({required this.message, this.exception});

  @override
  List<Object?> get props => [message, exception];
}

class NetworkFailure extends Failures {
  const NetworkFailure({required super.message, super.exception});
}
