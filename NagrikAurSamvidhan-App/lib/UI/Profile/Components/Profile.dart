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
              _buildUpdateButton(),
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
          _buildEditableField('Name', controller.nameController),
          _buildEditableField('Age', controller.ageController),
          _buildEditableField('Gender', controller.genderController),
          _buildEditableField('Phone Number', controller.phoneNumberController),
          _buildEditableField('Address', controller.addressController),
          _buildEditableField('City', controller.cityController),
          _buildEditableField('State', controller.stateController),
        ],
      ),
    );
  }

  Widget _buildEditableField(
      String label, TextEditingController textController) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
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

  Widget _buildUpdateButton() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () => controller.updateProfile(),
        child: Text('Update Profile'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFFE27D4E),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
      ),
    );
  }
}
