import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/custom_extensions.dart';

import '../widgets/theme_mode_input.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: 10.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                20.spacing,
                Text(
                  'Setting of Profile',
                  style: context.textTheme.titleMedium,
                ),
                5.spacing,
                const Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.language,
                      applyTextScaling: true,
                    ),
                    title: Text('Change Language'),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      applyTextScaling: true,
                    ),
                  ),
                ).onTap(
                  (context) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const ThemeModeInput();
                      },
                    );
                  },
                ),
                const Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.location_city,
                      applyTextScaling: true,
                    ),
                    title: Text('Choose Country'),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      applyTextScaling: true,
                    ),
                  ),
                ).onTap(
                  (context) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const ThemeModeInput();
                      },
                    );
                  },
                ),
                20.spacing,
                Text(
                  'Setting of UI',
                  style: context.textTheme.titleMedium,
                ),
                5.spacing,
                const Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.brightness_6,
                      applyTextScaling: true,
                    ),
                    title: Text('Theme Mode'),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      applyTextScaling: true,
                    ),
                  ),
                ).onTap(
                  (context) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const ThemeModeInput();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
