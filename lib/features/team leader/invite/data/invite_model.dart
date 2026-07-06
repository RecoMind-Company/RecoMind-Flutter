class TeamInfoModel {
  final String? companyId;
  final String? teamId;
  final String? teamName;

  TeamInfoModel({
    this.companyId,
    this.teamId,
    this.teamName,
  });

  // تحويل الـ JSON القادم من الـ API إلى Object
  factory TeamInfoModel.fromJson(Map<String, dynamic> json) {
    // التعامل مع وجود كبسولة 'result' أو إذا كانت البيانات مبعوثة مباشرة
    final Map<String, dynamic> targetJson = json['result'] != null
        ? json['result'] as Map<String, dynamic>
        : json;

    return TeamInfoModel(
      companyId: targetJson['companyId']?.toString(),
      teamId: targetJson['teamId']?.toString(),
      teamName: targetJson['teamName']?.toString(),
    );
  }

  // تحويل الـ Object إلى Map لو احتجت تبعته في الـ Body لأي مكان
  Map<String, dynamic> toJson() {
    return {
      "companyId": companyId,
      "teamId": teamId,
      "teamName": teamName,
    };
  }
}




/// get team
class InvitationStatusModel {
  final String? userName;
  final String? status;
  final String? expMessage;

  InvitationStatusModel({
    this.userName,
    this.status,
    this.expMessage,
  });

  // تحويل الـ JSON القادم من الـ API إلى Object
  factory InvitationStatusModel.fromJson(Map<String, dynamic> json) {
    return InvitationStatusModel(
      userName: json['userName']?.toString(),
      status: json['status']?.toString(),
      expMessage: json['expMessage']?.toString(),
    );
  }

  // تحويل الـ Object إلى Map إذا احتجت التعامل معه كـ JSON
  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "status": status,
      "expMessage": expMessage,
    };
  }
}


/// create invite
