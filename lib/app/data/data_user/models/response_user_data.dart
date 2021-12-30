class ResponseRegisterUserData {
  ResponseRegisterUserData({
    this.message,
    this.success,
  });

  String? message;
  bool? success;

  ResponseRegisterUserData copyWith({
    String? message,
    bool? success,
  }) =>
      ResponseRegisterUserData(
        message: message ?? this.message,
        success: success ?? this.success,
      );

  factory ResponseRegisterUserData.fromJson(Map<String, dynamic> json) =>
      ResponseRegisterUserData(
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
      };
}
