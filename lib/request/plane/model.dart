class AirlineModel {
  final String country;
  final String logo;
  final String slogan;

  AirlineModel({
    required this.country,
    required this.logo,
    required this.slogan,
  });

  static AirlineModel fromJson(Map<String, dynamic> data) => AirlineModel(
        country: data['country'],
        logo: data['logo'],
        slogan: data['slogan'],
      );
}

class AirPlaneModel {
  final String id;
  final String name;
  final AirlineModel airlineModel;
  AirPlaneModel(
      {required this.airlineModel, required this.id, required this.name});

  static AirPlaneModel fromJson(Map<String, dynamic> data) => AirPlaneModel(
        id: data['_id'],
        name: data['name'],
        airlineModel: AirlineModel.fromJson(data['airline'][0]),
      );
}
