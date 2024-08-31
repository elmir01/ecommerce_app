import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/data/db_helper.dart';
import 'package:ecommerce_app/views/home/product_detail_screen.dart';
import 'package:ecommerce_app/views/settings/settings_screen.dart';
import 'package:ecommerce_app/widgets/cart_button.dart';
import 'package:ecommerce_app/widgets/product_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_service.dart';
import '../../management/flutter_management.dart';
import '../../models/category.dart';
import '../../provider/cart_notifier.dart';
import '../../provider/favourite_provider.dart';
import 'cart_screen.dart';
import 'categories_to_product_screen.dart';
import 'shop_by_categories_screen.dart';
import 'notification_screen.dart';
import 'orders_screen.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

const List<String> list = <String>['Man', 'Woman'];

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String dropdownValue = list.first;

  @override
  void initState() {
    super.initState();
    ref.read(homePageViewModel).imageFuture =
        ref.read(homePageViewModel).fetchImage();
  }

  var topSellingProducts = DataService.predefinedTopSellingProducts;
  var newInProducts = DataService.predefinedNewInProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String?>(
                    future: ref.read(homePageViewModel).imageFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Xəta: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return CircleAvatar(
                          radius: 25.sp,
                          backgroundImage: snapshot.data == null
                              ? AssetImage('assets/person.jpg')
                              : Image.file(File(snapshot.data!)).image,
                        );
                      } else {
                        return CircleAvatar(
                          radius: 25.sp,
                          backgroundImage: AssetImage('assets/person.jpg'),
                        );
                      }
                    },
                  ),
                  Container(
                    width: 72.sp,
                    height: 40.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(90.sp)),
                      color: Color.fromARGB(255, 244, 244, 244),
                    ),
                    child: Center(
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        underline: Container(
                          height: 0.sp,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                 Padding(
                   padding:  EdgeInsets.only(right: 10.sp),
                   child: CartButton(),
                 ),
                ],
              ),
              SizedBox(
                height: 20.sp,
              ),
              SizedBox(
                width: double.infinity,
                height: 40.sp,
                child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5.sp),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    fillColor: Color.fromARGB(255, 244, 244, 244),
                    labelText: 'Search',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ShopByCategoriesScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(color: Colors.black54, fontSize: 16.sp),
                    ),
                  ),
                ],
              ),

              //Categories Slider

              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.3,
                  enableInfiniteScroll: true,
                  height: 120.sp,
                ),
                items: DataService.predefinedCategories.map((category) {
                  return Builder(
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    CategoriesToProductScreen(),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50.sp,
                                backgroundImage: AssetImage(category.image),
                              ),
                              SizedBox(height: 5.sp),
                              Text(
                                '${category.name}',
                                style: TextStyle(fontSize: 12.sp),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20.sp,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Selling',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(color: Colors.black54, fontSize: 16.sp),
                    ),
                  ),
                ],
              ),

              //Top selling Carousel
              CarouselSlider.builder(
                itemCount: topSellingProducts.length,
                itemBuilder: (context, index, realIndex) {
                  final item = topSellingProducts[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: item),
                          ),
                        );
                      },
                      child: ProductContainer(
                        width: 159.sp,
                        height: 281.sp,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    item.images[0],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 150.sp,
                                  ),
                                  Positioned(
                                      top: 1.sp,
                                      right: 1.sp,
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          final isFavourite = ref
                                              .watch(favouriteProvider.notifier)
                                              .isFavourite(
                                                  topSellingProducts[index]);

                                          return IconButton(
                                            icon: Icon(
                                              isFavourite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isFavourite
                                                  ? Colors.red
                                                  : Colors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                ref
                                                    .read(favouriteProvider
                                                        .notifier)
                                                    .toggleFavourite(
                                                        topSellingProducts[
                                                            index]);
                                              });
                                            },
                                          );
                                        },
                                      )),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          '\$${item.price}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (item.isDiscount == true)
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 8.0.sp),
                                            child: Text(
                                              '\$${item.disCountPrice}',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
                options: CarouselOptions(
                  height: 265.sp,
                  viewportFraction: 0.5,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: true,
                  initialPage: 0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                      color: Color.fromARGB(255, 142, 108, 209),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ShopByCategoriesScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(color: Colors.black54, fontSize: 16.sp),
                    ),
                  ),
                ],
              ),

              //New in CarouselSlider
              CarouselSlider.builder(
                itemCount: newInProducts.length,
                itemBuilder: (context, index, realIndex) {
                  final item = newInProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: item,
                          ),
                        ),
                      );
                    },
                    child: ProductContainer(
                      width: 159.sp,
                      height: 281.sp,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Image.asset(
                                  item.images[0],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 150.sp,
                                ),
                                Positioned(
                                    top: 1.sp,
                                    right: 1.sp,
                                    child: Consumer(
                                      builder: (context, ref, child) {
                                        final isFavourite = ref
                                            .watch(favouriteProvider.notifier)
                                            .isFavourite(newInProducts[index]);

                                        return IconButton(
                                          icon: Icon(
                                            isFavourite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isFavourite
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              ref
                                                  .read(favouriteProvider
                                                      .notifier)
                                                  .toggleFavourite(
                                                      newInProducts[index]);
                                            });
                                          },
                                        );
                                      },
                                    )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.sp),
                                  Row(
                                    children: [
                                      Text(
                                        '\$${item.price}',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (item.isDiscount == true)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            '\$${item.disCountPrice.toString()}',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 265.sp,
                  viewportFraction: 0.5.sp,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: true,
                  initialPage: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
