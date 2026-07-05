import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_model.dart';

abstract class TaskUpdateEvent {}
class UpdateTaskRequested extends TaskUpdateEvent {
  final String taskId;
  final UpdateTaskRequest request;
  UpdateTaskRequested(this.taskId, this.request);
}

class DeleteTaskRequested extends TaskUpdateEvent {
  final String taskId;
  DeleteTaskRequested(this.taskId);
}