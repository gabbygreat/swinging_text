import 'package:learn/enums/enum.dart';

import 'model.dart';
import 'network.dart';

class TongueRequest extends NetworkService {
  static final TongueRequest instance = TongueRequest._init();

  TongueRequest._init();

  Future<Translation> textToSpeech({
    required String text,
    required TongueServices tongueServices,
    required String sourceLang,
    required String destLang,
  }) async {
    var path = 'api/v1/TextToSpeechTranslation';
    var data = {
      "TonguesVoiceCode": destLang,
      "SourceLangCode": sourceLang,
      "SourceText": text
    };
    var request = await postRequestHandler(path, data: data);
    return Translation.fromJson(request.data, tongueServices);
  }

  Future<Translation> speechToSpeech({
    required String text,
    required TongueServices tongueServices,
    required String sourceLang,
    required String destLang,
  }) async {
    var path = 'api/v1/SpeechToSpeechTranslation';

    var data = {
      "TonguesVoiceCode": destLang,
      "SourceLangCode": sourceLang,
      "SourceAudioContent": text,
    };
    var request = await postRequestHandler(path, data: data);
    return Translation.fromJson(request.data, tongueServices);
  }

  Future<Translation> speechToText({
    required String text,
    required TongueServices tongueServices,
    required String sourceLang,
    required String destLang,
  }) async {
    var path = 'api/v1/SpeechToTextTranslation';

    var data = {
      "TargetLangCode": destLang.split('-').first,
      "SourceLangCode": sourceLang.split('-').first,
      "SourceAudioContent": text,
    };
    var request = await postRequestHandler(path, data: data);
    return Translation.fromJson(request.data, tongueServices);
  }

  Future<Translation> speechToSpeechText({
    required String text,
    required TongueServices tongueServices,
    required String sourceLang,
    required String destLang,
  }) async {
    var path = 'api/v1/SpeechToSpeechTextTranslation';

    var data = {
      "TonguesVoiceCode": destLang,
      "SourceLangCode": sourceLang,
      "SourceAudioContent": text,
    };
    var request = await postRequestHandler(path, data: data);
    return Translation.fromJson(request.data, tongueServices);
  }
}
