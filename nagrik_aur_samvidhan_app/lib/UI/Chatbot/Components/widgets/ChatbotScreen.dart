import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nagrik_aur_samvidhan_app/Elements/Widgets/spaces.dart';
import '../../../../Values/values.dart';
import '../../Controller/chatbotScreenController.dart';

class Chatbot_Screen extends StatelessWidget {
  final ChatbotScreenController _controller = Get.put(ChatbotScreenController());

  // ScrollController to handle auto-scroll
  final ScrollController _scrollController = ScrollController();

  Chatbot_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC), // Off-white or parchment color
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          _controller.type == 'ConstitutionalBot'
              ? "Constitutional Bot"
              : "Educational Bot",
          style: GoogleFonts.merriweather(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18, // Increased font size for title
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              width: Sizes.WIDTH_120,
              decoration: BoxDecoration(
                color: MyColor.red,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: GestureDetector(
                onTap: () {
                  _controller.clearMessages();
                  Get.snackbar(
                    'New Chat',
                    _controller.type.value == 'ConstitutionalBot'
                        ? "Ready to help you on legal matters"
                        : "Ready to help you on general/educational matters",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.black,
                    colorText: Colors.white,
                    animationDuration: const Duration(milliseconds: 500),
                    duration: const Duration(seconds: 1),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.gavel, color: MyColor.white),
                    SpaceW4(),
                    Text(
                      MyString.newChat.tr,
                      style: const TextStyle(color: MyColor.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () {
                // Auto-scroll when messages change
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                });

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(10),
                  itemCount: _controller.messages.length,
                  itemBuilder: (context, index) {
                    return _buildMessageItem(_controller.messages[index]);
                  },
                );
              },
            ),
          ),
          Obx(() => _controller.isLoading.value
              ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          )
              : const SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildMessageInput(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(String message) {
    bool isResponse = message.startsWith("answer: ");
    return Align(
      alignment: isResponse ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isResponse
              ? const Color(0xFF9BC57E).withOpacity(0.9) // Light green for bot messages
              : const Color(0xFFFFF9C4).withOpacity(0.9), // Light yellow for user messages
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8),
            topRight: const Radius.circular(8),
            bottomLeft: isResponse ? const Radius.circular(0) : const Radius.circular(8),
            bottomRight: isResponse ? const Radius.circular(8) : const Radius.circular(0),
          ),
        ),
        child: MarkdownBody(
          data: message.replaceAll("answer: ", ""),  // Markdown content with line breaks
          styleSheet: MarkdownStyleSheet(
            p: GoogleFonts.libreBaskerville(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          softLineBreak: true, // Allows line breaks for '\n'
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    TextEditingController _textController = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // Shadow for depth
          ),
        ],
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
                style: GoogleFonts.libreBaskerville(
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.black),
                  hintText: MyString.message.tr,
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.libreBaskerville(
                    color: Colors.black54,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
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
              child: const Icon(
                Icons.send,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
