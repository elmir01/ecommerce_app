import 'package:ecommerce_app/data/db_helper.dart';
import 'package:ecommerce_app/management/flutter_management.dart';
import 'package:ecommerce_app/views/settings/edit_address_screen.dart';
import 'package:ecommerce_app/widgets/settings_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/address.dart';
import '../../widgets/appbar_back_button.dart';
import 'add_address_screen.dart';

class AddressScreen extends ConsumerStatefulWidget {
  const AddressScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddressScreenState();
}

class _AddressScreenState extends ConsumerState<AddressScreen> {


  @override
  void initState() {
    super.initState();
   ref.read(addressViewModel).fetchAddresses();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Address',
        ),
        leading: AppBarBackButton(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => AddAddressScreen(),
                ),
              ).then((_) =>    ref.read(addressViewModel).fetchAddresses());
            },
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(
                    255, 244, 244, 244), // Dairenin arkaplan rengi
              ),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.sp,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: ref.watch(addressViewModel).addresses.length,
                itemBuilder: (itemBuilder, index) {
                  final address = ref.watch(addressViewModel).addresses[index];
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: Key(address.id.toString()),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) async {
                      await ref.watch(addressViewModel).dbhelper.deleteAddress(address.id!);
                      ref.read(addressViewModel).fetchAddresses();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${address.streetAddress} deleted')),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.sp),
                      child: SettingsContainer(
                        width: 342.sp,
                        height: 72.sp,
                        child: ListTile(
                          title: Text(
                            '${address.streetAddress},${address.city},${address.state}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => EditAddressScreen(address: address,),
                                ),
                              ).then((result) {
                                if (result == true) {
                                  ref.read(addressViewModel).fetchAddresses();
                                }
                              });
                            },
                            child: Text('Edit'),
                    
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
