import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nagrik_aur_samvidhan_app/Values/values.dart';
import '../../../Localization/Translation/translations.dart';
import '../Controller/profileController.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE27D4E),
        title: Text(
          'Profile',
          style: TextStyle(
            color: MyColor.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: ImageIcon(
              AssetImage('assets/profile/logout.png'),
              color: MyColor.white,
            ),
            onPressed: () => controller.logout(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPersonalInfo(),
              _buildSettings(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPersonalInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Personal Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage:
                  NetworkImage(controller.userData['userPhoto'] ?? ''),
            ),
          ),
          SizedBox(height: 16),
          _buildInfoTile(
              Icons.person, 'Name', controller.userData['name'] ?? 'N/A'),
          _buildInfoTile(
              Icons.email, 'Email', controller.userData['email'] ?? 'N/A'),
          _buildInfoTile(Icons.cake, 'Age',
              controller.userData['age']?.toString() ?? 'N/A'),
          _buildInfoTile(Icons.person_outline, 'Gender',
              controller.userData['gender'] ?? 'N/A'),
          _buildInfoTile(Icons.phone, 'Phone Number',
              controller.userData['phoneNumber'] ?? 'N/A'),
          _buildInfoTile(Icons.language, 'Language',
              controller.userData['language'] ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon),
      title: Text('$title: $value'),
    );
  }

  Widget _buildSettings() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('settings'.tr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Theme'.tr),
            trailing: Obx(() => DropdownButton<String>(
                  value: controller.currentTheme,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.setTheme(newValue);
                    }
                  },
                  items: controller.themeOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(' Change Language'.tr),
            trailing: Obx(() => DropdownButton<LanguageModel>(
                  value: controller.languageOptions.firstWhere(
                      (lang) => lang.language == controller.currentLanguage,
                      orElse: () => controller.languageOptions.first),
                  onChanged: (LanguageModel? newValue) {
                    if (newValue != null) {
                      controller.setLanguage(newValue);
                    }
                  },
                  items: controller.languageOptions
                      .map<DropdownMenuItem<LanguageModel>>(
                          (LanguageModel value) {
                    return DropdownMenuItem<LanguageModel>(
                      value: value,
                      child: Text(value.language),
                    );
                  }).toList(),
                )),
          ),
        ],
      ),
    );
  }
}
