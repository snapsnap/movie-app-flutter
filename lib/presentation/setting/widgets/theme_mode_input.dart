import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/custom_extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/common/providers/theme_provider.dart';

class ThemeModeInput extends StatelessWidget {
  const ThemeModeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: [20, 20].es,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Theme Mode",
            style: context.textTheme.titleLarge,
          ),
          10.spacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Switch Dark Mode",
                style: context.textTheme.bodyMedium,
              ),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
