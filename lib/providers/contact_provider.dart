import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../model/contact.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> contacts = [
    Contact(
      name: 'Vignesh',
      contact: '987654321',
      email: 'vigneshramani@gmail.com',
      assetPic: 'assets/img/v1.jpg',
      time: 'Yesterday,10:45 PM',
    ),

  ];
  int current_step = 0;
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController phoneController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");

  checkContinueState() {
    if (current_step < 3) {
      current_step++;
    }
    notifyListeners();
  }

  checkCancelState() {
    if (current_step > 0) {
      current_step--;
    }
    notifyListeners();
  }

  void addContact(String name, String phone, String email) {
    contacts.add(Contact(name: name, contact: phone, email: email, time: 'Just Now',assetPic: "assets/img/wonder.jpg"));
    notifyListeners();
  }

  void addContactWithImage(
      String name, String phone, String email, String profileImage) {
    contacts.add(Contact(
        name: name, contact: phone, email: email, pic: profileImage, time: 'Just Now'));
    notifyListeners();
  }

  String? profileImageVar;

  void ImagePickerCamera() async {
    ImagePicker picker = ImagePicker();

    XFile? xFile = await picker.pickImage(source: ImageSource.camera);
    String? path = xFile!.path;
    profileImageVar = path;
    notifyListeners();
  }

  void ImagePickerGalary() async {
    ImagePicker picker = ImagePicker();

    XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    String? path = xFile!.path;
    profileImageVar = path;
    notifyListeners();
  }
  void checkFilledData() {
    if (nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        profileImageVar != null) {
      addContactWithImage(nameController.text, phoneController.text,
          emailController.text, profileImageVar!);
    } else if (nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        profileImageVar == null) {
      addContact(
          nameController.text, phoneController.text, emailController.text);
    }
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    profileImageVar = null;
    notifyListeners();
  }

}
