import 'dart:convert';
import 'dart:io';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioService {
  static final AudioService instance = AudioService._init();

  AudioService._init();

  late File audioFile;
  final AudioPlayer player = AudioPlayer();
  late AudioRecorder record;

  Future<void> initialise(String base64Audio) async {
    audioFile = await writeBytesToFile(base64Audio, 'tempAudio.mp3');
  }

  Future<void> initialiseRecord() async {
    record = AudioRecorder();
  }

  Future<File> writeBytesToFile(String base64String, String fileName) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File('${dir.path}/$fileName');

    // Decode base64 string and write to file
    await file.writeAsBytes(base64Decode(base64String));

    return file;
  }

  Future<void> playAudioFromFile(File audioFile) async {
    await player.setFilePath(audioFile.path);
    player.play();
  }

  Future<void> playAudioFromBase64() async {
    // Convert the base64 string to a file

    // Play the audio file
    await playAudioFromFile(audioFile);

    // Optionally, delete the file after playing if it's no longer needed
    await audioFile.delete();
  }

  Future<void> stopAudio() async {
    await player.stop();
    await player.dispose();
  }

  Future<void> startRecord() async {
    // Check and request permission if needed
    if (await record.hasPermission()) {
      Directory directory = await getApplicationCacheDirectory();
      await record.start(
        const RecordConfig(),
        path: '${directory.path}/record.m4a',
      );
    }
  }

  Future<String> fileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  Future<String?> stopRecord() async {
    final path = await record.stop();
    record.dispose();
    if (path == null) return null;
    return await fileToBase64(File(path));
  }
}

