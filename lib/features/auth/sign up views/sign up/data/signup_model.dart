class AuthResponse {
  final String? name;
  final String? email;
  final String? experiesOn;
  final String? token;
  final bool isAuthenticated;
  final List<String> roles;
  final String? photoUrl;
  final String? message;
  final String? refreshTokenExp;
  final String? Password;

  AuthResponse({
    this.name,
    this.email,
    this.experiesOn,
    this.token,
    required this.isAuthenticated,
    required this.roles,
    this.photoUrl,
    this.message,
    this.refreshTokenExp,
    this.Password
  });

  // ---------- FROM JSON ----------
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      name: json['FullName'],
      email: json['email'],
      experiesOn: json['experiesOn'],
      token: json['token'],
      isAuthenticated: json['isAuthenticated'] ?? false,
      roles: json['roles'] != null && json['roles'].isNotEmpty
          ? List<String>.from(json['roles'])
          : ["admin"],
      photoUrl: json['photoUrl'],
      message: json['message'],
      refreshTokenExp: json['refreshTokenExp'],
      Password: json['password'],
    );
  }

  // ---------- TO JSON ----------
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "experiesOn": experiesOn,
      "token": token,
      "isAuthenticated": isAuthenticated,
      "roles": roles,
      "photoUrl": photoUrl,
      "message": message,
      "refreshTokenExp": refreshTokenExp,
      "password": Password
    };
  }

  // ---------- COPY WITH ----------
  AuthResponse copyWith({
    String? name,
    String? email,
    String? experiesOn,
    String? token,
    bool? isAuthenticated,
    List<String>? roles,
    String? photoUrl,
    String? message,
    String? refreshTokenExp,
  }) {
    return AuthResponse(
      name: name ?? this.name,
      email: email ?? this.email,
      experiesOn: experiesOn ?? this.experiesOn,
      token: token ?? this.token,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      roles: roles ?? this.roles,
      photoUrl: photoUrl ?? this.photoUrl,
      message: message ?? this.message,
      refreshTokenExp: refreshTokenExp ?? this.refreshTokenExp,
      Password: Password ?? this.Password
    );
  }
}
