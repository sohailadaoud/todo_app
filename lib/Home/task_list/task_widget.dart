import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/task_list/edit_task_tab.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/my_theme.dart';

import '../../model/task.dart';
import '../../providers/app_config_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/list_provider.dart';

class TaskWidgetItem extends StatelessWidget {
  Task task;

  TaskWidgetItem({required this.task});

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);

    return Container(
      margin: EdgeInsets.all(10),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) async {
                await FirebaseUtils.deleteTaskFromFireStore(
                    task, authProvider.currentUser!.id!);

                listProvider
                    .getAllTasksFromFireStore(authProvider.currentUser!.id!);
                print('Task deleted successfully!');
              },

              // onPressed: (context) {
              //   //delete task
              //   FirebaseUtils.deleteTaskFromFireStore(
              //           task, authProvider.currentUser!.id!)
              //       .timeout(Duration(milliseconds: 500), onTimeout: () {
              //     print('todo deleted successfully !');
              //     listProvider
              //         .getAllTasksFromFireStore(authProvider.currentUser!.id!);
              //   });
              // },
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(EditTaskTab.routeName);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: MyTheme.whiteColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  height: 80,
                  width: 4,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(task.title ?? '',
                          // AppLocalizations.of(context)!.title_task ?? '',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(task.description ?? '',
                          //AppLocalizations.of(context)!.description,
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                  ],
                )),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor),
                  child: Icon(
                    Icons.check,
                    size: 30,
                    color: MyTheme.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
