import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_exceptions.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/core/utils/pref_helper.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/data/team_Model.dart';

class TeamRepo {
  ApiServiceTeam apiServiceTeam = ApiServiceTeam();
  ApiServiceInvite apiServiceInvite = ApiServiceInvite();


  /// add department || team
  Future<TeamNameModel> addTeam(AddTeam model) async {
    try {
      final response = await apiServiceTeam.post(
        '/Team/create',
        model.toJson(),
      );

      if (response is ApiError) {
        throw response;
      }

      // لو الريسبونس Map مباشرة
      return TeamNameModel.fromJson(response);

    } on DioError catch (e) {
      throw ApiException.handleError(e);
    }
  }


///Get Team Name
  Future<List<TeamNameModel>> getTeamNames() async {
    try {
      final response = await apiServiceTeam.get('/Team/get-all');

      if (response is ApiError) {
        throw response;
      }

      return (response as List)
          .map((e) => TeamNameModel.fromJson(e))
          .toList();

    } on DioError catch (e) {
      throw ApiException.handleError(e);
    }
  }
/// delete team
  Future<void> delete(String id)async{
    try{
      final response = await apiServiceTeam.delete('/Team/delete/$id');
      print(response);
      final token = await PrefHelper.getToken();
      print(token);
      if(response is ApiError){
        throw response;
      }

      return response;
    }on DioError catch(e) {
      throw ApiException.handleError(e);
    }
  }
  ///update
  Future<void> updateTeam({
    required String departmentId,
    required String teamLeaderId,
  }) async {
    try {
      final response = await apiServiceTeam.put(
        '/Team/update/$departmentId',
        {
          "teamLeadId": teamLeaderId,

        },
      );

      if (response is ApiError) throw response;
    } on DioError catch (e) {
      throw ApiException.handleError(e);
    }
  }



  /// invite
  Future<String> invite(String email) async {
    final response = await apiServiceInvite.post(
      "/api/Invitation/createInvitation",
      {"email": email,"reciverRole": "teamleader"},
    );

    return response["userId"];
  }
}