import 'package:ecomerce_app/Pages/login_page.dart';
import 'package:ecomerce_app/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp( ChangeNotifierProvider(
      create: (context) => itemProvider(),
      child:const MyApp()));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.purple.shade100// Blue color with 50% opacity
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[
      ChangeNotifierProvider(create: (context) => itemProvider(),)
    ],
        child:  MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginPage(
          )
        ),
    );

  }
}

