class InvitationModel {
  final String? userName;
  final String? status;
  final String? expMessage;
  final String? email; // ✨ تم إضافة الإيميل هنا

  InvitationModel({
    this.userName,
    this.status,
    this.expMessage,
    this.email,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      userName: json['userName'] as String?,
      status: json['status'] as String?,
      expMessage: json['expMessage'] as String?,
      email: json['email'] as String?, // ✨ قراءة الإيميل من الـ JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'status': status,
      'expMessage': expMessage,
      'email': email,
    };
  }
}