class SwitchResponseModel {
  final String? message;
  final String? token;

  SwitchResponseModel({this.message, this.token});

  factory SwitchResponseModel.fromJson(Map<String, dynamic> json) {
    return SwitchResponseModel(
      message: json['message'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'token': token};
  }
}
