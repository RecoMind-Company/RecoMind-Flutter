class inviteModel {
  String? email , reciverRole , companyId,token;
  inviteModel({this.email,this.reciverRole,this.companyId,this.token});
  factory inviteModel.fromJson(Map<String, dynamic> json) {
    return inviteModel(
      email: json['email'],
      reciverRole: json['reciverRole'],
      companyId: json['companyId'],
      token: json['token'],
    );
  }

}


class setupModel {
  String? name , industry , country , size,code,description,subscriptionId,adminId,token;
  setupModel({
    this.name,
    this.industry,
    this.country,
    this.size,
    this.code,
    this.description,
    this.subscriptionId,
    this.adminId,
    this.token
});
  factory setupModel.fromJson(Map<String, dynamic> json) {
    return setupModel(
      name: json['name'],
      industry: json['industry'],
      country: json['country'],
      size: json['size'],
      code: json['code'],
      description: json['description'],
      subscriptionId: json['subscriptionId'],
      adminId: json['adminId'],
      token: json['token'],
    );

  }

}