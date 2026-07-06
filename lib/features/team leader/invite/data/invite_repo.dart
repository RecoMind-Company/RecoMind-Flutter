import 'package:flutter/material.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/team%20leader/invite/data/invite_model.dart';



class TeamInfoRepository {
  final ApiServicepublic _apiService = ApiServicepublic();

  Future<TeamInfoModel> getTeamDetails() async {
    try {
      const endpoint = '/api/Team/by-leader';

      debugPrint("🚀 Fetching new team details from: $endpoint");
      final response = await _apiService.get(endpoint);
      debugPrint("✅ Team details response received");

      return TeamInfoModel.fromJson(response);
    } catch (e) {
      debugPrint('❌ Error fetching team details: $e');
      rethrow;
    }


    /// get team
    ///
  }

  /// get team
  Future<List<InvitationStatusModel>> getInvitationsByStatus({
    required String companyId,
    required String status,
  }) async {
    try {
      const endpoint = '/api/Invitation/byStatus';

      debugPrint("🚀 Fetching invitations for Company: $companyId with Status: $status");

      // تمرير الـ Query Parameters للـ API
      final response = await _apiService.get(
        endpoint,
        queryParameters: {
          'CompanyId': companyId,
          'Status': status,
        },
      );

      debugPrint("✅ Invitations response received");

      // الـ Response عبارة عن List مباشرة بحسب الصورة
      if (response is List) {
        return response
            .map((item) => InvitationStatusModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else if (response['result'] is List) {
        // خطوة إضافية لو الـ ApiService بيغلف البيانات في كبسولة 'result'
        return (response['result'] as List)
            .map((item) => InvitationStatusModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      debugPrint('❌ Error fetching invitations by status: $e');
      rethrow;
    }
  }
  Future<void> createInvite({required String email}) async {
    try {
      const endpoint = '/api/Invitation/createInvitation'; // عدل الـ path لو اسم الـ endpoint مختلف عندك
      debugPrint("🚀 Sending new invitation to email: $email");

      final response = await _apiService.post(
        endpoint,
      {
          'email': email,
        "reciverRole": "employee"
        },
      );

      debugPrint("✅ Invitation sent successfully to $email");
    } catch (e) {
      debugPrint('❌ Error creating invitation: $e');
      rethrow;
    }
  }
}