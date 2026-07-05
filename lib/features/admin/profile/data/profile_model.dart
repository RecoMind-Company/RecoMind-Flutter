import 'dart:io';

/// get profile
class UserProfileModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String jobTitle;
  final String photo;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.jobTitle,
    required this.photo,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      jobTitle: json['jobTitle']?.toString() ?? '',
      photo: json['photo']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'jobTitle': jobTitle,
      'photo': photo,
    };
  }
}
///update profile

class UpdateProfileRequest {
  final String name;
  final String email;
  final String phone;
  final String jobTitle;
  final File? photo;

  UpdateProfileRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.jobTitle,
    this.photo,
  });
}