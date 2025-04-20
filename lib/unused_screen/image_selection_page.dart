// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_ui/constant.dart';
// import 'package:flutter_ui/screens/result_abnormal.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_ui/screens/result_normal.dart';

// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';

// class ImageSelectionScreen extends StatefulWidget {
//   const ImageSelectionScreen({
//     super.key,
//     required this.diabetesDuration,
//     required this.footCare,
//     required this.hadUlcerBefore,
//   });

//   final String diabetesDuration;
//   final String footCare;
//   final String hadUlcerBefore;

//   @override
//   State<ImageSelectionScreen> createState() => _ImageSelectionScreenState();
// }

// class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
//   File? _selectedImage;
//   final ImagePicker _picker = ImagePicker();
//   void showError(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Error: $message'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   Future<void> _pickImage(BuildContext context, ImageSource source) async {
//     try {
//       final pickedFile =
//           await _picker.pickImage(source: source, imageQuality: 85);

//       if (pickedFile != null) {
//         // final croppedFile = await ImageCropper().cropImage(
//         //   sourcePath: pickedFile.path,
//         //   aspectRatio: CropAspectRatio(
//         //     ratioX: 1,
//         //     ratioY: 1,
//         //   ),
//         //   maxHeight: 224,
//         //   maxWidth: 224,
//         // );
//         // if (croppedFile != null) {
//         setState(() {
//           _selectedImage = File(pickedFile.path);
//         });
//         // }
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Image pick error: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   bool isUplaoding = false;
//   Future<void> uploadImage(BuildContext context, File imageFile) async {
//     final uri = Uri.parse(kServerUrl);
//     final pingUri = Uri.parse(kPingUrl);

//     setState(() {
//       isUplaoding = true;
//     });

//     await Future.delayed(Duration(seconds: 1));

//     try {
//       // 👇 Check if server is alive first (fast ping)
//       final pingResponse =
//           await http.get(pingUri).timeout(Duration(seconds: 3));
//       if (pingResponse.statusCode != 200) {
//         throw Exception("Server is unreachable");
//       }
//       print("SERVER REACHABLE");

//       final request = http.MultipartRequest('POST', uri);
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'file',
//           imageFile.path,
//           filename: basename(imageFile.path),
//         ),
//       );

//       final streamedResponse =
//           await request.send().timeout(Duration(seconds: 30));

//       if (streamedResponse.statusCode == 200) {
//         final responseBody = await streamedResponse.stream.bytesToString();
//         final json = jsonDecode(responseBody);
//         final result = json['result'];

//         setState(() {
//           isUplaoding = false;
//         });

//         if (result == 'Abnormal Feet') {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => ResultDiagnosisOfAbnormalFoot()));
//         } else if (result == 'Normal Feet') {
//           // Navigator.push(
//           //     context,
//           //     MaterialPageRoute(
//           //       builder: (context) => ResultDiagnosisOfNormalFoot(
//           //         diabetesDuration: widget.diabetesDuration,
//           //         footCare: widget.footCare,
//           //         hadUlcerBefore: widget.hadUlcerBefore,
//           //         imagePath: _selectedImage!.path,
//           //       ),
//           //     ));
//         } else {
//           showError(context, 'Please Select Foot');
//         }
//       } else {
//         setState(() {
//           isUplaoding = false;
//         });
//         showError(context, 'Image Uploading Failed');
//       }
//     } catch (e) {
//       setState(() {
//         isUplaoding = false;
//       });
//       showError(context, 'Server not responding or down.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Image Selection',
//             style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF33657D),
//       ),
//       body: isUplaoding
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   if (_selectedImage != null)
//                     Image.file(
//                       _selectedImage!,
//                       height: 224,
//                       width: 224,
//                     )
//                   else
//                     Container(
//                       height: 250,
//                       color: Colors.grey[300],
//                       child: const Center(child: Text("No Image Selected")),
//                     ),
//                   const SizedBox(height: 20),
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(context, ImageSource.gallery),
//                     icon: const Icon(Icons.photo_library),
//                     label: const Text("Pick from Gallery"),
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(context, ImageSource.camera),
//                     icon: const Icon(Icons.camera_alt),
//                     label: const Text("Take a Photo"),
//                   ),
//                   const Spacer(),
//                   ElevatedButton(
//                     onPressed: _selectedImage == null
//                         ? null
//                         : () => uploadImage(context, _selectedImage!),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF33657D),
//                       foregroundColor: Colors.white,
//                       minimumSize: const Size.fromHeight(50),
//                       textStyle: const TextStyle(fontSize: 18),
//                     ),
//                     child: const Text("Submit"),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
