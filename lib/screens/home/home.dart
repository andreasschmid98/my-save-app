import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_save_app/providers/locale_provider.dart';
import 'package:my_save_app/providers/project_provider.dart';
import 'package:my_save_app/providers/theme_provider.dart';
import 'package:my_save_app/screens/home/project/create_project.dart';
import 'package:my_save_app/screens/home/project/project_list.dart';
import 'package:my_save_app/screens/home/settings/change_locale.dart';
import 'package:my_save_app/screens/home/settings/change_theme.dart';
import 'package:my_save_app/screens/shared/loading.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final providerInitialized = context.watch<ProjectProvider>().initialized;
    final localeInitialized = context.watch<LocaleProvider>().initialized;
    final themeInitialized = context.watch<ThemeProvider>().initialized;

    final appBarIconPath = context.watch<ThemeProvider>().appBarIconPath;

    return (themeInitialized && providerInitialized && localeInitialized)
        ? Scaffold(
            appBar: AppBar(
                centerTitle: true,
                leading: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 10.0),
                    child: Image.asset(
                      appBarIconPath!,
                    )),
                title: Text(AppLocalizations.of(context).allProjects),
                actions: const [ChangeTheme(), ChangeLocale()]),
            body: Container(
                margin: const EdgeInsets.all(30.0), child: const ProjectList()),
            floatingActionButton: SpeedDial(
                icon: Icons.add,
                spacing: 3,
                onOpen: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: const CreateProject(),
                        );
                      });
                }))
        : const Loading();
  }
}
