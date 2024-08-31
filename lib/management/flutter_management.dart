import 'package:ecommerce_app/viewmodels/address_viewmodel.dart';
import 'package:ecommerce_app/viewmodels/get_user_viewmodel.dart';
import 'package:ecommerce_app/viewmodels/home_page_viewmodel.dart';
import 'package:ecommerce_app/viewmodels/login_page_viewmodel.dart';
import 'package:ecommerce_app/viewmodels/payment_viewmodel.dart';
import 'package:ecommerce_app/viewmodels/register_page_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/db_helper.dart';
import '../provider/cart_notifier.dart';
import '../provider/cart_state.dart';

var registerPageViewModel =
    ChangeNotifierProvider((ref) => RegisterPageViewModel());
var loginPageViewModel = ChangeNotifierProvider((ref) => LoginPageViewModel());
var getUserViewModel = ChangeNotifierProvider((ref) => GetUserViewModel());
var homePageViewModel = ChangeNotifierProvider((ref) => HomePageViewModel());
var addressViewModel = ChangeNotifierProvider((ref) => AddressViewModel());
var paymentViewModel = ChangeNotifierProvider((ref) => PaymentViewModel());