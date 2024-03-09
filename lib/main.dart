import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn/enums/enum.dart';
import 'package:learn/extension/string_extension.dart';
import 'package:learn/network/controller.dart';
import 'package:learn/network/logic.dart';
import 'package:learn/network/model.dart';
import 'package:learn/network/request.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const TestApp(),
    );
  }
}

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> with TickerProviderStateMixin {
  var serviceList = TongueServices.values;
  var service = ValueNotifier(TongueServices.textToSpeech);

  late TextEditingController textEditingController;

  ValueNotifier<ServiceRequest> translation = ValueNotifier(ServiceRequest());
  String sourceLang = 'en';
  String destLang = 'fr-FR_F_Neural_D_0017';

  late AnimationController _controller;
  late AnimationController _controller2;

  late List<SourceLanguage> sourceLanguage;
  late List<DestinationLanguage> destinationLanguage;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    sourceLanguage = parseLanguages(sourceLanguages);
    destinationLanguage = [
      DestinationLanguage(
        languageCode: 'en-US_F_Neural_B_0003',
        name: 'English',
      ),
      DestinationLanguage(
        languageCode: 'fr-FR_F_Neural_D_0017',
        name: 'French',
      ),
      DestinationLanguage(
        languageCode: 'it-IT_F_Neural_D_0009',
        name: 'Italian',
      ),
      DestinationLanguage(
        languageCode: 'es-MX_F_Neural_B_0003',
        name: 'Spanish',
      ),
      DestinationLanguage(
        languageCode: 'hi-IN_M_Standard_D_0005',
        name: 'India',
      ),
    ];
  }

  void makeRequest() {
    translation.value = ServiceRequest(isLoading: true);
    late Future<Translation> Function({
      required String text,
      required TongueServices tongueServices,
      required String sourceLang,
      required String destLang,
    }) request;

    switch (service.value) {
      case TongueServices.textToSpeech:
        request = TongueRequest.instance.textToSpeech;
        break;
      case TongueServices.speechToSpeech:
        request = TongueRequest.instance.speechToSpeech;
        break;
      case TongueServices.speechToText:
        request = TongueRequest.instance.speechToText;
        break;
      case TongueServices.speechToSpeechText:
        request = TongueRequest.instance.speechToSpeechText;
        break;
      default:
    }
    request(
      text: textEditingController.text,
      tongueServices: service.value,
      sourceLang: sourceLang,
      destLang: destLang,
    )
        .then((value) => translation.value =
            ServiceRequest(isLoading: false, translation: value))
        .catchError((error) {
      translation.value = ServiceRequest(isLoading: false);
      listenError(error: error, context: context);
      return translation.value;
    });
  }

  Future<void> playAudio() async {
    if (translation.value.translation!.translatedAudio != null) {
      await AudioService.instance.initialise(
        translation.value.translation!.translatedAudio!,
      );
      _controller.forward();
      await AudioService.instance.playAudioFromBase64();
      _controller.reverse();
    }
  }

  void stopAudio() async {
    _controller.reverse();
    await AudioService.instance.stopAudio();
  }

  Future<void> recordVoice() async {
    textEditingController.clear();
    translation.value = ServiceRequest();
    setState(() {});
    await AudioService.instance.initialiseRecord();
    _controller2.forward();
    await AudioService.instance.startRecord();
  }

  void stopRecord() async {
    _controller2.reverse();
    var base64 = await AudioService.instance.stopRecord();
    if (base64 == null) return;
    log(base64);
    textEditingController.text = base64;
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    translation.dispose();
    service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tongues API'),
      ),
      body: ValueListenableBuilder(
        valueListenable: service,
        builder: (context, currentService, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'Source',
                            ),
                            DropdownMenu(
                              width: MediaQuery.sizeOf(context).width * 0.42,
                              initialSelection: 'en',
                              onSelected: (value) =>
                                  sourceLang = value ?? sourceLang,
                              dropdownMenuEntries: sourceLanguage
                                  .map(
                                    (e) => DropdownMenuEntry(
                                        value: e.languageCode, label: e.name),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'Destination',
                            ),
                            DropdownMenu(
                              initialSelection: 'fr-FR_F_Neural_D_0017',
                              width: MediaQuery.sizeOf(context).width * 0.42,
                              onSelected: (value) =>
                                  destLang = value ?? sourceLang,
                              dropdownMenuEntries: destinationLanguage
                                  .map(
                                    (e) => DropdownMenuEntry(
                                        value: e.languageCode, label: e.name),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: serviceList
                    .map(
                      (e) => CheckboxListTile(
                        value: e == currentService,
                        title: Text(e.name.toCamelCaseSpace),
                        onChanged: (value) {
                          service.value = e;
                          textEditingController.clear();
                          translation.value = ServiceRequest();
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  currentService.name.toCamelCaseSpace,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: translation,
                    builder: (context, trans, _) {
                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        children: [
                          if (currentService ==
                              TongueServices.textToSpeech) ...[
                            TextField(
                              controller: textEditingController,
                              maxLines: 3,
                              minLines: 1,
                              onChanged: (value) => setState(() {}),
                              decoration: const InputDecoration(
                                hintText: 'Enter the sentence to convert',
                              ),
                            ),
                          ] else if ([
                                TongueServices.speechToSpeechText,
                                TongueServices.speechToSpeech,
                                TongueServices.speechToText
                              ].contains(currentService) &&
                              !trans.isLoading) ...[
                            CircleAvatar(
                              child: GestureDetector(
                                onTap: () {
                                  if (_controller2.isDismissed) {
                                    recordVoice();
                                  } else {
                                    stopRecord();
                                  }
                                },
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.menu_arrow,
                                  progress: _controller2,
                                ),
                              ),
                            )
                          ],
                          const SizedBox(
                            height: 10,
                          ),
                          Builder(
                            builder: (context) {
                              if (trans.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              } else if (trans.translation != null) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (currentService ==
                                          TongueServices.textToSpeech)
                                        Text(
                                          trans.translation!.translatedText!,
                                        ),
                                      if (currentService ==
                                          TongueServices.speechToSpeech)
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: 'Recognized Text:\n',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${trans.translation!.recognizedText} ',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      if ([
                                        TongueServices.speechToText,
                                        TongueServices.speechToSpeechText,
                                      ].contains(currentService))
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text:
                                                          'Recognized Text:\n',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${trans.translation!.recognizedText}',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text:
                                                          'Translated Text:\n',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${trans.translation!.translatedText}',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if ([
                                        TongueServices.speechToSpeech,
                                        TongueServices.textToSpeech,
                                        TongueServices.speechToSpeechText,
                                      ].contains(currentService))
                                        CircleAvatar(
                                          child: GestureDetector(
                                            onTap: () {
                                              if (_controller.isDismissed) {
                                                playAudio();
                                              } else {
                                                stopAudio();
                                              }
                                            },
                                            child: AnimatedIcon(
                                              icon: AnimatedIcons.play_pause,
                                              progress: _controller,
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          ElevatedButton(
                            onPressed: textEditingController.text.isNotEmpty
                                ? makeRequest
                                : null,
                            child: const Text('Convert'),
                          )
                        ],
                      );
                    }),
              )
            ],
          );
        },
      ),
    );
  }
}
