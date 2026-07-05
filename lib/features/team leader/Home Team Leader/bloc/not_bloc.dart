import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/bloc/not_event.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/bloc/not_state.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/data/notification_repo.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository repository;

  NotificationBloc(this.repository) : super(NotificationInitial()) {
    on<FetchNotifications>((event, emit) async {
      emit(NotificationLoading());
      try {
        final data = await repository.getNotifications();
        emit(NotificationLoaded(data));
      } catch (e) {
        emit(NotificationError(e.toString()));
      }
    });

    // إضافة منطق التحديث
    on<MarkNotificationAsRead>((event, emit) async {
      if (state is NotificationLoaded) {
        final currentState = state as NotificationLoaded;
        // تحديث محلي سريع في الواجهة
        final updatedList = currentState.notifications.map((n) {
          return n.id == event.id ? n.copyWith(isRead: true) : n;
        }).toList();

        emit(NotificationLoaded(updatedList)); // إعادة بناء الواجهة

        // إرسال الطلب للسيرفر
        try {
          await repository.patchMarkAsRead(event.id);
        } catch (e) {
          // يمكن هنا إضافة معالجة للخطأ إذا فشل الاتصال
        }
      }
    });
  }
}