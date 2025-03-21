import 'package:activity_app/global/global-service.dart';
import 'package:activity_app/module/filter_screen/category_service.dart';
import 'package:activity_app/stores/category_store.dart';
import 'package:flutter/material.dart';
import 'package:activity_app/module/home/home.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'stores/province_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null);
  await provinceStore.loadProvinces();
  await categoryStore.loadCategories();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale("tr", "TR"),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("tr", "TR"),
      ],
      title: 'Activity App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData.light().copyWith(),
      home: Home(),
    );
  }
}
