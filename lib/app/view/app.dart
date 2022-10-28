// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:products_repository/products_repository.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/home/home.dart';
import 'package:thrive_shop/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key, required this.productsRepository});

  final ProductsRepository productsRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: AppColors.lightColorScheme,
      ),
      darkTheme:
          ThemeData(useMaterial3: true, colorScheme: AppColors.darkColorScheme),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocalizations.supportedLocales,
      home: RepositoryProvider.value(
        value: productsRepository,
        child: const HomePage(),
      ),
    );
  }
}
