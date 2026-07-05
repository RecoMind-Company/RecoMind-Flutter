import 'package:recomind/core/network/api_error.dart'; //[cite: 4]
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/team%20leader/dashboard/data/plan_model.dart'; // يحتوي على ApiServiceTeam[cite: 5]

class ProposalsPlanRepository {
  final ApiServicepublic _apiServiceTeam = ApiServicepublic();


 Future<dynamic> getPlansByTeamId() async {
 final response = await _apiServiceTeam.get('/api/Plan/by-teamId');

    if (response is ApiError) {
      return response;
    }

    try {
      return ProposalsPlanResponseModel.fromJson(response);
    } catch (e) {
      return ApiError(
        message: 'Parsing Error: Failed to parse proposals data.',
        data: e,
      ); //[cite: 3]
    }
  }
}