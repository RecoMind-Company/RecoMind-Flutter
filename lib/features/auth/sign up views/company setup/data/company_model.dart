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




class DBModel {
 final String? name,server,dbName,user,password,dbType,id;
 DBModel({
   this.user,
   this.name,
   this.server,
   this.dbName,
   this.password,
   this.dbType,
   this.id
 });
 factory DBModel.fromJson(Map<String, dynamic> json) {
   return DBModel(
     name: json['name'],
     server: json['server'],
     dbName: json['dbName'],
     user: json['user'],
     password: json['password'],
     dbType: json['DbType'],
     id: json['id'],
   );
 }
}