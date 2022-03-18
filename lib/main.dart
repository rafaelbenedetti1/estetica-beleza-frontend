import 'package:estetica_beleza/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const bool isProduction = bool.fromEnvironment('dart.vm.product');
  await DotEnv.dotenv
      .load(fileName: isProduction ? ".env" : ".env.development");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale.fromSubtags(languageCode: 'pt_BR');
  void setLocale(Locale value) {
    setState(
      () {
        _locale = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estetica & Beleza App',
      locale: _locale,
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('pt', "pt_BR")],
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
