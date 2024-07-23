import 'package:flutter_test/flutter_test.dart';
import 'package:speak_to_me/featured/speech_to_text/controllers/speech_controller.dart';

void main() {
  
  group('SpeechController Tests', () {
    test('Initial words list should be empty', () {
      final controller = SpeechController();
      expect(controller.words.length, 0);
    });

    test('Adding a word updates the list with correct ID', () {
      final controller = SpeechController();
      controller.words.add({'id': 1, 'word': 'test'});
      expect(controller.words.length, 1);
      expect(controller.words[0]['id'], 1);
      expect(controller.words[0]['word'], 'test');
    });

    test('Filter words by query matches both word and ID', () {
      final controller = SpeechController();
      controller.words.add({'id': 1, 'word': 'hello'});
      controller.words.add({'id': 2, 'word': 'world'});
      controller.filterWords('1');
      expect(controller.filteredWords.length, 1);
      expect(controller.filteredWords[0]['id'], 1);
      expect(controller.filteredWords[0]['word'], 'hello');

      controller.filterWords('world');
      expect(controller.filteredWords.length, 1);
      expect(controller.filteredWords[0]['id'], 2);
      expect(controller.filteredWords[0]['word'], 'world');
    });

    test('Filter words returns all words when query is empty', () {
      final controller = SpeechController();
      controller.words.add({'id': 1, 'word': 'hello'});
      controller.words.add({'id': 2, 'word': 'world'});
      controller.filterWords('');
      expect(controller.filteredWords.length, 2);
    });
  });
}
