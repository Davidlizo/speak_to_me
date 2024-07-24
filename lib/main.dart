import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'featured/speech_to_text/pages/speech_home_screen.dart';
import 'featured/speech_to_text/pages/speech_list_screen.dart';

void main() {
  runApp(const SpeakToMe());
}

class SpeakToMe extends StatelessWidget {
  const SpeakToMe({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SpeechHomeScreen()),
        GetPage(name: '/words', page: () => SpeechListScreen()),
      ],
    );
  }
}
