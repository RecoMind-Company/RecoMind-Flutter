class MappingReviewModel {
  final int? id;
  final String? name;
  final String? description;

  MappingReviewModel({this.id, this.name, this.description});

  factory MappingReviewModel.fromJson(Map<String, dynamic> json) {
    return MappingReviewModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

class AvailableTableModel {
  final int? id;
  final String? name;
  final String? description;

  AvailableTableModel({
    this.id,
    this.name,
    this.description,
  });

  // تحويل الـ JSON القادم من السيرفر إلى Object
  factory AvailableTableModel.fromJson(Map<String, dynamic> json) {
    return AvailableTableModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
    );
  }

  // تحويل الـ Object إلى JSON لزوم الـ POST request
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  /// هيلبر مخصص لاستخراج الـ Schema أو تصنيف الجدول ديناميكياً للـ Tabs
  String get schemaCategory {
    if (name != null && name!.contains('.')) {
      return name!.split('.').first;
    }
    return "dbo";
  }
}