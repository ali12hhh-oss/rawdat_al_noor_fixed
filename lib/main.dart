void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة التخزين المحلي
  await Hive.initFlutter();
  await Hive.openBox('progressBox');
  
  final prefs = await SharedPreferences.getInstance();
  
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  
  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProgressProvider(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => AudioProvider(prefs), // ✅ هذا هو التعديل
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(prefs),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(prefs),
        ),
      ],
      // ... باقي الكود كما هو
    );
  }
}
