
/// Add Team
class AddTeam {
  final String? name , teamLeadId ;
 AddTeam({this.name,this.teamLeadId});
 Map<String , dynamic> toJson()=> {
   "name":name,
   "teamLeadId":teamLeadId,
 };
}

/// get team
class TeamNameModel {
  final String id;
  final String name;
  final String? teamLeadId;

  TeamNameModel({
    required this.id,
    required this.name,
    required this.teamLeadId,
  });

  factory TeamNameModel.fromJson(Map<String, dynamic> json) {
    return TeamNameModel(
      id: json['id'] as String,
      name: json['name'] as String,
      teamLeadId: json['teamLeadId'] as String?,
    );
  }
}