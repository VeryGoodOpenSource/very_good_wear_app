import 'package:flutter/material.dart';
import 'package:very_good_wearos_app/ambient_mode/ambient_mode.dart';
import 'package:very_good_wearos_app/counter/counter.dart';
import 'package:very_good_wearos_app/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AmbientModeListener.instance,
      child: const CounterPage(),
      builder: (context, ambientModeActive, child) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            // This makes elements such as buttons have a fewer pixels in
            // padding and general spacing. good for devices with limited screen
            // real state.
            visualDensity: VisualDensity.compact,
            brightness: Brightness.dark,
            // When in ambient mode, change the apps color scheme
            colorScheme: ambientModeActive
                ?  const ColorScheme.dark(
                    primary: Colors.white10,
                    onBackground: Colors.white10,
                    onSurface: Colors.white10,
                    background: Colors.black,
                    surface: Colors.black,
                  )
                : const ColorScheme.dark(
                    primary: Color(0xFF00B5FF),
                  ),
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: child,
        );
      },
    );
  }
}
