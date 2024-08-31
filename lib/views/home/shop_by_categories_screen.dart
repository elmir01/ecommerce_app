import 'dart:ffi';

import 'package:ecommerce_app/data/data_service.dart';
import 'package:ecommerce_app/widgets/appbar_back_button.dart';
import 'package:ecommerce_app/widgets/cart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'categories_to_product_screen.dart';

class ShopByCategoriesScreen extends ConsumerStatefulWidget {
  const ShopByCategoriesScreen({super.key});

  @override
  ConsumerState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<ShopByCategoriesScreen> {
  var category = DataService.predefinedCategories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 15.sp),
            child: CartButton(),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.sp,
            ),
            Text(
              'Shop by Categories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            ListView.builder(
              itemCount: category.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = category[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0.sp,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CategoriesToProductScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 342.sp,
                      height: 64.sp,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Image.asset(
                            item.image,
                            width: 50.sp,
                            height: 50.sp,
                          ),
                          title: Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }
}
