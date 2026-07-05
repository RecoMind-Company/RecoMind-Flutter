class AddCommentRequest {
  final String userComment;

  AddCommentRequest({required this.userComment});

  Map<String, dynamic> toJson() {
    return {
      'userComment': userComment,
    };
  }
}

class PlanCommentModel {
  final String? id;
  final String? userComment;
  final String? planId;
  final String? userId; // 👈 لازم يكون موجود
  String? userName;     // 👈 خليه String عادي مش final عشان الـ Bloc يعدله
  final String? createdAt;

  PlanCommentModel({
    this.id,
    this.userComment,
    this.planId,
    this.userId,
    this.userName,
    this.createdAt,
  });

  factory PlanCommentModel.fromJson(Map<String, dynamic> json) {
    return PlanCommentModel(
      id: json['id'] as String?,
      userComment: json['userComment'] as String?,
      planId: json['planId'] as String?,
      userId: json['userId'] as String?, // 👈 بيقرأ الـ userId الراجع من السيرفر
      userName: json['userName'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }
}