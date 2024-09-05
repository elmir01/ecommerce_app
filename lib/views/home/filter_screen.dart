import 'package:ecommerce_app/data/data_service.dart';
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
  var _searchController = TextEditingController();
  ScrollController? _scrollController = ScrollController();
  List<Product> filteredProducts = [];
  var products1 = DataService.predefinedProducts;
  var products2 = DataService.predefinedNewInProducts;
  var products3 = DataService.predefinedTopSellingProducts;
  double minPrice = 0;
  double maxPrice = 0;

  String searchText = '';

  void mergeProductLists() {
    filteredProducts = [...products1, ...products2, ...products3];
  }

  void filterProducts(String query, double minPrice, double maxPrice) {
    List<Product> results = [];

    results = [...products1, ...products2, ...products3];
    results = results
        .where(
            (product) => product.price >= minPrice && product.price <= maxPrice)
        .toList();

    if (query.isNotEmpty) {
      results = results
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredProducts = results;
    });
  }

  void initState() {
    super.initState();
    mergeProductLists();
  }
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
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
              controller: _searchController,
              onChanged: (value) {
                searchText = value;
                filterProducts(searchText, minPrice, maxPrice);
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
                  child:FilterTextField(
                      controller: minPriceController,
                      onChanged: (value) {
                        setState(() {
                          minPrice = double.tryParse(value)!;
                        });
                      },
                      labelText: 'Min Price',
                      prefixIcon: Icon(Icons.filter_list),
                      textInputType: TextInputType.number),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: FilterTextField(
                      controller: maxPriceController,
                      onChanged: (value) {
                        setState(() {
                          maxPrice = double.tryParse(value)!;
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
                    if (minPrice != null && maxPrice != null) {
                      filterProducts(searchText, minPrice, maxPrice);
                    }else {
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
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: filteredProducts.length,
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
                            product: filteredProducts[index],
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
                                    '${filteredProducts[index].images[0]}',
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
                                          .isFavourite(filteredProducts[index]);

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
                                                    filteredProducts[index]);
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
                                filteredProducts[index].name,
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
                                    '\$${filteredProducts[index].price}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (filteredProducts[index].isDiscount == true)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '\$${filteredProducts[index].disCountPrice.toString()}',
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
