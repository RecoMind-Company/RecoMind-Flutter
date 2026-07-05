class InvitationModel {
  final String? userName;
  final String? status;
  final String? expMessage;

  InvitationModel({
    this.userName,
    this.status,
    this.expMessage,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      userName: json['userName'] as String?,
      status: json['status'] as String?,
      expMessage: json['expMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'status': status,
      'expMessage': expMessage,
    };
  }
}