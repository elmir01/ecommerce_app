import 'dart:io';

import 'package:ecommerce_app/management/flutter_management.dart';
import 'package:ecommerce_app/views/settings/address_screen.dart';
import 'package:ecommerce_app/views/settings/payment_screen.dart';
import 'package:ecommerce_app/views/settings/wishlist_screen.dart';
import 'package:ecommerce_app/widgets/settings_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/db_helper.dart';
import '../../models/user.dart';
import '../auth/login_screen.dart';
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  TextStyle style = TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp);
  // final db = DatabaseHelper();
  // User? _user;
  // var picker = ImagePicker();
  // File? fileImage;
  // void initState() {
  //   super.initState();
  //   _loadUser();
  // }
  // Future<void> _loadUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? userId = prefs.getInt('user_id');
  //   if (userId != null) {
  //     User? user = await db.getUserById(userId);
  //     if (user != null) {
  //       setState(() {
  //         _user = user;
  //         fileImage = user.imagePath != null ? File(user.imagePath!) : null;
  //       });
  //     } else {
  //       print("User not found.");
  //     }
  //   } else {
  //     print("User ID not found in SharedPreferences.");
  //   }
  // }
  // Future<void> _saveImageToDatabase(String imagePath) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? userId = prefs.getInt('user_id');
  //   if (userId != null) {
  //     await db.updateProfileImage(userId, imagePath);
  //   }
  // }
  // Future<void> logOut(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('user_id');  // Remove the saved user ID
  //
  //   // Navigate to the login screen (replace `LoginScreen` with your actual login screen)
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => LoginScreen()),
  //   );
  // }
  //
  //
  // Future<void> imageFromCamera() async {
  //   final image = await picker.pickImage(
  //     source: ImageSource.camera,
  //     imageQuality: 50,
  //   );
  //   if (image != null) {
  //     await cropImageFile(File(image.path));
  //   }
  // }
  //
  // Future<void> imageFromGallery() async {
  //   final image = await picker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 50,
  //   );
  //   if (image != null) {
  //     await cropImageFile(File(image.path));
  //   }
  // }
  //
  // Future<void> cropImageFile(File imageFile) async {
  //   final croppedImage = await ImageCropper().cropImage(
  //     sourcePath: imageFile.path,
  //     uiSettings: [
  //       AndroidUiSettings(
  //         toolbarTitle: 'Cropper',
  //         toolbarColor: Colors.deepOrange,
  //         toolbarWidgetColor: Colors.white,
  //         initAspectRatio: CropAspectRatioPreset.square,
  //         lockAspectRatio: false,
  //       ),
  //     ],
  //   );
  //
  //   if (croppedImage != null) {
  //     setState(() {
  //       fileImage = File(croppedImage.path);
  //     });
  //     await _saveImageToDatabase(croppedImage.path); // Şəkil yolunu SQLite-a əlavə edin
  //   }
  // }
  void initState() {
    super.initState();
   ref.read(getUserViewModel).loadUser();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: IntrinsicWidth(
          stepWidth: double.infinity,
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: ref.read(getUserViewModel).fileImage == null
                        ? AssetImage('assets/person.jpg')
                        : Image.file(ref.read(getUserViewModel).fileImage!).image,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () async{
                        Map<Permission, PermissionStatus> status = await [
                        Permission.storage,
                            Permission.camera,
                        ].request();

                        showModalBottomSheet(
                        context: context,
                        builder: _buildBottomSheet,
                        );
                        print('object');
                      },
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 142, 108, 209),
                        radius: 15,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // NetworkImage(
              //   'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp',
              // ),
              SizedBox(
                height: 30.sp,
              ),
              SettingsContainer(
                width: 342.sp,
                height: 96.sp,
                child: ListTile(
                  title: Text(
                    '${ref.read(getUserViewModel).user?.firstName}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${ref.read(getUserViewModel).user?.email}\n032420343',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text('Edit'),
                  ),
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              SizedBox(height: 10.sp),
              SettingsContainer(
                width: 342.sp,
                height: 56.sp,
                child: ListTile(
                  onTap: () {

                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => AddressScreen(),
                      ),
                    );
                  },
                  title: Text(
                    'Address',
                    style: style,
                  ),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              SizedBox(height: 10.sp),
              SettingsContainer(
                width: 342.sp,
                height: 56.sp,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => WishlistScreen(),
                      ),
                    );
                  },
                  title: Text(
                    'Favourites',
                    style: style,
                  ),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              SizedBox(height: 10.sp),
              SettingsContainer(
                width: 342.sp,
                height: 56.sp,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => PaymentScreen(),
                      ),
                    );
                  },
                  title: Text(
                    'Payment',
                    style: style,
                  ),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              SizedBox(height: 10.sp),
              SettingsContainer(
                width: 342.sp,
                height: 56.sp,
                child: ListTile(
                  title: Text(
                    'Help',
                    style: style,
                  ),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              SizedBox(height: 10.sp),
              SettingsContainer(
                width: 342.sp,
                height: 56.sp,
                child: ListTile(
                  title: Text(
                    'Support',
                    style: style,
                  ),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              SizedBox(height: 20.sp),
              TextButton(
                onPressed: () {
                 ref.watch(getUserViewModel).logOut(context);
                },
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Upload Image'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                 ref.watch(getUserViewModel).imageFromCamera();
                  Navigator.pop(context);
                },
                child: Text('Camera'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.watch(getUserViewModel).imageFromGallery();
                  Navigator.pop(context);
                },
                child: Text('Gallery'),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () async{
              setState(() {
                ref.watch(getUserViewModel).deleteImage(context);
              });

              Navigator.pop(context);
              print('delete');
            },
            child: Text('Delete'),
          )
        ],
      ),
    );
  }

}
