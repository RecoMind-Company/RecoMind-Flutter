import 'dart:convert';

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
  final String? id; // إضافة حقل الـ id
  final String? aiResponse;
  final String? generatedDate;

  TaskStatusResponse({
    this.id,
    this.aiResponse,
    this.generatedDate
  });

  factory TaskStatusResponse.fromJson(Map<String, dynamic> json) {
    return TaskStatusResponse(
      id: json['id']?.toString(), // قراءة الـ id من الـ JSON
      aiResponse: json['aiResponse'],
      generatedDate: json['generatedDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aiResponse': aiResponse,
      'generatedDate': generatedDate,
    };
  }
}
/// all report

class SalesReportResponse {
  final String id;
  final String teamId;
  final String userId;
  final String periodic;
  final String content;
  final DateTime? generatedDate;

  SalesReportResponse({
    required this.id,
    required this.teamId,
    required this.userId,
    required this.periodic,
    required this.content,
    this.generatedDate,
  });

  factory SalesReportResponse.fromJson(Map<String, dynamic> json) {
    return SalesReportResponse(
      id: json['id']?.toString() ?? '',
      teamId: json['teamId']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      periodic: json['periodic']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      generatedDate: json['generatedDate'] != null
          ? DateTime.tryParse(json['generatedDate'].toString())
          : null,
    );
  }

  static List<SalesReportResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((e) => SalesReportResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static List<SalesReportResponse> fromRawJson(String str) {
    final List<dynamic> jsonList = json.decode(str);
    return SalesReportResponse.fromJsonList(jsonList);
  }
}