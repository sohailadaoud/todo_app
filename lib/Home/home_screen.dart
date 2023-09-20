import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/settings/settings_tab.dart';
import 'package:todo_app/Home/task_list/add_task_bottom_sheet.dart';
import 'package:todo_app/Home/task_list/task_list_tab.dart';
import 'package:todo_app/provider/app_config_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppCongigProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Task List'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskButtomSheet();
        },
        child: Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [TaskListTab(), SettingsTab()];

  void showAddTaskButtomSheet() {
    showModalBottomSheet(
        context: context, builder: ((context) => AddTaskBottomSheet()));
  }
}
