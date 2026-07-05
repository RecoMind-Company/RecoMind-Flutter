import 'package:recomind/features/team%20leader/dashboard/data/team_work_model.dart';

abstract class UserTasksState {}

class UserTasksInitial extends UserTasksState {}
class UserTasksLoading extends UserTasksState {}
class UserTasksLoaded extends UserTasksState {
  final List<UserTaskModel> tasks;
  UserTasksLoaded(this.tasks);
}
class UserTasksError extends UserTasksState {
  final String message;
  UserTasksError(this.message);
}