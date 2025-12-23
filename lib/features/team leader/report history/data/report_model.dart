class CreateReportTaskModel {
  final String teamName;
  final String teamId;
  final String companyId;

  CreateReportTaskModel({
    required this.teamName,
    required this.teamId,
    required this.companyId,
  });

  factory CreateReportTaskModel.fromJson(Map<String, dynamic> json) {
    return CreateReportTaskModel(
      teamId: json["teamId"],
      teamName: json["teamName"],
      companyId: json["companyId"],
    );
  }
}

class CreateReportrequistModel {
  final String? task_id;


  CreateReportrequistModel({
    required this.task_id
  });

  factory CreateReportrequistModel.fromJson(Map<String, dynamic> json) {
    return CreateReportrequistModel(
      task_id: json["task_id"]
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
