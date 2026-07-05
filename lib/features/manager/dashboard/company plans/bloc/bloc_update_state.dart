abstract class TaskUpdateState {}
class TaskUpdateInitial extends TaskUpdateState {}
class TaskUpdateLoading extends TaskUpdateState {}
class TaskUpdateSuccess extends TaskUpdateState {}
// تعديل هنا: تمرير الـ id للمهمة المحذوفة
class TaskDeleteSuccess extends TaskUpdateState {
  final String deletedTaskId;
  TaskDeleteSuccess(this.deletedTaskId);
}
class TaskUpdateError extends TaskUpdateState {
  final String error;
  TaskUpdateError(this.error);
}