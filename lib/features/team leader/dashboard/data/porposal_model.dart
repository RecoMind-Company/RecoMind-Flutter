class ProposalModel {
  final String? id;
  final String? userQuestion;
  final ProposalContent? content;
  final String? createdBy;
  final String? createdAt;
  final String? status;

  ProposalModel({
    this.id,
    this.userQuestion,
    this.content,
    this.createdBy,
    this.createdAt,
    this.status,
  });

  factory ProposalModel.fromJson(Map<String, dynamic> json) {
    return ProposalModel(
      id: json['id'] as String?,
      userQuestion: json['userQuestion'] as String?,
      content: json['content'] != null
          ? ProposalContent.fromJson(json['content'] as Map<String, dynamic>)
          : null,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] as String?,
      status: json['status'] as String?,
    );
  }

  /// دالة ذكية لتحويل الـ Response بأمان أياً كان شكله من السيرفر
  static List<ProposalModel> fromResponse(dynamic response) {
    if (response is List) {
      return response.map((json) => ProposalModel.fromJson(json as Map<String, dynamic>)).toList();
    } else if (response is Map<String, dynamic>) {
      // فحص الحقول المشهورة التي يضع بها الباك-إند القائمة الفردية (مثل data أو items أو results)
      final dynamic listData = response['data'] ?? response['items'] ?? response['results'] ?? response['proposals'];
      if (listData is List) {
        return listData.map((json) => ProposalModel.fromJson(json as Map<String, dynamic>)).toList();
      }
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userQuestion': userQuestion,
      'content': content?.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt,
      'status': status,
    };
  }
}

class ProposalContent {
  final String? executiveSummary;
  final String? validationDecision;
  final num? confidenceScore;
  final KeyFindings? keyFindings;
  final List<String> recommendations;
  final List<String> riskFactors;
  final List<String> nextSteps;

  ProposalContent({
    this.executiveSummary,
    this.validationDecision,
    this.confidenceScore,
    this.keyFindings,
    this.recommendations = const [],
    this.riskFactors = const [],
    this.nextSteps = const [],
  });

  factory ProposalContent.fromJson(Map<String, dynamic> json) {
    return ProposalContent(
      executiveSummary: json['executive_summary'] as String?,
      validationDecision: json['validation_decision'] as String?,
      confidenceScore: json['confidence_score'] as num?,
      keyFindings: json['key_findings'] != null
          ? KeyFindings.fromJson(json['key_findings'] as Map<String, dynamic>)
          : null,
      recommendations: (json['recommendations'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      riskFactors: (json['risk_factors'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      nextSteps: (json['next_steps'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
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

/// single one
class ValidationReportModel {
  final String? id;
  final String? queryText;
  final ReportContent? reportContent;
  final String? author;
  final String? creationDate;
  final String? reviewStatus;

  ValidationReportModel({
    this.id,
    this.queryText,
    this.reportContent,
    this.author,
    this.creationDate,
    this.reviewStatus,
  });

  factory ValidationReportModel.fromJson(Map<String, dynamic> json) {
    return ValidationReportModel(
      id: json['id'] as String?,
      queryText: json['userQuestion'] as String?,
      reportContent: json['content'] != null
          ? ReportContent.fromJson(json['content'] as Map<String, dynamic>)
          : null,
      author: json['createdBy'] as String?,
      creationDate: json['createdAt'] as String?,
      reviewStatus: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userQuestion': queryText,
      'content': reportContent?.toJson(),
      'createdBy': author,
      'createdAt': creationDate,
      'status': reviewStatus,
    };
  }
}

class ReportContent {
  final String? summary;
  final String? decision;
  final num? score;
  final CoreFindings? coreFindings;
  final List<String> adviceList;
  final List<String> threats;
  final List<String> futureSteps;

  ReportContent({
    this.summary,
    this.decision,
    this.score,
    this.coreFindings,
    this.adviceList = const [],
    this.threats = const [],
    this.futureSteps = const [],
  });

  factory ReportContent.fromJson(Map<String, dynamic> json) {
    return ReportContent(
      summary: json['executive_summary'] as String?,
      decision: json['validation_decision'] as String?,
      score: json['confidence_score'] as num?,
      coreFindings: json['key_findings'] != null
          ? CoreFindings.fromJson(json['key_findings'] as Map<String, dynamic>)
          : null,
      adviceList: (json['recommendations'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      threats: (json['risk_factors'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      futureSteps: (json['next_steps'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'executive_summary': summary,
      'validation_decision': decision,
      'confidence_score': score,
      'key_findings': coreFindings?.toJson(),
      'recommendations': adviceList,
      'risk_factors': threats,
      'next_steps': futureSteps,
    };
  }
}

class CoreFindings {
  final String? historyAnalysis;
  final String? assetsAssessment;
  final String? industryTrends;

  CoreFindings({
    this.historyAnalysis,
    this.assetsAssessment,
    this.industryTrends,
  });

  factory CoreFindings.fromJson(Map<String, dynamic> json) {
    return CoreFindings(
      historyAnalysis: json['precedent_analysis'] as String?,
      assetsAssessment: json['resource_assessment'] as String?,
      industryTrends: json['market_trends'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'precedent_analysis': historyAnalysis,
      'resource_assessment': assetsAssessment,
      'market_trends': industryTrends,
    };
  }
}
/// approve & reject
class UpdateReportStatusRequestModel {
  final String id;
  final int status;

  UpdateReportStatusRequestModel({
    required this.id,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
    };
  }
}