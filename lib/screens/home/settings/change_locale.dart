import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_save_app/factories/LocaleFactory.dart';
import 'package:my_save_app/providers/locale_provider.dart';
import 'package:provider/provider.dart';

class ChangeLocale extends StatelessWidget {
  const ChangeLocale({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        onSelected: (localeKey) async {
          Locale locale = LocaleFactory.create(localeKey);
          await context.read<LocaleProvider>().setLocale(locale);
        },
        itemBuilder: (context) => [
          PopupMenuItem(
              value: 'en', child: Text(AppLocalizations.of(context).english)),
          PopupMenuItem(
              value: 'de', child: Text(AppLocalizations.of(context).german)),
          PopupMenuItem(
              value: 'es', child: Text(AppLocalizations.of(context).spanish)),
          PopupMenuItem(
              value: 'fr', child: Text(AppLocalizations.of(context).french))
        ],
        child: const Icon(Icons.language),
      ),
    );
  }
}
