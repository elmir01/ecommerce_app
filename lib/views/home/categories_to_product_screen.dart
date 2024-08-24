import 'package:ecommerce_app/data/data_service.dart';
import 'package:ecommerce_app/views/home/product_detail_screen.dart';
import 'package:ecommerce_app/widgets/appbar_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/db_helper.dart';
import '../../models/favourite.dart';
import '../../models/product.dart';
import '../../provider/favourite_provider.dart';

class CategoriesToProductScreen extends ConsumerStatefulWidget {
  const CategoriesToProductScreen({super.key});

  @override
  ConsumerState createState() => _CategoriesToProductScreenState();
}

class _CategoriesToProductScreenState
    extends ConsumerState<CategoriesToProductScreen> {
  ScrollController scrollController = ScrollController();
  var product = DataService.predefinedProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 10.sp,
            ),
            Text(
              'Hoodies',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            GridView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: product.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // İki sütunlu grid
                mainAxisSpacing: 10.0.sp,
                crossAxisSpacing: 11.0.sp,
                childAspectRatio:
                    0.65, // Məhsul kartlarının nisbətini tənzimləyir
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ProductDetailScreen(product: product[index],),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // spreadRadius: 2,
                          blurRadius: 1,
                          // offset: Offset(0, 3), // Kölgə effekti
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10.0)),
                                child: Image.asset(
                                  '${product[index].images[0]}',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200.sp,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    final isFavourite = ref
                                        .watch(favouriteProvider.notifier)
                                        .isFavourite(product[index]);

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
                                              .read(favouriteProvider.notifier)
                                              .toggleFavourite(product[index]);
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product[index].name,
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '\$${product[index].price}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}
