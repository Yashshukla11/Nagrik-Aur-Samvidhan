import 'package:flutter_tts/flutter_tts.dart';

class ImprovedTTS {
  late FlutterTts flutterTts;

  ImprovedTTS() {
    _initTts();
  }

  Future<void> _initTts() async {
    flutterTts = FlutterTts();

    // Set callbacks for TTS events
    flutterTts.setStartHandler(() {
      print("TTS Speaking Started");
    });

    flutterTts.setCompletionHandler(() {
      print("TTS Speaking Completed");
    });

    flutterTts.setErrorHandler((msg) {
      print("TTS Error: $msg");
    });

    // Default pitch and speech rate for clarity
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
  }

  Future<void> setLanguage(String languageCode) async {
    // Set the desired language for TTS
    var result = await flutterTts.setLanguage(languageCode);
    print('Set Language Result: $result'); // Debugging statement

    if (result == 1) {
      // Automatically set the voice matching the language
      List<dynamic> voices = await flutterTts.getVoices;
      for (var voice in voices) {
        if (voice['locale'] == languageCode) {
          await flutterTts.setVoice(voice);
          print(
              'Voice set to: ${voice['name']} for language: $languageCode'); // Debugging statement
          break;
        }
      }
    } else {
      print('Failed to set language: $languageCode'); // Debugging statement
    }
  }

  String _preprocessText(String text, String languageCode) {
    // Dynamic text preprocessing based on the language selected
    switch (languageCode) {
      case 'hi-IN': // Hindi
        return text.replaceAll(
            RegExp(r'[^\u0900-\u097F\s]'), ''); // Keep only Hindi characters
      case 'kn-IN': // Kannada
        return text.replaceAll(
            RegExp(r'[^\u0C80-\u0CFF\s]'), ''); // Keep only Kannada characters
      case 'ta-IN': // Tamil
        return text.replaceAll(
            RegExp(r'[^\u0B80-\u0BFF\s]'), ''); // Keep only Tamil characters
      case 'te-IN': // Telugu
        return text.replaceAll(
            RegExp(r'[^\u0C00-\u0C7F\s]'), ''); // Keep only Telugu characters
      case 'ml-IN': // Malayalam
        return text.replaceAll(RegExp(r'[^\u0D00-\u0D7F\s]'),
            ''); // Keep only Malayalam characters
      case 'gu-IN': // Gujarati
        return text.replaceAll(
            RegExp(r'[^\u0A80-\u0AFF\s]'), ''); // Keep only Gujarati characters
      case 'mr-IN': // Marathi
        return text.replaceAll(RegExp(r'[^\u0900-\u097F\s]'),
            ''); // Keep only Marathi characters (same range as Hindi)
      case 'bn-IN': // Bengali
        return text.replaceAll(
            RegExp(r'[^\u0980-\u09FF\s]'), ''); // Keep only Bengali characters
      // Add more languages as needed
      default:
        return text; // No filtering for unsupported languages
    }
  }

  Future<void> speak(String text, String languageCode) async {
    // Stop previous utterances if any
    await flutterTts.stop();

    // Set the language and voice dynamically
    await setLanguage(languageCode);

    // Preprocess text to remove unwanted characters
    final processedText = _preprocessText(_stripMarkdown(text), languageCode);

    print('Processed text for TTS: $processedText'); // Debugging statement

    // Speak the processed text
    var result = await flutterTts.speak(processedText);
    print('Speak Result: $result'); // Debugging statement
  }

  String _stripMarkdown(String markdownText) {
    // Simplified markdown stripping function
    markdownText = markdownText.replaceAll(RegExp(r'#{1,6}\s'), '');
    markdownText = markdownText.replaceAll(RegExp(r'\*{1,3}'), '');
    markdownText =
        markdownText.replaceAll(RegExp(r'\[([^\]]+)\]\([^\)]+\)'), r'$1');
    markdownText = markdownText.replaceAll(RegExp(r'`{1,3}[^`]+`{1,3}'), '');
    markdownText =
        markdownText.replaceAll(RegExp(r'^\s*>\s*', multiLine: true), '');
    markdownText = markdownText.replaceAll(
        RegExp(r'^\s*[-*_]{3,}\s*$', multiLine: true), '');
    markdownText = markdownText.replaceAll(RegExp(r'<[^>]*>'), '');
    return markdownText.trim();
  }
}
