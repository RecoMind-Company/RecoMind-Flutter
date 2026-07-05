import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/auth/sign%20up%20views/plan%20&%20complete/data/sub_Model.dart';

class SubscriptionRepository {
  final ApiServicepublic _apiService = ApiServicepublic();

  /// جلب جميع الاشتراكات من المسار: /api/Subscription/GetAll
  Future<List<SubscriptionModel>> getAllSubscriptions() async {
    try {
      final response = await _apiService.get('/api/Subscription/GetAll');

      // تحويل الـ Response إلى قائمة من SubscriptionModel
      return (response as List)
          .map((item) => SubscriptionModel.fromJson(item))
          .toList();
    } catch (e) {
      // يمكنك هنا معالجة الأخطاء أو استخدام ApiException الخاص بك
      throw Exception("Failed to load subscriptions: $e");
    }
  }
  // في ملف subscription_repo.dart
  Future<void> assignSubscription(String subscriptionId) async {
    try {
      // المسار من صورة image_cfcd5d.png
      await _apiService.put('/api/Companies/AssignSubscription', {
        "subscriptionId": subscriptionId,
      });
    } catch (e) {
      throw Exception("Failed to assign subscription: $e");
    }
  }
}