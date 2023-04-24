import 'package:flutter/material.dart';
import 'package:fullstore/pages/adminlogin.dart';
import 'package:fullstore/pages/adminpanel.dart';
import 'package:fullstore/providers/addproductsate.dart';
import 'package:fullstore/providers/sidemenuprovider.dart';
import 'package:fullstore/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SideMenuProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DropDownItems(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: PagesRoutes.adminLogin,
        routes: {
          PagesRoutes.adminLogin: (_) => AdminLogin(),
          PagesRoutes.adminpanel: (_) => const AdminPanel(),
        },
      ),
    ),
  );
}
