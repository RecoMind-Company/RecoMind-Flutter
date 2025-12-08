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
  final String? aiResponse;
  final String? generatedDate;

  TaskStatusResponse({this.aiResponse, this.generatedDate});

  factory TaskStatusResponse.fromJson(Map<String, dynamic> json) {
    return TaskStatusResponse(
      aiResponse: json['aiResponse'],
      generatedDate: json['generatedDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aiResponse': aiResponse,
      'generatedDate': generatedDate,
    };
  }
}
