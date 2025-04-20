import 'package:flutter_ui/headers.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<AppController>();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $message'),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    try {
      final pickedFile =
          await _picker.pickImage(source: source, imageQuality: 85);

      if (pickedFile != null) {
        // final croppedFile = await ImageCropper().cropImage(
        //   sourcePath: pickedFile.path,
        //   aspectRatio: CropAspectRatio(
        //     ratioX: 1,
        //     ratioY: 1,
        //   ),
        //   maxHeight: 224,
        //   maxWidth: 224,
        // );
        // if (croppedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        // }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image pick error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool isUplaoding = false;
  Future<void> uploadImage(BuildContext context, File imageFile) async {
    final uri = Uri.parse(kServerUrl);
    final pingUri = Uri.parse(kPingUrl);

    setState(() {
      isUplaoding = true;
    });

    await Future.delayed(Duration(seconds: 1));

    try {
      // 👇 Check if server is alive first (fast ping)
      final pingResponse =
          await http.get(pingUri).timeout(Duration(seconds: 3));
      if (pingResponse.statusCode != 200) {
        throw Exception("Server is unreachable");
      }
      print("SERVER REACHABLE");

      final request = http.MultipartRequest('POST', uri);
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
          filename: basename(imageFile.path),
        ),
      );

      final streamedResponse =
          await request.send().timeout(Duration(seconds: 30));

      if (streamedResponse.statusCode == 200) {
        final responseBody = await streamedResponse.stream.bytesToString();
        final json = jsonDecode(responseBody);
        _onResults(json);

        setState(() {
          isUplaoding = false;
        });
      } else {
        setState(() {
          isUplaoding = false;
        });
        showError(context, 'Image Uploading Failed');
      }
    } catch (e) {
      setState(() {
        isUplaoding = false;
      });
      showError(context, 'Server not responding or down.');
    }
  }

  void _onResults(Map<String, dynamic> json) {
    final result = json['result'];
    final savedPath = json['savedPath'];
    final res = SimpleResult(result: result, imgUrl: savedPath ?? '');
    _selectedImage = null;
    if (result == 'Abnormal Foot') {
      controller.addResult(res);

      Get.toNamed(AppRoutes.rResultAbnormal, arguments: res);
    } else if (result == 'Normal Foot') {
      controller.addResult(res);

      Get.toNamed(AppRoutes.rResultNormal, arguments: res);
    } else {
      MySnackbar.error("Please Select Foot");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) async {
          switch (value) {
            case 0:
              Get.toNamed(AppRoutes.rProfile);
            case 1:
              Get.toNamed(AppRoutes.rContactDoctor);
            case 2:
              await controller.logout();
          }
        },
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        unselectedIconTheme: IconThemeData(
          color: Colors.white,
        ),
        selectedItemColor:
            Colors.white, // this changes both icon AND label color for selected
        unselectedItemColor:
            Colors.white, // icon and label color for unselected
        type: BottomNavigationBarType.fixed, // ensures consistent styling
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          )
        ],
      ),
      appBar: AppBar(
        title: Text('Home'),
        leading: SizedBox(),
      ),
      body: Center(
        child: isUplaoding
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_selectedImage != null)
                      Image.file(
                        _selectedImage!,
                        height: 224,
                        width: 224,
                      )
                    else
                      Container(
                        height: 224,
                        width: 224,
                        color: Colors.grey[300],
                        child: const Center(child: Text("No Image Selected")),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(context, ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text("Pick from Gallery"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(context, ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Take a Photo"),
                    ),
                    SizedBox(height: 50),
                    // const Spacer(),
                    SizedBox(
                      width: 224,
                      child: ElevatedButton(
                        onPressed: _selectedImage == null
                            ? null
                            : () => uploadImage(context, _selectedImage!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF33657D),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        child: const Text("Submit"),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   // Action Profile
  //   // Action Logout
  //   // Action Image

  //   return Scaffold(

  //   );
}

class AppBarActionBtn extends StatelessWidget {
  const AppBarActionBtn({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
  });
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 4, right: 16),
        child: Column(
          children: [
            Icon(icon),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
