part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUsersEvent extends UserEvent {
  final int count;

  GetUsersEvent(this.count);
}

class GetJobsEvent extends UserEvent {
  final int count;

  GetJobsEvent(this.count);
}

