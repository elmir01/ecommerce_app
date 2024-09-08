import 'package:ecommerce_app/data/data_service.dart';
import 'package:ecommerce_app/management/flutter_management.dart';
import 'package:ecommerce_app/views/home/product_detail_screen.dart';
import 'package:ecommerce_app/widgets/appbar_back_button.dart';
import 'package:ecommerce_app/widgets/filter_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/product.dart';
import '../../provider/favourite_provider.dart';
import '../../widgets/product_container.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {

  void initState() {
    super.initState();
    ref.read(filterViewModel).mergeProductLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Column(
          children: [
            FilterTextField(
              controller: ref.watch(filterViewModel).searchController,
              onChanged: (value) {
                ref.watch(filterViewModel).searchText = value;
                ref.read(filterViewModel).filterProducts(
                    ref.watch(filterViewModel).searchText,
                    ref.watch(filterViewModel).minPrice,
                    ref.watch(filterViewModel).maxPrice);
              },
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: 8.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: FilterTextField(
                      controller: ref.watch(filterViewModel).minPriceController,
                      onChanged: (value) {
                        setState(() {
                          ref.watch(filterViewModel).minPrice = double.tryParse(value)!;
                        });
                      },
                      labelText: 'Min Price',
                      prefixIcon: Icon(Icons.filter_list),
                      textInputType: TextInputType.number),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: FilterTextField(
                      controller: ref.watch(filterViewModel).maxPriceController,
                      onChanged: (value) {
                        setState(() {
                          ref.watch(filterViewModel).maxPrice = double.tryParse(value)!;
                        });
                      },
                      labelText: 'Min Price',
                      prefixIcon: Icon(Icons.filter_list),
                      textInputType: TextInputType.number),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 142, 108, 209),
                  ),
                  onPressed: () {
                    if (ref.watch(filterViewModel).minPrice != null && ref.watch(filterViewModel).maxPrice != null) {
                      ref.read(filterViewModel).filterProducts(
                          ref.watch(filterViewModel).searchText,
                          ref.watch(filterViewModel).minPrice,
                          ref.watch(filterViewModel).maxPrice);
                    } else {
                      print('xeta');
                    }
                  },
                  child: Text(
                    'Filter',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.sp,
            ),
            Expanded(
              child: GridView.builder(
                controller: ref.watch(filterViewModel).scrollController,
                shrinkWrap: true,
                itemCount: ref.watch(filterViewModel).filteredProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0.sp,
                  crossAxisSpacing: 11.0.sp,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: ref.watch(filterViewModel).filteredProducts[index],
                          ),
                        ),
                      );
                    },
                    child: ProductContainer(
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
                                    '${ref.watch(filterViewModel).filteredProducts[index].images[0]}',
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
                                          .isFavourite(ref.watch(filterViewModel).filteredProducts[index]);

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
                                                .read(
                                                    favouriteProvider.notifier)
                                                .toggleFavourite(
                                                ref.watch(filterViewModel).filteredProducts[index]);
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
                                ref.watch(filterViewModel).filteredProducts[index].name,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    '\$${ref.watch(filterViewModel).filteredProducts[index].price}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (ref.watch(filterViewModel).filteredProducts[index].isDiscount == true)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '\$${ref.watch(filterViewModel).filteredProducts[index].disCountPrice.toString()}',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
