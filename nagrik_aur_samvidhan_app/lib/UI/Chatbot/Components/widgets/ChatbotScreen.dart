import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nagrik_aur_samvidhan_app/Elements/Widgets/spaces.dart';
import '../../../../Values/values.dart';
import '../../Controller/chatbotScreenController.dart';

class Chatbot_Screen extends StatelessWidget {
  final ChatbotScreenController _controller = Get.put(ChatbotScreenController());

  Chatbot_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset('assets/ChatBot/arrow.png'),
          ),
        ),
        title: Text('',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              padding: EdgeInsets.all(8),
              width: Sizes.WIDTH_120,
              decoration: BoxDecoration(
                color: MyColor.black,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Text(
                    MyString.newChat.tr,
                    style: TextStyle(color: MyColor.white),
                  ),
                  SpaceW4(),
                  Icon(
                    Icons.add,
                    color: MyColor.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _controller.messages.length,
              itemBuilder: (context, index) {
                return _buildMessageItem(_controller.messages[index]);
              },
            )),
          ),
          Obx(() => _controller.isLoading.value
              ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          )
              : SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildMessageInput(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(String message) {
    return Align(
      alignment: message.startsWith(MyString.response.tr)
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.startsWith(MyString.response.tr)
              ? Color(0xFF00712D).withOpacity(0.4)
              : Color(0xFFFF9100).withOpacity(0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    TextEditingController _textController = TextEditingController();
    return Container(
      padding: EdgeInsets.all(8),
      height: Sizes.HEIGHT_60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: TextField(
                autocorrect: true,
                controller: _textController,
                maxLines: null,
                cursorColor: Colors.black,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  hoverColor: Colors.grey,
                  hintText: MyString.message.tr,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black),
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_textController.text.trim().isNotEmpty) {
                _controller.sendMessage(_textController.text.trim());
                _textController.clear();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/ChatBot/right.png',
                height: 30,
                width: 30,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}