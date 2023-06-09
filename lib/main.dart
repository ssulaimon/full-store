// ignore_for_file: unused_local_variable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fullstore/cloudfunctions/userauth.dart';
import 'package:fullstore/firebase_options.dart';
import 'package:fullstore/pages/adminlogin.dart';
import 'package:fullstore/pages/adminpanel.dart';
import 'package:fullstore/pages/comfirmation.dart';
import 'package:fullstore/pages/home.dart';
import 'package:fullstore/pages/loginscreen.dart';
import 'package:fullstore/pages/onboardinguser.dart';
import 'package:fullstore/pages/shoppinglist.dart';
import 'package:fullstore/providers/addproductsate.dart';
import 'package:fullstore/providers/onboardingstate.dart';
import 'package:fullstore/providers/pickedimagestate.dart';
import 'package:fullstore/providers/selecttable.dart';
import 'package:fullstore/providers/shoppinglist.dart';
import 'package:fullstore/providers/sidemenuprovider.dart';
import 'package:fullstore/providers/uploadingitem.dart';
import 'package:fullstore/providers/usergender.dart';
import 'package:fullstore/utils/routes.dart';
import 'package:fullstore/pages/createaccount.dart';
import 'package:fullstore/widgets/bottomnavstate.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SideMenuProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DropDownItems(),
        ),
        ChangeNotifierProvider(
          create: (context) => OnboardingState(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserGender(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavState(),
        ),
        ChangeNotifierProvider(
          create: (context) => PickImageStae(),
        ),
        ChangeNotifierProvider(
          create: (context) => UploadingItemLoading(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectTable(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShoppingList(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShoppingLenght(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: deviceType(),
        routes: {
          PagesRoutes.adminLogin: (_) => AdminLogin(),
          PagesRoutes.adminpanel: (_) => const AdminPanel(),
          PagesRoutes.onboarding: (_) => const OnboardingUser(),
          PagesRoutes.userLogin: (_) => LoginScreen(),
          PagesRoutes.createAccount: (_) => CreateAccount(),
          PagesRoutes.comfirmation: (_) => const Confirmation(),
          PagesRoutes.home: (_) => const Home(),
          PagesRoutes.shopping: (_) => const UserShoppingList()
        },
      ),
    ),
  );
}

String deviceType() {
  if (kIsWeb) {
    return PagesRoutes.adminLogin;
  } else {
    return checkUser();
  }
}

String checkUser() {
  if (UserAuthentication.firebaseAuth.currentUser != null) {
    return PagesRoutes.home;
  } else {
    return PagesRoutes.onboarding;
  }
}
