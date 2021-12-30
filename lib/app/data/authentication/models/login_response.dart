class LoginResponse {
  LoginResponse({
    this.error,
    this.msg,
    this.user,
  });

  bool? error;
  String? msg;
  User? user;

  LoginResponse copyWith({
    bool? error,
    String? msg,
    String? email,
    String? nameComplete,
    User? user,
  }) =>
      LoginResponse(
        error: error ?? this.error,
        msg: msg ?? this.msg,
        user: user ?? this.user,
      );

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        error: json["error"],
        msg: json["msg"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "msg": msg,
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.tokenExternal,
    this.createdAt,
    this.updatedAt,
    this.accessToken,
    this.expiresAt,
  });

  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? tokenExternal;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? accessToken;
  DateTime? expiresAt;

  User copyWith({
    int? id,
    String? name,
    String? email,
    dynamic emailVerifiedAt,
    String? tokenExternal,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? accessToken,
    DateTime? expiresAt,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        tokenExternal: tokenExternal ?? this.tokenExternal,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        accessToken: accessToken ?? this.accessToken,
        expiresAt: expiresAt ?? this.expiresAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        tokenExternal: json["token_external"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        accessToken: json["access_token"],
        expiresAt: DateTime.parse(json["expires_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "token_external": tokenExternal,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "access_token": accessToken,
        "expires_at": expiresAt!.toIso8601String(),
      };
}
