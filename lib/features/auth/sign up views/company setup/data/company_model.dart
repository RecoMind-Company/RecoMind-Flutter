class inviteModel {
  String? email , reciverRole , companyId,token , Id;
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
  String? name , industry , country , size,code,description,subscriptionId,adminId,id;
  setupModel({
    this.name,
    this.industry,
    this.country,
    this.size,
    this.code,
    this.description,
    this.subscriptionId,
    this.adminId,
    this.id
});
  factory setupModel.fromJson(Map<String, dynamic> json) {
    return setupModel(
      id: json['id'],
      name: json['name'],
      industry: json['industry'],
      country: json['country'],
      size: json['size'],
      code: json['code'],
      description: json['description'],
      subscriptionId: json['subscriptionId'],
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