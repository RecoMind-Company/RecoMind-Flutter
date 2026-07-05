import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recomind/features/team%20leader/dashboard/bloc/user_task_event.dart';
import 'package:recomind/features/team%20leader/dashboard/bloc/user_task_state.dart';
import 'package:recomind/features/team%20leader/dashboard/data/team_work_repo.dart';
// ... استيراد الـ Events و States المذكورة أعلاه

class UserTasksBloc extends Bloc<UserTasksEvent, UserTasksState> {
  final UserTaskRepository repository;

  UserTasksBloc(this.repository) : super(UserTasksInitial()) {
    on<FetchUserTasks>((event, emit) async {
      emit(UserTasksLoading());
      try {
        final tasks = await repository.getUserTasks(); // جلب البيانات من الريبو
        emit(UserTasksLoaded(tasks));
      } catch (e) {
        emit(UserTasksError(e.toString()));
      }
    });
  }
}