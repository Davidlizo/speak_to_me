import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/speech_controller.dart';
import 'speech_list_screen.dart';

class SpeechHomeScreen extends StatelessWidget {
  final SpeechController _controller = Get.put(SpeechController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 184, 180, 233),
        title: Text(
          'Speak To Me',
          style: GoogleFonts.quicksand(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Get.to(() => SpeechListScreen());
            },
          )
        ],
      ),
      body: Column(
        children: [
          Obx(
            () => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 35.0),
              child: Container(
                height: 230,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Text(
                    'Recognized Word:  ${_controller.speech.value}',
                    style: GoogleFonts.lato(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                if (_controller.isListening.value) {
                  _controller.stopListening();
                } else {
                  _controller.startListening();
                }
              },
              child: Obx(() {
                return Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(130),
                    color: const Color.fromARGB(255, 184, 180, 233),
                  ),
                  child: Center(
                    child: _controller.isListening.value
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/gif/listening.gif',
                              ),
                              Text(
                                'Listening...',
                                style: GoogleFonts.quicksand(
                                  //color: const Color.fromARGB(255, 184, 180, 233),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'Tap To Speak',
                            style: GoogleFonts.quicksand(
                              //color: const Color.fromARGB(255, 184, 180, 233),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
