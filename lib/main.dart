import 'package:ecomerce_application/Pages/authPage.dart';
import 'package:ecomerce_application/Provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'home.dart';


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp( ChangeNotifierProvider(
      create: (context) => ItemProvider(),
      child:const MyApp()));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.purple.shade100
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[
      ChangeNotifierProvider(create: (context) => ItemProvider(),)
    ],
        child:   StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){

            if(snapshot.hasData){
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home:  Home(),
              );
            }else{
              return const MaterialApp(
                debugShowCheckedModeBanner: false,

                home: AuthPage(),
              );
            }
          },

        ),
    );

  }
}

