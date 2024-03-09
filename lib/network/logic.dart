import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void listenError({
  required Object error,
  void Function()? perform,
  required BuildContext context,
}) {
  if (error is DioException) {
    if (error.response != null && error.response?.data is Map) {
      var err = error.response?.data as Map;

      var message = 'Something went wrong';
      if (err.containsKey('message')) {
        message = err['message'];
      } else if (err.containsKey('title')) {
        message = err['title'];
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error from Dio'),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error'),
      ),
    );
  }
}

var sourceLanguages = {
  "Afrikaans": {"nativeLanguage": "Afrikaans", "languageCode": "af"},
  "Akan": {"nativeLanguage": "Twi", "languageCode": "ak"},
  "Amharic": {"nativeLanguage": "አማርኛ", "languageCode": "am"},
  "Arabic": {"nativeLanguage": "عربى", "languageCode": "ar"},
  "Armenian": {"nativeLanguage": "Հայերեն", "languageCode": "hy"},
  "Assamese": {"nativeLanguage": "অসমীয়া", "languageCode": "as"},
  "Aymara": {"nativeLanguage": "Aymar aru", "languageCode": "ay"},
  "Azerbaijani": {"nativeLanguage": "Azərbaycan", "languageCode": "az"},
  "Balochi (Southern)": {"nativeLanguage": "بلۏچی", "languageCode": "bcc"},
  "Bambara": {"nativeLanguage": "ߓߡߊߣߊ߲", "languageCode": "bm"},
  "Bashkir": {"nativeLanguage": "Башҡорт", "languageCode": "ba"},
  "Basque": {"nativeLanguage": "Euskal", "languageCode": "eu"},
  "Belarusian": {"nativeLanguage": "Беларус", "languageCode": "be"},
  "Bengali": {"nativeLanguage": "বাংলা", "languageCode": "bn"},
  "Bihari": {"nativeLanguage": "Bhojpuri", "languageCode": "bh"},
  "Bislama": {"nativeLanguage": "Bichelamar", "languageCode": "bi"},
  "Bosnian": {"nativeLanguage": "Bosanski", "languageCode": "bs"},
  "Breton": {"nativeLanguage": "Brezhoneg", "languageCode": "br"},
  "Bulgarian": {"nativeLanguage": "български", "languageCode": "bg"},
  "Cantonese (Traditional)": {"nativeLanguage": "廣東話", "languageCode": "yue"},
  "Catalan": {"nativeLanguage": "Català", "languageCode": "ca"},
  "Cebuano": {"nativeLanguage": "Cebuano", "languageCode": "ceb"},
  "Chamorro": {"nativeLanguage": "Finuʼ Chamoru", "languageCode": "ch"},
  "Chechen": {"nativeLanguage": "нохчийн мотт", "languageCode": "ce"},
  "Chinese (Simplified)": {"nativeLanguage": "简体中文", "languageCode": "zh"},
  "Chinese (Traditional)": {"nativeLanguage": "中國傳統的", "languageCode": "zh-tw"},
  "Chuvash": {"nativeLanguage": "Căvašla", "languageCode": "cv"},
  "Corsican": {"nativeLanguage": "Corsu", "languageCode": "co"},
  "Croatian": {"nativeLanguage": "Hrvatski", "languageCode": "hr"},
  "Czech": {"nativeLanguage": "Čeština", "languageCode": "cs"},
  "Dagbani": {"nativeLanguage": "Dagbani", "languageCode": "dag"},
  "Danish": {"nativeLanguage": "Dansk", "languageCode": "da"},
  "Divehi": {"nativeLanguage": "ދިވެހި", "languageCode": "dv"},
  "Dogri": {"nativeLanguage": "डोगरी", "languageCode": "doi"},
  "Dutch": {"nativeLanguage": "Nederlands", "languageCode": "nl"},
  "Dzongkha": {"nativeLanguage": "Bhutanese", "languageCode": "dz"},
  "English": {"nativeLanguage": "English", "languageCode": "en"},
  "Esperanto": {"nativeLanguage": "Esperanto", "languageCode": "eo"},
  "Estonian": {"nativeLanguage": "Eestlane", "languageCode": "et"},
  "Ewe": {"nativeLanguage": "Eʋe", "languageCode": "ee"},
  "Faroese": {"nativeLanguage": "Føroyskt mál", "languageCode": "fo"},
  "Fijian": {"nativeLanguage": "Kai-Viti", "languageCode": "fj"},
  "Filipino": {"nativeLanguage": "Pilipino", "languageCode": "fil"},
  "Finnish": {"nativeLanguage": "Suomalainen", "languageCode": "fi"},
  "French": {"nativeLanguage": "Français", "languageCode": "fr"},
  "French (Canada)": {
    "nativeLanguage": "Français-Canadien",
    "languageCode": "fr-ca"
  },
  "Frisian": {"nativeLanguage": "Frysk", "languageCode": "fy"},
  "Ga": {"nativeLanguage": "Ga", "languageCode": "gaa"},
  "Galician": {"nativeLanguage": "Galego", "languageCode": "gl"},
  "Ganda": {"nativeLanguage": "Oluganda", "languageCode": "lg"},
  "Georgian": {"nativeLanguage": "ქართული", "languageCode": "ka"},
  "German": {"nativeLanguage": "Deutsch", "languageCode": "de"},
  "Greek": {"nativeLanguage": "Ελληνικά", "languageCode": "el"},
  "Guarani": {"nativeLanguage": "Avañeʼẽ", "languageCode": "gn"},
  "Gujarati": {"nativeLanguage": "ગુજરાતી", "languageCode": "gu"},
  "Haitian Creole": {"nativeLanguage": "Ayisyen", "languageCode": "ht"},
  "Hausa": {"nativeLanguage": "Hausa", "languageCode": "ha"},
  "Hawaiian": {"nativeLanguage": "Ōlelo-Hawaiʻi", "languageCode": "haw"},
  "Hebrew": {"nativeLanguage": "עברית", "languageCode": "he"},
  "Hindi": {"nativeLanguage": "हिन्दी", "languageCode": "hi"},
  "Hiri Motu": {"nativeLanguage": "Police Motu", "languageCode": "ho"},
  "Hmong": {"nativeLanguage": "Hmong", "languageCode": "hmn"},
  "Hmong Daw": {"nativeLanguage": "Miao", "languageCode": "mww"},
  "Hungarian": {"nativeLanguage": "Magyar", "languageCode": "hu"},
  "Icelandic": {"nativeLanguage": "Íslensku", "languageCode": "is"},
  "Igbo": {"nativeLanguage": "Ndi-Igbo", "languageCode": "ig"},
  "Ilocano": {"nativeLanguage": "Iloko nga", "languageCode": "ilo"},
  "Indonesian": {"nativeLanguage": "Orang-indonesia", "languageCode": "id"},
  "Inuktitut": {"nativeLanguage": "ᐃᓄᒃᑎᑐᑦ", "languageCode": "iu"},
  "Irish": {"nativeLanguage": "Gaeilge", "languageCode": "ga"},
  "Italian": {"nativeLanguage": "Italiano", "languageCode": "it"},
  "Japanese": {"nativeLanguage": "日本語", "languageCode": "ja"},
  "Javanese": {"nativeLanguage": "Basa-Jawa", "languageCode": "jv"},
  "Kannada": {"nativeLanguage": "ಕನ್ನಡ", "languageCode": "kn"},
  "Kazakh": {"nativeLanguage": "Қазақ", "languageCode": "kk"},
  "Khmer": {"nativeLanguage": "ខ្មែរ", "languageCode": "km"},
  "Kinyarwanda": {"nativeLanguage": "Kinyarwanda", "languageCode": "rw"},
  "Kirundi": {"nativeLanguage": "Rundi", "languageCode": "rn"},
  "Korean": {"nativeLanguage": "한국어", "languageCode": "ko"},
  "Kurdish": {"nativeLanguage": "Kurdî", "languageCode": "ku"},
  "Kurdish (Sorani)": {
    "nativeLanguage": "کوردی ناوەڕاست",
    "languageCode": "ckb"
  },
  "Kyrgyz": {"nativeLanguage": "Кыргыз", "languageCode": "ky"},
  "Lao": {"nativeLanguage": "ລາວ", "languageCode": "lo"},
  "Latin": {"nativeLanguage": "Lingua Latīna", "languageCode": "la"},
  "Latvian": {"nativeLanguage": "Latvietis", "languageCode": "lv"},
  "Lingala": {"nativeLanguage": "lingála", "languageCode": "ln"},
  "Lithuanian": {"nativeLanguage": "Lietuvis", "languageCode": "lt"},
  "Luxembourgish": {"nativeLanguage": "Lëtzebuergesch", "languageCode": "lb"},
  "Macedonian": {"nativeLanguage": "Македонски", "languageCode": "mk"},
  "Malagasy": {"nativeLanguage": "Malagasy", "languageCode": "mg"},
  "Malay": {"nativeLanguage": "Melayu", "languageCode": "ms"},
  "Malayalam": {"nativeLanguage": "മലയാളം", "languageCode": "ml"},
  "Maltese": {"nativeLanguage": "Malti", "languageCode": "mt"},
  "Maori": {"nativeLanguage": "Te Reo", "languageCode": "mi"},
  "Marathi": {"nativeLanguage": "मराठी", "languageCode": "mr"},
  "Marshallese": {"nativeLanguage": "Kajin M̧ajeļ", "languageCode": "mh"},
  "Mongolian": {"nativeLanguage": "Монгол", "languageCode": "mn"},
  "Myanmar (Burmese)": {"nativeLanguage": "Burmese", "languageCode": "my"},
  "Nepali": {"nativeLanguage": "नेपाली", "languageCode": "ne"},
  "Norwegian": {"nativeLanguage": "Norsk", "languageCode": "no"},
  "Norwegian (Nynorsk)": {
    "nativeLanguage": "Norsk-nynorsk",
    "languageCode": "nn"
  },
  "Nyanja (Chichewa)": {"nativeLanguage": "Chewa", "languageCode": "ny"},
  "Odia (Oriya)": {"nativeLanguage": "ଓଡିଆ", "languageCode": "or"},
  "Ojibwe": {"nativeLanguage": "Ojibwa", "languageCode": "oj"},
  "Oromo": {"nativeLanguage": "Afaan Oromoo", "languageCode": "om"},
  "Pashto": {"nativeLanguage": "پښتو", "languageCode": "ps"},
  "Persian (Farsi)": {"nativeLanguage": "فارسی", "languageCode": "fa"},
  "Polish": {"nativeLanguage": "Polski", "languageCode": "pl"},
  "Portuguese": {"nativeLanguage": "Português", "languageCode": "pt"},
  "Punjabi": {"nativeLanguage": "ਪੰਜਾਬੀ", "languageCode": "pa"},
  "Quechua": {"nativeLanguage": "Kichwa", "languageCode": "qu"},
  "Romanian": {"nativeLanguage": "Română", "languageCode": "ro"},
  "Russian": {"nativeLanguage": "Русский", "languageCode": "ru"},
  "Samoan": {"nativeLanguage": "Gagana fa'a Sāmoa", "languageCode": "sm"},
  "Sanskrit": {"nativeLanguage": "संस्कृतम्", "languageCode": "sa"},
  "Scots Gaelic": {"nativeLanguage": "Gàidhlig", "languageCode": "gd"},
  "Serbian": {"nativeLanguage": "Српски", "languageCode": "sr"},
  "Sesotho": {"nativeLanguage": "Sesotho", "languageCode": "st"},
  "Shona": {"nativeLanguage": "chiShona", "languageCode": "sn"},
  "Sindhi": {"nativeLanguage": "سنڌي", "languageCode": "sd"},
  "Sinhala (Sinhalese)": {"nativeLanguage": "සිංහල", "languageCode": "si"},
  "Slovak": {"nativeLanguage": "Slovenský", "languageCode": "sk"},
  "Slovenian": {"nativeLanguage": "Slovenski", "languageCode": "sl"},
  "Somali": {"nativeLanguage": "Soomaali", "languageCode": "so"},
  "Spanish": {"nativeLanguage": "Español", "languageCode": "es"},
  "Sundanese": {"nativeLanguage": "Urang Sunda", "languageCode": "su"},
  "Swahili": {"nativeLanguage": "Kiswahili", "languageCode": "sw"},
  "Swedish": {"nativeLanguage": "Svenska", "languageCode": "sv"},
  "Tagalog (Filipino)": {"nativeLanguage": "Tagalog", "languageCode": "tl"},
  "Tajik": {"nativeLanguage": "Тоҷикӣ", "languageCode": "tg"},
  "Tamil": {"nativeLanguage": "தமிழ்", "languageCode": "ta"},
  "Tatar": {"nativeLanguage": "Tatarça", "languageCode": "tt"},
  "Telugu": {"nativeLanguage": "తెలుగు", "languageCode": "te"},
  "Thai": {"nativeLanguage": "ไทย", "languageCode": "th"},
  "Tibetan": {"nativeLanguage": "བོད་སྐད", "languageCode": "bo"},
  "Tigrinya": {"nativeLanguage": "ትግርኛ", "languageCode": "ti"},
  "Tongan": {"nativeLanguage": "Lea fakatonga", "languageCode": "to"},
  "Turkish": {"nativeLanguage": "Türkçe", "languageCode": "tr"},
  "Turkmen": {"nativeLanguage": "Türkmençe", "languageCode": "tk"},
  "Ukrainian": {"nativeLanguage": "Українська", "languageCode": "uk"},
  "Urdu": {"nativeLanguage": "اردو", "languageCode": "ur"},
  "Uyghur": {"nativeLanguage": "ئۇيغۇرچە", "languageCode": "ug"},
  "Uzbek": {"nativeLanguage": "O‘zbek", "languageCode": "uz"},
  "Vietnamese": {"nativeLanguage": "Tiếng Việt", "languageCode": "vi"},
  "Welsh": {"nativeLanguage": "Cymraeg", "languageCode": "cy"},
  "Xhosa": {"nativeLanguage": "isiXhosa", "languageCode": "xh"},
  "Yiddish": {"nativeLanguage": "ייִדיש", "languageCode": "yi"},
  "Yoruba": {"nativeLanguage": "Yorùbá", "languageCode": "yo"},
  "Zulu": {"nativeLanguage": "isiZulu", "languageCode": "zu"}
};

class SourceLanguage {
  final String name;
  final String nativeLanguage;
  final String languageCode;

  SourceLanguage({
    required this.name,
    required this.nativeLanguage,
    required this.languageCode,
  });

  @override
  String toString() {
    return 'Source Language{name: $name, nativeLanguage: $nativeLanguage, languageCode: $languageCode}';
  }
}

class DestinationLanguage {
  final String name;
  final String languageCode;

  DestinationLanguage({
    required this.name,
    required this.languageCode,
  });

  @override
  String toString() {
    return 'Destination Language{name: $name, languageCode: $languageCode}';
  }
}

List<SourceLanguage> parseLanguages(Map<String, dynamic> source) {
  return source.entries.map((entry) {
    return SourceLanguage(
      name: entry.key,
      nativeLanguage: entry.value['nativeLanguage'],
      languageCode: entry.value['languageCode'],
    );
  }).toList();
}
