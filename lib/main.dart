import 'package:flutter/material.dart';
import 'package:movie_app/core/config/theme/themes.dart';
import 'package:movie_app/router/router.dart';
import 'package:provider/provider.dart';

import 'core/common/providers/connectivity_provider.dart';
import 'core/common/providers/theme_provider.dart';
import 'core/common/providers/translation_provider.dart';
import 'core/common/widgets/keys.dart';
import 'core/di/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TranslationProvider()..getSavedLocale(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ConnectivityProvider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return Consumer2<TranslationProvider, ThemeProvider>(
    //   builder: (context, translationProvider, themeProvider, child) {
    //   },
    // );
    final translationProvider = Provider.of<TranslationProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      locale: translationProvider.locale,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: router,
    );
  }
}
