class HomeBusinessModel {
  final String? id;

  final String? logo;

  final String? name;
  HomeBusinessModel({this.id, this.logo, this.name});

  factory HomeBusinessModel.fromJson(Map<String, dynamic> json) {
    return HomeBusinessModel(
      id: json['_id'],

      logo: json['logo'],

      name: json['name'],
    );
  }
}
