import 'dart:convert';

// =========================================================================
// 1. استجابة إنشاء خطة مخصصة أو جلبها (Custom Plan / Background Task)
// =========================================================================
class PlanResponse {
  final String? taskId;
  final String status;
  final String? message;
  final int? progress;
  final String? planId;
  final String? planTitle;
  final String? startDate;
  final String? deadlineDate;
  final int totalEstimatedDays;
  final List<PlanModule> modules;
  final List<PlanTimeline> timeline;
  final String? error;

  PlanResponse({
    this.taskId,
    required this.status,
    this.message,
    this.progress,
    this.planId,
    this.planTitle,
    this.startDate,
    this.deadlineDate,
    this.totalEstimatedDays = 0,
    this.modules = const [],
    this.timeline = const [],
    this.error,
  });

  factory PlanResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> targetJson = json['result'] != null
        ? json['result'] as Map<String, dynamic>
        : json;

    return PlanResponse(
      taskId: (json['task_id'] ?? json['taskId'])?.toString(),
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString(),
      progress: json['progress'] is int ? json['progress'] : int.tryParse(json['progress']?.toString() ?? ''),
      error: json['error']?.toString(),
      planId: (targetJson['plan_id'] ?? targetJson['planId'])?.toString(),
      planTitle: targetJson['plan_title']?.toString() ?? targetJson['planTitle']?.toString(),
      startDate: targetJson['start_date']?.toString() ?? targetJson['startDate']?.toString(),
      deadlineDate: targetJson['deadline_date']?.toString() ?? targetJson['deadlineDate']?.toString(),
      totalEstimatedDays: targetJson['total_estimated_days'] ?? targetJson['totalEstimatedDays'] ?? 0,
      modules: (targetJson['modules'] as List?)
          ?.map((e) => PlanModule.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      timeline: (targetJson['timeline'] as List?)
          ?.map((e) => PlanTimeline.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}

class PlanModule {
  final String moduleId;
  final String moduleName;
  final List<PlanTask> tasks;

  PlanModule({
    required this.moduleId,
    required this.moduleName,
    required this.tasks,
  });

  factory PlanModule.fromJson(Map<String, dynamic> json) {
    return PlanModule(
      moduleId: (json['module_id'] ?? json['moduleId'])?.toString() ?? '',
      moduleName: json['module_name']?.toString() ?? json['moduleName']?.toString() ?? '',
      tasks: (json['tasks'] as List?)
          ?.map((e) => PlanTask.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}

class PlanTask {
  final String taskId;
  String title; // تم حذف final
  String description; // تم حذف final
  int durationDays; // تم حذف final
  String startDate; // تم حذف final
  String deadlineDate; // تم حذف final
  final SuggestedOwner suggestedOwner;
  final String? reason;
  final List<String> dependencies;
  String status; // تم حذف final
  String priority; // تم حذف final

  PlanTask({
    required this.taskId,
    required this.title,
    required this.description,
    required this.durationDays,
    required this.startDate,
    required this.deadlineDate,
    required this.suggestedOwner,
    this.reason,
    this.dependencies = const [],
    required this.status,
    required this.priority,
  });

  factory PlanTask.fromJson(Map<String, dynamic> json) {
    return PlanTask(
      taskId: (json['task_id'] ?? json['taskId'])?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      durationDays: json['duration_days'] ?? json['durationDays'] ?? 0,
      startDate: json['start_date']?.toString() ?? json['startDate']?.toString() ?? '',
      deadlineDate: json['deadline_date']?.toString() ?? json['deadlineDate']?.toString() ?? '',
      suggestedOwner: SuggestedOwner.fromJson(json['suggested_owner'] ?? json['suggestedOwner'] ?? {}),
      reason: json['reason']?.toString(),
      dependencies: (json['dependencies'] as List?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      status: json['status']?.toString() ?? '',
      priority: json['priority']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'task_id': taskId,
      'title': title,
      'description': description,
      'duration_days': durationDays,
      'start_date': startDate,
      'deadline_date': deadlineDate,
      'status': status,
      'priority': priority,
      'suggested_owner': {
        'user_id': suggestedOwner.userId,
        'job_title': suggestedOwner.jobTitle,
        'reason': suggestedOwner.reason,
      },
      'dependencies': dependencies,
      'reason': reason,
    };
  }
}

class SuggestedOwner {
  final String userId;
  final String jobTitle;
  final String? reason;

  SuggestedOwner({
    required this.userId,
    required this.jobTitle,
    this.reason,
  });

  factory SuggestedOwner.fromJson(Map<String, dynamic> json) {
    return SuggestedOwner(
      userId: (json['user_id'] ?? json['userId'])?.toString() ?? '',
      jobTitle: json['job_title']?.toString() ?? json['jobTitle']?.toString() ?? '',
      reason: json['reason']?.toString(),
    );
  }
}

class PlanTimeline {
  final String phase;
  final int startDay;
  final int endDay;
  final String startDate;
  final String endDate;

  PlanTimeline({
    required this.phase,
    required this.startDay,
    required this.endDay,
    required this.startDate,
    required this.endDate,
  });

  factory PlanTimeline.fromJson(Map<String, dynamic> json) {
    return PlanTimeline(
      phase: json['phase']?.toString() ?? '',
      startDay: json['start_day'] ?? json['startDay'] ?? 0,
      endDay: json['end_day'] ?? json['endDay'] ?? 0,
      startDate: json['start_date']?.toString() ?? json['startDate']?.toString() ?? '',
      endDate: json['end_date']?.toString() ?? json['endDate']?.toString() ?? '',
    );
  }
}

// =========================================================================
// 2. تفاصيل الخطة والمغلف الخاص بها (/api/Plan/GetId/:id و /api/Plan/GetAll)
// =========================================================================
class CompanyPlanResponseItem {
  final ActualPlanModel? value;
  final bool isSuccess;
  final bool isFailure;
  final String? error;

  CompanyPlanResponseItem({
    this.value,
    required this.isSuccess,
    required this.isFailure,
    this.error,
  });

  factory CompanyPlanResponseItem.fromJson(Map<String, dynamic> json) {
    return CompanyPlanResponseItem(
      value: json['value'] != null ? ActualPlanModel.fromJson(json['value']) : null,
      isSuccess: json['isSuccess'] ?? false,
      isFailure: json['isFailure'] ?? true,
      error: json['error']?.toString(),
    );
  }

  // دالة مساعدة لتحويل الـ List القادمة من GetAll مباشرة بشكل آمن
  static List<CompanyPlanResponseItem> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CompanyPlanResponseItem.fromJson(json as Map<String, dynamic>)).toList();
  }
}

// تم دمج كلاس الـ PlanDetailModel والـ ActualPlanModel ليكونا كلاس واحد موحد منعاً للتكرار واللخبطة
class ActualPlanModel {
  final String id;
  final String? description;
  final String goal;
  final String? planType;
  final String status;
  final bool isApproved;
  final String? feedback;
  final String duration;
  final List<PlanModuleModel> modules;

  ActualPlanModel({
    required this.id,
    this.description,
    required this.goal,
    this.planType,
    required this.status,
    required this.isApproved,
    this.feedback,
    required this.duration,
    required this.modules,
  });

  factory ActualPlanModel.fromJson(Map<String, dynamic> json) {
    return ActualPlanModel(
      id: json['id']?.toString() ?? '',
      description: json['description']?.toString(),
      goal: json['goal']?.toString() ?? '',
      planType: json['planType']?.toString() ?? json['plan_type']?.toString(),
      status: json['status']?.toString() ?? 'draft',
      isApproved: json['isApproved'] ?? json['is_approved'] ?? false,
      feedback: json['feedback']?.toString(),
      duration: json['duration']?.toString() ?? '0',
      modules: (json['modules'] as List?)
          ?.map((e) => PlanModuleModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}

class PlanModuleModel {
  final String id;
  final String name;

  PlanModuleModel({
    required this.id,
    required this.name,
  });

  factory PlanModuleModel.fromJson(Map<String, dynamic> json) {
    return PlanModuleModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}

// تماشيًا مع كلاس الـ Wrapper القديم إذا كان هناك أجزاء تعتمد على هذا الإسم كـ Alias
typedef CompanyPlanDetailResponse = CompanyPlanResponseItem;

// =========================================================================
// 3. نموذج جلب عناصر التاسكات المنفصلة للموديولات (/api/tasks/:planId/all)
// =========================================================================
class TaskModel {
  final String questId;
  final String title;
  final String description;
  final String status;
  final String priority;
  final String startDate;
  final String deadLine;
  final String duration;
  final String moduleId;
  final String planId;
  final List<String> userAssignedQuests;

  TaskModel({
    required this.questId,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.startDate,
    required this.deadLine,
    required this.duration,
    required this.moduleId,
    required this.planId,
    required this.userAssignedQuests,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      questId: (json['questId'] ?? json['quest_id'])?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      status: json['status']?.toString() ?? 'to_do',
      priority: json['priority']?.toString() ?? 'Low',
      startDate: (json['startDate'] ?? json['start_date'])?.toString() ?? '',
      deadLine: (json['deadLine'] ?? json['deadline'] ?? json['deadline_date'])?.toString() ?? '',
      duration: json['duration']?.toString() ?? '',
      moduleId: (json['moduleId'] ?? json['module_id'])?.toString() ?? '',
      planId: (json['planId'] ?? json['plan_id'])?.toString() ?? '',
      userAssignedQuests: (json['userAssignedQuests'] as List?)
          ?.map((e) => e.toString())
          .toList() ?? [],
    );
  }
}

// =========================================================================
// 4. بقية النماذج المساعدة والفلاتر
// =========================================================================
class PlanFiltersCount {
  final int all;
  final int actionRequired;
  final int active;
  final int pending;
  final int completed;

  PlanFiltersCount({
    required this.all,
    required this.actionRequired,
    required this.active,
    required this.pending,
    required this.completed,
  });
}

// =========================================================================
// 5. الموديلات الخاصة بعمليات الـ Approval والـ Generate من الـ Postman
// =========================================================================
class CustomPlanGenerateResponse {
  final String taskId;
  final String status;
  final String message;

  CustomPlanGenerateResponse({
    required this.taskId,
    required this.status,
    required this.message,
  });

  factory CustomPlanGenerateResponse.fromJson(Map<String, dynamic> json) {
    return CustomPlanGenerateResponse(
      taskId: (json['task_id'] ?? json['taskId'])?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'status': status,
      'message': message,
    };
  }
}

class PlanApprovalRequest {
  final String planId;
  final bool isApproved;
  final String feedback;
  final String status;


  PlanApprovalRequest({
    required this.planId,
    required this.isApproved,
    required this.feedback,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'planId': planId,
      'isAproved': isApproved, // مكتوبة بـ p واحدة لتطابق الـ Request الخاص بالـ API
      'feedback': feedback,
      'status': status,
    };
  }
}


/// plan terms
class ReportDetailResponse {
  final String? id;
  final String? teamId;
  final ReportTermData? shortTerm;
  final ReportTermData? midTerm;
  final ReportTermData? longTerm;
  final String? generatedDate;
  final String? errorMessage;

  ReportDetailResponse({
    this.id,
    this.teamId,
    this.shortTerm,
    this.midTerm,
    this.longTerm,
    this.generatedDate,
    this.errorMessage,
  });

  factory ReportDetailResponse.fromJson(Map<String, dynamic> json) {
    return ReportDetailResponse(
      id: json['id']?.toString(),
      teamId: json['teamId']?.toString(),
      shortTerm: json['shortTerm'] != null
          ? ReportTermData.fromJson(json['shortTerm'])
          : null,
      midTerm: json['midTerm'] != null
          ? ReportTermData.fromJson(json['midTerm'])
          : null,
      longTerm: json['longTerm'] != null
          ? ReportTermData.fromJson(json['longTerm'])
          : null,
      generatedDate: json['generatedDate']?.toString(),
      errorMessage: json['errorMessage']?.toString(),
    );
  }
}

class ReportTermData {
  final String? goal;
  final String? analysis;
  final List<String>? recommendations;
  final String? reasoning;
  final String? scenarios;
  final String? riskManagement;

  ReportTermData({
    this.goal,
    this.analysis,
    this.recommendations,
    this.reasoning,
    this.scenarios,
    this.riskManagement,
  });

  factory ReportTermData.fromJson(dynamic json) {
    if (json is! Map) {
      return ReportTermData();
    }
    return ReportTermData(
      goal: json['goal']?.toString(),
      analysis: json['analysis']?.toString(),
      recommendations: json['recommendations'] != null
          ? (json['recommendations'] as List).map((item) => item.toString()).toList()
          : null,
      reasoning: json['reasoning']?.toString(),
      scenarios: json['scenarios']?.toString(),
      riskManagement: json['riskManagement']?.toString(),
    );
  }
}
///update task
class UpdateTaskRequest {
  final String title;
  final String description;
  final int status;
  final String startDate;
  final String deadLine; // ✅ تم توحيد الاسم هنا ومطابقته مع الـ JSON

  UpdateTaskRequest({
    required this.title,
    required this.description,
    required this.status,
    required this.startDate,
    required this.deadLine, // ✅ تمريرها في الـ Constructor
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "status": status,
      "startDate": startDate,
      "deadLine": deadLine,   // ✅ تعديل المفتاح ليطابق الـ API تماماً بدلاً من deadlineDate
      // ✅ إرسال قائمة الأعضاء المحددة
    };
  }
}
/// team plan
class ShortPlanDto {
  final String? planId;
  final String? planName;
  final String? status; // يفضل تخلي اسم المتغير camelCase كـ clean code

  ShortPlanDto({this.planId, this.planName, this.status});

  factory ShortPlanDto.fromJson(Map<String, dynamic> json) {
    // 1. بندعم لو الـ Key جيه كابيتال 'Status' أو سمول 'status'
    final statusValue = json['Status'] ?? json['status'];

    return ShortPlanDto(
      planId: json['planId']?.toString(),
      planName: json['planName']?.toString(),
      // 2. لو الـ status مش موجودة أو null، بنديها قيمة افتراضية 'pending'
      status: statusValue != null ? statusValue.toString() : 'pending',
    );
  }
}