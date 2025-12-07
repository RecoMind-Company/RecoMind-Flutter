class CreateReportTaskModel {
  final String taskId;
  final String status;
  final String message;

  CreateReportTaskModel({
    required this.taskId,
    required this.status,
    required this.message,
  });

  factory CreateReportTaskModel.fromJson(Map<String, dynamic> json) {
    return CreateReportTaskModel(
      taskId: json["task_id"],
      status: json["status"],
      message: json["message"],
    );
  }
}

class TaskStatusResponse {
  final String taskId;
  final String status;
  final String? result;

  TaskStatusResponse({
    required this.taskId,
    required this.status,
    this.result,
  });

  factory TaskStatusResponse.fromJson(Map<String, dynamic> json) {
    return TaskStatusResponse(
      taskId: json['TaskId'] ?? '',
      status: json['Status'] ?? '',
      result: json['Result'], // ممكن تكون null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'status': status,
      'result': result,
    };
  }
}
