part of 'chng_cubit.dart';

@immutable
sealed class ChangeState {}

final class ChngInitial extends ChangeState {}

final class ChangesModeState extends ChangeState {}
