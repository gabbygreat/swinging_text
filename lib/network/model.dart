import 'package:learn/enums/enum.dart';

class Translation {
  final String? translatedText;
  final String? recognizedText;
  final TongueServices tongueServices;
  final String? translatedAudio;

  Translation({
    this.translatedText,
    this.recognizedText,
    required this.tongueServices,
    required this.translatedAudio,
  });

  // Factory constructor for creating a new Translation instance from a map.
  factory Translation.fromJson(
    Map<String, dynamic> json,
    TongueServices tongue,
  ) {
    return Translation(
      translatedText: json['translatedText'],
      recognizedText: json['recognizedText'],
      tongueServices: tongue,
      translatedAudio: json['translatedAudio'],
    );
  }
}

class ServiceRequest {
  bool isLoading;
  Translation? translation;

  ServiceRequest({
    this.isLoading = false,
    this.translation,
  });
}
