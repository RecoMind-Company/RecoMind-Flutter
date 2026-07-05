class SubscriptionModel {
  final String id;
  final String billingCycle;
  final String subscriptionTypeName;
  final String planName;
  final double price;
  final String startDate;
  final String endDate;
  final bool isActive;

  SubscriptionModel({
    required this.id,
    required this.billingCycle,
    required this.subscriptionTypeName,
    required this.planName,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'],
      billingCycle: json['billingCycle'],
      subscriptionTypeName: json['subscriptionTypeName'],
      planName: json['planName'],
      // التأكد من تحويل السعر إلى double
      price: (json['price'] as num).toDouble(),
      startDate: json['startDate'],
      endDate: json['endDate'],
      isActive: json['isActive'],
    );
  }
}