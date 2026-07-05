abstract class NotificationEvent {}
class FetchNotifications extends NotificationEvent {}

// أضف هذا الحدث
class MarkNotificationAsRead extends NotificationEvent {
  final String id;
  MarkNotificationAsRead(this.id);
}