import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:convert';

class SpeechController extends GetxController {
  var speech = ''.obs;
  var words = <Map<String, dynamic>>[].obs; // List to store words with their IDs
  var filteredWords = <Map<String, dynamic>>[].obs;
  late stt.SpeechToText _speech;
  var isListening = false.obs;
  var wordId = 1; // ID counter for words

  @override
  void onInit() {
    super.onInit();
    _speech = stt.SpeechToText();
    loadWords(); // Load words from local storage on initialization
  }

  void setSpeechToText(stt.SpeechToText speechToText) {
    _speech = speechToText;
  }

  void startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      isListening.value = true;
      _speech.listen(onResult: (val) {
        speech.value = val.recognizedWords;
        if (val.finalResult) {
          words.add({'id': wordId++, 'word': val.recognizedWords});
          saveWords(); // Save words to local storage after adding a new word
          filterWords('');
        }
      });
    }
  }

  void stopListening() {
    _speech.stop();
    isListening.value = false;
  }

  void filterWords(String query) {
    if (query.isEmpty) {
      filteredWords.value = words;
    } else {
      filteredWords.value = words.where((entry) {
        final word = entry['word'] as String;
        final id = entry['id'].toString();
        return word.contains(query) || id.contains(query);
      }).toList();
    }
  }

  Future<void> saveWords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(words);
    await prefs.setString('words', jsonString);
  }

  Future<void> loadWords() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString('words');
  if (jsonString != null) {
    List<dynamic> jsonResponse = jsonDecode(jsonString);
    words.value = jsonResponse.map((e) => e as Map<String, dynamic>).toList();
    filteredWords.value = List.from(words); // Initialize filteredWords with all words
    if (words.isNotEmpty) {
      wordId = words.last['id'] + 1; // Update wordId to the next available ID
    }
  }
}
}
