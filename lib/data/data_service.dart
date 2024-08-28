import 'dart:ui';

import '../models/category.dart';
import '../models/product.dart';


class DataService {
  static final List<Category> predefinedCategories = [
    Category(id: 1, name: 'Hoodies', image: 'assets/hoodies.png'),
    Category(id: 2, name: 'Shorts', image: 'assets/shorts.png'),
    Category(id: 3, name: 'Shoes', image: 'assets/shoes.png'),
    Category(id: 4, name: 'Bags', image: 'assets/bag.png'),
    Category(id: 5, name: 'Accessories', image: 'assets/accessories.png')
    // Add more categories
  ];
  static final List<Product> predefinedTopSellingProducts = [
    Product(
      listId: 1,
      id: 1,
      name: 'Men\'s Harrington Jacket',
      description: 'A powerful smartphone with 128GB storage',
      price: 148.00,
      sizes: ['S', 'M', 'L', 'XL', '2XL'],
      colors: {
        'Orange': '0xFFFFA500',
        'Black': '0xFF000000',
        'Red': '0xFFFF0000',
        'Yellow': '0xFFFFFF00',
        'Blue': '0xFF0000FF'
      },
      quantity: 50,
      images: ['assets/jacket.png'],
      categoryId: 1,
      isDiscount: false,
      disCountPrice: 0,

    ),
    Product(
      listId: 1,
      id: 2,
      name: 'Max Ciro Men\'s Slides',
      description: 'A powerful smartphone with 128GB storage',
      price: 55.00,
      sizes: ['S', 'M', 'L', 'XL', '2XL'],
      colors: {
        'Orange': '0xFFFFA500',
        'Black': '0xFF000000',
        'Red': '0xFFFF0000',
        'Yellow': '0xFFFFFF00',
        'Blue': '0xFF0000FF'
      },
      quantity: 50,
      images: ['assets/slides.png'],
      categoryId: 1,
      isDiscount: true,
      disCountPrice: 100.97,
    ),
    Product(
      listId: 1,
      id: 3,
      name: 'Men\'s Running Shoes',
      description: 'A powerful smartphone with 128GB storage',
      price: 68.00,
      sizes: ['S', 'M', 'L', 'XL', '2XL'],
      colors: {
        'Orange': '0xFFFFA500',
        'Black': '0xFF000000',
        'Red': '0xFFFF0000',
        'Yellow': '0xFFFFFF00',
        'Blue': '0xFF0000FF'
      },
      quantity: 50,
      images: ['assets/nikeshoes.png'],
      categoryId: 1,
      isDiscount: false,
      disCountPrice: 0,
    ),
  ];
  static final List<Product> predefinedProducts = [
    Product(
      listId: 2,
      id: 1,
      name: 'Men\'s fleece Pullover ',
      description: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here,making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
      price: 100.99,
      sizes: ['S', 'M', 'L', 'XL', '2XL'],
      colors: {
        'Orange': '0xFFFFA500',
        'Black': '0xFF000000',
        'Red': '0xFFFF0000',
        'Yellow': '0xFFFFFF00',
        'Blue': '0xFF0000FF'
      },
      quantity: 50,
      images: ['assets/png1.png', 'assets/png2.png', 'assets/png3.png'],
      categoryId: 1,
      isDiscount: true,
      disCountPrice: 76.0,
    ),
    Product(
      listId: 2,
      id: 2,
      name: 'Fleece Pullover Skate',
      description: 'Comfortable cotton t-shirt',
      price: 150.97,
      sizes: ['S', 'M', 'L', 'XL', '2XL'],
      colors: {
        'Orange': '0xFFFFA500',
        'Black': '0xFF000000',
        'Red': '0xFFFF0000',
        'Yellow': '0xFFFFFF00',
        'Blue': '0xFF0000FF'
      },
      quantity: 200,
      images: ['assets/png2.png'],
      categoryId: 1,
      isDiscount: false,
      disCountPrice: 0,
    ),
    Product(
      listId: 2,
      id: 3,
      name: 'Fleece Skate Hoodie',
      description: 'Comfortable cotton t-shirt',
      price: 110.00,
      sizes: ['S', 'M', 'L', 'XL', '2XL'],
      colors: {
        'Orange': '0xFFFFA500',
        'Black': '0xFF000000',
        'Red': '0xFFFF0000',
        'Yellow': '0xFFFFFF00',
        'Blue': '0xFF0000FF'
      },
      quantity: 200,
      images: ['assets/png3.png'],
      categoryId: 1,
      isDiscount: false,
      disCountPrice: 0,
    ),
    Product(
      listId: 2,
      id: 4,
      name: 'Men\'s Ice-Dye Pullover Hoodie',
      description: 'Comfortable cotton t-shirt',
      price: 128.97,
      sizes: ['S', 'M', 'L', 'XL', '2XL'],
      colors: {
        'Orange': '0xFFFFA500',
        'Black': '0xFF000000',
        'Red': '0xFFFF0000',
        'Yellow': '0xFFFFFF00',
        'Blue': '0xFF0000FF'
      },
      quantity: 200,
      images: ['assets/png4.png'],
      categoryId: 1,
      isDiscount: false,
      disCountPrice: 0,
    ),
    Product(
      listId: 2,
      id: 5,
      name: 'Fleece Skate Hoodie',
      description: 'Comfortable cotton t-shirt',
      price: 110.00,
      sizes: ['S', 'M', 'L', 'XL', '2XL'],
      colors: {
        'Orange': '0xFFFFA500',
        'Black': '0xFF000000',
        'Red': '0xFFFF0000',
        'Yellow': '0xFFFFFF00',
        'Blue': '0xFF0000FF'
      },
      quantity: 200,
      images: ['assets/png5.png'],
      categoryId: 1,
      isDiscount: false,
      disCountPrice: 0,
    ),
    Product(
      listId: 2,
      id: 6,
      name: 'Men\'s Ice-Dye Pullover Hoodie',
      description: 'Comfortable cotton t-shirt',
      price: 128.97,
      sizes: ['S', 'M', 'L', 'XL', '2XL'],
      colors: {
        'Orange': '0xFFFFA500',
        'Black': '0xFF000000',
        'Red': '0xFFFF0000',
        'Yellow': '0xFFFFFF00',
        'Blue': '0xFF0000FF'
      },
      quantity: 200,
      images: ['assets/png6.png'],
      categoryId: 1,
      isDiscount: false,
      disCountPrice: 0,
    ),
    // Add more products
  ];
  static final List<Product> predefinedNewInProducts = [
    Product(
      listId: 3,
      id: 1,
      name: 'Nike Fuel Pack',
      description: 'A powerful smartphone with 128GB storage',
      price: 32.00,
      sizes: ['S', 'M', 'L', 'XL', '2XL'],
      colors: {
        'Orange': '0xFFFFA500',
        'Black': '0xFF000000',
        'Red': '0xFFFF0000',
        'Yellow': '0xFFFFFF00',
        'Blue': '0xFF0000FF'
      },
      quantity: 50,
      images: ['assets/nike.png'],
      categoryId: 1,
      isDiscount: false,
      disCountPrice: 0,
    ),
    Product(
      listId: 3,
      id: 2,
      name: 'Nike Show X Rush',
      description: 'A powerful smartphone with 128GB storage',
      price: 204.00,
      sizes: ['S', 'M', 'L', 'XL', '2XL'],
      colors: {
        'Orange': '0xFFFFA500',
        'Black': '0xFF000000',
        'Red': '0xFFFF0000',
        'Yellow': '0xFFFFFF00',
        'Blue': '0xFF0000FF'
      },
      quantity: 50,
      images: ['assets/nikeshow.png'],
      categoryId: 1,
      isDiscount: false,
      disCountPrice: 0,
    ),
    Product(
      listId: 3,
      id: 3,
      name: 'Men\'s T-Shirt',
      description: 'A powerful smartphone with 128GB storage',
      price: 32.00,
      sizes: ['S', 'M', 'L', 'XL', '2XL'],
      colors: {
        'Orange': '0xFFFFA500',
        'Black': '0xFF000000',
        'Red': '0xFFFF0000',
        'Yellow': '0xFFFFFF00',
        'Blue': '0xFF0000FF'
      },
      quantity: 50,
      images: ['assets/tshirt.png'],
      categoryId: 1,
      isDiscount: true,
      disCountPrice: 16.00,
    ),
  ];

}
