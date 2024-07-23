import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/speech_controller.dart';

class SpeechListScreen extends StatelessWidget {
  final SpeechController _controller = Get.find<SpeechController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 184, 180, 233),
        title: Text(
          'List Of Words',
          style: GoogleFonts.quicksand(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              enableSuggestions: true,
              autocorrect: true,
              autofocus: true,
              onChanged: (value) => _controller.filterWords(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: _controller.filteredWords.length,
                itemBuilder: (context, index) {
                  final wordEntry = _controller.filteredWords[index];
                  return ListTile(
                    title: Text('${wordEntry['id']}. ${wordEntry['word']}.'),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
