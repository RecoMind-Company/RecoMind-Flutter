class TeamMemberModel {
  final String? userId;
  final String? userName;
  final String? jobTitle;
  bool isSelected; // بنحتاجها للـ Checkbox في الـ UI

  TeamMemberModel({
    this.userId,
    this.userName,
    this.jobTitle,
    this.isSelected = false,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberModel(
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      jobTitle: json['jobTitle'] as String?,
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'userId': userId,
      if (userName != null) 'userName': userName,
      if (jobTitle != null) 'jobTitle': jobTitle,
    };
  }
}