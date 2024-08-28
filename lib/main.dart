import 'package:ecommerce_app/views/auth/login_screen.dart';
import 'package:ecommerce_app/views/home/cart_screen.dart';
import 'package:ecommerce_app/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final themeNotifier = ref.watch(themeNotifierProvider);
    return ScreenUtilInit(
      designSize: Size(width, height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'First Method',
          theme: ThemeData(

            splashFactory: NoSplash.splashFactory,
            appBarTheme: AppBarTheme(
              surfaceTintColor: Colors.transparent,
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.sp,
              ),
            ),
          ),
          home: child,
        );
      },
      child: SplashScreen(),
    );
  }
}
