import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Elements/Widgets/spaces.dart';
import '../../../../Values/values.dart';
import '../../Controller/chatbotScreenController.dart';

class Chatbot_Screen extends StatefulWidget {
  const Chatbot_Screen({Key? key}) : super(key: key);

  @override
  _Chatbot_ScreenState createState() => _Chatbot_ScreenState();
}

class _Chatbot_ScreenState extends State<Chatbot_Screen> {
  late ChatbotScreenController _controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = Get.put(ChatbotScreenController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF434343),
              Color(0xFF000000),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
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
              }),
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
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
      ),
      title: Text(
        _controller.type == 'ConstitutionalBot'
            ? "Constitutional Bot"
            : "Educational Bot",
        style: GoogleFonts.merriweather(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [_buildNewChatButton()],
    );
  }

  Widget _buildNewChatButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: Sizes.WIDTH_120,
        decoration: BoxDecoration(
          color: MyColor.red,
          border: Border.all(color: Colors.black, width: 1.0),
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
    );
  }

  Widget _buildMessageItem(String message) {
    bool isResponse = message.startsWith("answer: ");

    String processedMessage = message
        .replaceAll("answer: ", "")
        .replaceAll(RegExp(r'<br\s*\/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<\/?p>', caseSensitive: false), '\n');

    processedMessage = processedMessage
        .replaceAllMapped(RegExp(r'"([^"]+)"'), (match) => '**"${match[1]}"**')
        .replaceAllMapped(RegExp(r'\b\d+\b'), (match) => '**${match[0]}**');

    return Align(
      alignment: isResponse ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.8,
        ),
        decoration: BoxDecoration(
          gradient: isResponse
              ? const LinearGradient(
                  colors: [Color(0xFFD7D2CC), Color(0xFF304352)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : const LinearGradient(
                  colors: [Color(0xFFEEF2F3), Color(0xFF8E9EAB)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8),
            topRight: const Radius.circular(8),
            bottomLeft: isResponse
                ? const Radius.circular(0)
                : const Radius.circular(8),
            bottomRight: isResponse
                ? const Radius.circular(8)
                : const Radius.circular(0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MarkdownBody(
              data: processedMessage,
              styleSheet: MarkdownStyleSheet(
                p: GoogleFonts.notoSans(fontSize: 16),
                strong: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                h1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                h2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                h3: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                listBullet:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                code: TextStyle(fontFamily: 'Courier', fontSize: 14),
              ),
              softLineBreak: false,
              fitContent: true,
              selectable: true,
              onTapLink: (text, href, title) {
                if (href != null) {
                  launchUrl(Uri.parse(href));
                }
              },
            ),
            if (isResponse)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.volume_up,
                    color: MyColor.white,
                  ),
                  onPressed: () => _controller.speakMessage(processedMessage),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    final TextEditingController _textController = TextEditingController();
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              maxLines: null,
              cursorColor: Colors.black,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: MyString.message.tr,
                border: InputBorder.none,
                hintStyle: GoogleFonts.notoSans(
                  color: Colors.black54,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
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
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.send, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
