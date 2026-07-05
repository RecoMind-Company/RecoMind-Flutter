class ProposalsPlanResponseModel {
  final List<ShortPlanDto> shortPlanDtos;

  ProposalsPlanResponseModel({required this.shortPlanDtos});

  factory ProposalsPlanResponseModel.fromJson(Map<String, dynamic> json) {
    return ProposalsPlanResponseModel(
      shortPlanDtos: (json['shortPlanDtos'] as List? ?? [])
          .map((item) => ShortPlanDto.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shortPlanDtos': shortPlanDtos.map((item) => item.toJson()).toList(),
    };
  }
}

class ShortPlanDto {
  final String planId;
  final String planName;

  ShortPlanDto({
    required this.planId,
    required this.planName,
  });

  factory ShortPlanDto.fromJson(Map<String, dynamic> json) {
    return ShortPlanDto(
      planId: json['planId'] ?? '',
      planName: json['planName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'planId': planId,
      'planName': planName,
    };
  }
}