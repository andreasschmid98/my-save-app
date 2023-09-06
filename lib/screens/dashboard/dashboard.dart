import 'package:flutter/material.dart';
import 'entry/add_entry.dart';
import 'entry/entry_list.dart';
import 'overview/progress_overview.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Align(alignment: Alignment.center, child: Text('Dashboard')),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Übersicht',
                icon: Icon(Icons.stacked_bar_chart),
              ),
              Tab(
                text: 'Einträge',
                icon: Icon(Icons.format_list_bulleted),
              ),
            ],
          ),
        ),
        body: Container(
                margin: const EdgeInsets.all(30.0),
                child: TabBarView(
                  children: <Widget>[
                    Center(
                      child: ProgressOverview(),
                    ),
                    EntryList()
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return AddEntry();
                });
          },
          label: Text('Neuer Eintrag'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
