class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String? planId;
  final bool isRead;
  final String createdAt;

  NotificationModel({
    required this.id, required this.title, required this.message,
    this.planId, required this.isRead, required this.createdAt,
  });

  // أضف هذه الدالة
  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      message: message,
      planId: planId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      planId: json['planId'],
      isRead: json['isRead'],
      createdAt: json['createdAt'],
    );
  }
}