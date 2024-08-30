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
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/db_helper.dart';
import '../../models/user.dart';
import '../auth/login_screen.dart';
import 'edit_user_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  TextStyle style = TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp);

  void initState() {
    super.initState();
    ref.read(getUserViewModel).loadUser();
// _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = ref.watch(getUserViewModel);
    print(ref.watch(getUserViewModel).user!.firstName);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: IntrinsicWidth(
          stepWidth: double.infinity,
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: userViewModel.fileImage == null
                        ? AssetImage('assets/person.jpg')
                        : Image.file(userViewModel.fileImage!).image,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () async {
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
                    '${userViewModel.user?.firstName ?? 'a'}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${userViewModel.user?.email ?? 'a'}\n032420343',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => EditUserScreen(user: userViewModel.user!,),
                        ),
                      ).then(
                        (value) {
                          if(value==true){
                            ref.read(getUserViewModel).loadUser();
                          }
                        }
                      );
                    },
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
                  ref.read(getUserViewModel).logOut(context);
                  userViewModel.fileImage = null;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 40.sp,
                onPressed: () {
                  ref.read(getUserViewModel).imageFromCamera();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.camera_alt_rounded),
              ),
              IconButton(
                iconSize: 40.sp,
                onPressed: () {
                  ref.read(getUserViewModel).imageFromGallery();
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.photo_camera_back_outlined,
                ),
              ),
              IconButton(
                iconSize: 40.sp,
                onPressed: () async {
                  await ref.read(getUserViewModel).deleteImage(context);
                  Navigator.pop(context);

                  print('delete');
                },
                icon: Icon(Icons.delete),
              )
            ],
          ),
        ],
      ),
    );
  }
}
