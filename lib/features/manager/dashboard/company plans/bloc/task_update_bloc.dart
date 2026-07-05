import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/bloc/bloc_update_state.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/bloc/task_update_event.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_repo.dart';

class TaskUpdateBloc extends Bloc<TaskUpdateEvent, TaskUpdateState> {
  final PlanRepository repo;

  TaskUpdateBloc(this.repo) : super(TaskUpdateInitial()) {
    on<UpdateTaskRequested>((event, emit) async {
      emit(TaskUpdateLoading());

      try {
        debugPrint("UPDATE TASK ID: ${event.taskId}");

        final isSuccess = await repo.updateTask(
          questId: event.taskId,
          request: event.request,
        );

        if (isSuccess) {
          emit(TaskUpdateSuccess());
        } else {
          emit(TaskUpdateError("فشل التحديث: البيانات على الخادم لم تتغير."));
        }
      } catch (e) {
        debugPrint("UPDATE ERROR: $e");
        emit(TaskUpdateError(e.toString()));
      }
    });

    on<DeleteTaskRequested>((event, emit) async {
      emit(TaskUpdateLoading());
      try {
        await repo.deleteTask(questId: event.taskId);
        // التعديل هنا: تمرير الـ id الذي تم حذفه
        emit(TaskDeleteSuccess(event.taskId));
      } catch (e) {
        emit(TaskUpdateError(e.toString()));
      }
    });
  }
}