import 'dart:convert';

// ==========================================
// 1. Action Plan Models
// ==========================================

class ActionPlanResponse {
  final String id;
  final String teamId;
  final PlanPeriod shortTerm;
  final PlanPeriod midTerm;
  final PlanPeriod longTerm;
  final DateTime? generatedDate;
  final String? errorMessage;

  ActionPlanResponse({
    required this.id,
    required this.teamId,
    required this.shortTerm,
    required this.midTerm,
    required this.longTerm,
    this.generatedDate,
    this.errorMessage,
  });

  factory ActionPlanResponse.fromJson(Map<String, dynamic> json) {
    return ActionPlanResponse(
      id: json['id']?.toString() ?? '',
      teamId: json['teamId']?.toString() ?? '',
      shortTerm: PlanPeriod.fromJson(json['shortTerm'] ?? {}),
      midTerm: PlanPeriod.fromJson(json['midTerm'] ?? {}),
      longTerm: PlanPeriod.fromJson(json['longTerm'] ?? {}),
      generatedDate: json['generatedDate'] != null
          ? DateTime.tryParse(json['generatedDate'].toString())
          : null,
      errorMessage: json['errorMessage']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamId': teamId,
      'shortTerm': shortTerm.toJson(),
      'midTerm': midTerm.toJson(),
      'longTerm': longTerm.toJson(),
      'generatedDate': generatedDate?.toIso8601String(),
      'errorMessage': errorMessage,
    };
  }
}

class PlanPeriod {
  final String goal;
  final String analysis;
  final List<String> recommendations;
  final String reasoning;

  PlanPeriod({
    required this.goal,
    required this.analysis,
    required this.recommendations,
    required this.reasoning,
  });

  factory PlanPeriod.fromJson(Map<String, dynamic> json) {
    return PlanPeriod(
      goal: json['goal']?.toString() ?? '',
      analysis: json['analysis']?.toString() ?? '',
      recommendations: json['recommendations'] != null
          ? List<String>.from(json['recommendations'].map((x) => x.toString()))
          : [],
      reasoning: json['reasoning']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'goal': goal,
      'analysis': analysis,
      'recommendations': recommendations,
      'reasoning': reasoning,
    };
  }
}

// ==========================================
// 2. Shared Sub-Models (Validation Data)
// ==========================================

class KeyFindings {
  final String? precedentAnalysis;
  final String? resourceAssessment;
  final String? marketTrends;

  KeyFindings({
    this.precedentAnalysis,
    this.resourceAssessment,
    this.marketTrends,
  });

  factory KeyFindings.fromJson(Map<String, dynamic> json) {
    return KeyFindings(
      precedentAnalysis: json['precedent_analysis'] as String?,
      resourceAssessment: json['resource_assessment'] as String?,
      marketTrends: json['market_trends'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'precedent_analysis': precedentAnalysis,
      'resource_assessment': resourceAssessment,
      'market_trends': marketTrends,
    };
  }
}

class ValidationContentModel {
  final String? executiveSummary;
  final String? validationDecision;
  final num? confidenceScore;
  final KeyFindings? keyFindings;
  final List<String>? recommendations;
  final List<String>? riskFactors;
  final List<String>? nextSteps;

  ValidationContentModel({
    this.executiveSummary,
    this.validationDecision,
    this.confidenceScore,
    this.keyFindings,
    this.recommendations,
    this.riskFactors,
    this.nextSteps,
  });

  factory ValidationContentModel.fromJson(Map<String, dynamic> json) {
    return ValidationContentModel(
      executiveSummary: json['executive_summary'] as String?,
      validationDecision: json['validation_decision'] as String?,
      confidenceScore: json['confidence_score'] as num?,
      keyFindings: json['key_findings'] != null
          ? KeyFindings.fromJson(json['key_findings'] as Map<String, dynamic>)
          : null,
      recommendations: json['recommendations'] != null
          ? List<String>.from(json['recommendations'] as List)
          : null,
      riskFactors: json['risk_factors'] != null
          ? List<String>.from(json['risk_factors'] as List)
          : null,
      nextSteps: json['next_steps'] != null
          ? List<String>.from(json['next_steps'] as List)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'executive_summary': executiveSummary,
      'validation_decision': validationDecision,
      'confidence_score': confidenceScore,
      'key_findings': keyFindings?.toJson(),
      'recommendations': recommendations,
      'risk_factors': riskFactors,
      'next_steps': nextSteps,
    };
  }
}

// ==========================================
// 3. Validation Core Responses & Requests
// ==========================================

class ValidationReportResponse {
  final String? taskId;
  final String? status;
  final String? message;

  ValidationReportResponse({
    this.taskId,
    this.status,
    this.message,
  });

  factory ValidationReportResponse.fromJson(Map<String, dynamic> json) {
    return ValidationReportResponse(
      taskId: json['task_id'] as String?,
      status: json['status'] as String?,
      message: json['message'] as String?,
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

class SaveValidationRequestModel {
  final String? userRequest;
  final ValidationContentModel? content;
  final int? status;

  SaveValidationRequestModel({
    this.userRequest,
    this.content,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      if (userRequest != null) 'userRequest': userRequest,
      if (content != null) 'content': content!.toJson(),
      if (status != null) 'status': status, // هنا هيبعت الـ 1 كـ int مباشر
    };
  }
}
class SaveValidationResponseModel {
  final String? id;
  final ValidationContentModel? content;
  final String? createdBy;
  final String? createdAt;
  final String? status;

  SaveValidationResponseModel({
    this.id,
    this.content,
    this.createdBy,
    this.createdAt,
    this.status,
  });

  factory SaveValidationResponseModel.fromJson(Map<String, dynamic> json) {
    return SaveValidationResponseModel(
      id: json['id'] as String?,
      content: json['content'] != null
          ? ValidationContentModel.fromJson(json['content'] as Map<String, dynamic>)
          : null,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] as String?,
      status: json['status'] as String?,
    );
  }
}