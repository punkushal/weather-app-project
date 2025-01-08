//positon: 2nd to create file
class WeatherModel {
  final String location;
  final double tempC;
  final String condition;
  final String iconUrl;

  WeatherModel({
    required this.location,
    required this.tempC,
    required this.condition,
    required this.iconUrl,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json['location']['name'],
      tempC: json['current']['temp_c'].toDouble(),
      condition: json['current']['condition']['text'],
      iconUrl: 'https:${json['current']['condition']['icon']}',
    );
  }
}
