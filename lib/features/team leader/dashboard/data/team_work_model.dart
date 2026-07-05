class UserTaskModel {
  final String questId;
  final String title;
  final String description;
  final String status;
  final String priority;
  final String startDate;
  final String deadline;
  final String duration;
  final String moduleId;
  final String? planId;
  final List<String> userAssignedQuests;

  UserTaskModel({
    required this.questId,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.startDate,
    required this.deadline,
    required this.duration,
    required this.moduleId,
    this.planId,
    required this.userAssignedQuests,
  });

  factory UserTaskModel.fromJson(Map<String, dynamic> json) {
    return UserTaskModel(
      questId: json['questId']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      priority: json['priority']?.toString() ?? '',
      startDate: json['startDate']?.toString() ?? DateTime.now().toString(),
      deadline: json['deadLine']?.toString() ?? '', // لاحظ التأكد من اسم المفتاح deadLine (بـ L صغيرة أو كبيرة)
      duration: json['duration']?.toString() ?? '',
      moduleId: json['moduleId']?.toString() ?? '',
      planId: json['planId']?.toString(), // هذا مسموح يكون null
      userAssignedQuests: List<String>.from(json['userAssignedQuests'] ?? []),
    );
  }
}


/// add task ////////////////////////


class AddTaskToPlanRequestModel {
  final String taskId;
  final String planId;

  AddTaskToPlanRequestModel({
    required this.taskId,
    required this.planId,
  });

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'planId': planId,
    };
  }
}

class AddTaskToPlanResponseModel {
  final String? message;
  final bool? isSuccess;

  AddTaskToPlanResponseModel({
    this.message,
    this.isSuccess,
  });

  factory AddTaskToPlanResponseModel.fromJson(Map<String, dynamic> json) {
    return AddTaskToPlanResponseModel(
      message: json['message'] as String?,
      isSuccess: json['isSuccess'] as bool?,
    );
  }
}
