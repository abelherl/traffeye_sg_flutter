import 'package:equatable/equatable.dart';

sealed class Failure {}

class ConnectionFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class GeneralFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}