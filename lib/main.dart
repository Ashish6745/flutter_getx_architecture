import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvcapp/localization/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialing sharedpreferences
  final prefs = await SharedPreferences.getInstance();
  //  fetching the previously saved language if any
  final saved = prefs.getString('locale');

  // if any language is saved previously parse it otherwise english by defaul
  final initialLocale = _localeFromString(saved) ?? const Locale('en', 'US');
  // Run the app and pass initial locale + prefs instance
  runApp(MyApp(initialLocale: initialLocale, prefs: prefs));
}

/// Helper function: Converts 'en_US' string into a Locale object
Locale? _localeFromString(String? s) {
  if (s == null) return null; // no saved locale
  final parts = s.split('_');
  if (parts.length == 2) return Locale(parts[0], parts[1]); // e.g. 'en_US'
  return Locale(parts[0]); // e.g. 'en'
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  final SharedPreferences prefs;
  const MyApp({super.key, required this.initialLocale, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: initialLocale,
      fallbackLocale: const Locale('en', 'US'),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: 'appbar_title'.tr,prefs: prefs),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title,required this.prefs});
  final String title;
  final SharedPreferences prefs;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _toggleLanguage() async {
    print('jkdgdkjgdkghdfgdfg');
    final isEnglish = Get.locale?.languageCode == 'en';
    final newLocale = isEnglish
        ? const Locale('hi', 'IN')
        : const Locale('en', 'US');
    Get.updateLocale(newLocale);

     final localeString = '${newLocale.languageCode}_${newLocale.countryCode ?? ''}'
        .replaceAll(RegExp(r'_+$'), ''); // cleanup trailing underscores
    await widget.prefs.setString('locale', localeString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('appbar_title'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('counter_text'.tr),
            Text('0', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleLanguage,
        tooltip: 'Toggle Language',
        child: const Icon(Icons.language),
      ),
    );
  }
}
