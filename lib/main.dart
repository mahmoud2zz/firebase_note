
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_note_provider/firebase/fb_storage_controller.dart';
import 'package:firebase_note_provider/providers/images_provider.dart';
import 'package:firebase_note_provider/providers/note_provider.dart';
import 'package:firebase_note_provider/screen/app/home_screen.dart';
import 'package:firebase_note_provider/screen/app/images_screen.dart';
import 'package:firebase_note_provider/screen/app/upload_image_screen.dart';
import 'package:firebase_note_provider/screen/auth/login_screen.dart';
import 'package:firebase_note_provider/screen/auth/register_screen.dart';
import 'package:firebase_note_provider/screen/core/launch_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'firebase/fb_notifications.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 await  FbNotifications.initNotifications();



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

        return  MultiProvider(
          providers: [
  ChangeNotifierProvider<NoteProvider>(create: (context)=> NoteProvider()),
    ChangeNotifierProvider<ImagesProvider>(create: (context)=> ImagesProvider())
          ],
         child: MaterialApp(
           initialRoute: '/launch_screen',
           debugShowCheckedModeBanner: false,
           routes: {
             '/launch_screen': (context) => const LaunchScreen(),
             '/login_screen': (context) => const LoginScreen(),
             '/register_screen': (context) => const RegisterScreen(),
             '/home_screen': (context) =>  const HomeScreen(),
             '/images_screen':(context)=>ImagesScreen(),
             '/upload_image_screen':(context)=>UploadImageScreen(),

           },
         ),

        );

  }
}
