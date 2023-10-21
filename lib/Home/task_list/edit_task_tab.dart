import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/dialog_utlis.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/list_provider.dart';

class EditTaskTab extends StatefulWidget {
  static const String routeName = 'edit_task_screen';

  @override
  State<EditTaskTab> createState() => _EditTaskTabState();
}

class _EditTaskTabState extends State<EditTaskTab> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  late ListProvider listProvider;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  Task? task;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (task == null) {
      task = ModalRoute.of(context)!.settings.arguments as Task;
      titleController.text = task!.title ?? '';
      descriptionController.text = task!.description ?? '';
      selectedDate = task!.dateTime!;
    }

    listProvider = Provider.of<ListProvider>(context);
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.edit_task,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: screenSize.height * .1,
            color: MyTheme.primaryLight,
          ),
          SingleChildScrollView(
            child: Center(
              child: Container(
                height: screenSize.height * .7,
                width: screenSize.width * .8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.edit_task,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextFormField(
                                controller: titleController,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Please Enter your Task Title..';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!
                                        .enter_your_tasktitle),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextFormField(
                                controller: descriptionController,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Please Enter your Task Description..';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .enter_your_taskdesc,
                                ),
                                maxLines: 3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  AppLocalizations.of(context)!.select_date,
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                            ),
                            InkWell(
                              onTap: () {
                                showCalender();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  editTask();
                                },
                                child: Text(AppLocalizations.of(context)!.save))
                          ],
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 100000)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void editTask() {
    if (formKey.currentState?.validate() == true) {
      task!.title = titleController.text;
      task!.description = descriptionController.text;
      task!.dateTime = selectedDate;
      DialogUtlis.showLoading(context, 'loading...');
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      FirebaseUtils.editTask(task!, authProvider.currentUser!.id!)
          .then((value) {
        DialogUtlis.hideLoading(context);
        DialogUtlis.showMessage(context, 'todo task edited succussfully',
            posActionName: 'OK', posAction: () {
          Navigator.pop(context);
          // Navigator.pop(context);
        });
      }).timeout(Duration(milliseconds: 500), onTimeout: () {
        print('to-do task is edited successfully');
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        Navigator.pop(context);
      });
    }
  }
}
//=================================

// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_app/my_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_app/dialog_utlis.dart';
// import 'package:todo_app/firebase_utils.dart';
// import 'package:todo_app/model/task.dart';
// import 'package:todo_app/my_theme.dart';
// import 'package:todo_app/providers/auth_provider.dart';
// import 'package:todo_app/providers/list_provider.dart';
// import '../../providers/app_config_provider.dart';
//
// import '../../providers/app_config_provider.dart';
//
// class EditTaskTab extends StatefulWidget {
//   static const String routeName = 'edit_task_screen';
//
//   @override
//   State<EditTaskTab> createState() => _EditTaskTabState();
// }
//
// class _EditTaskTabState extends State<EditTaskTab> {
//   DateTime selectedDate = DateTime.now();
//   var formKey = GlobalKey<FormState>();
//   late ListProvider listProvider;
//   var titleController = TextEditingController();
//   var descriptionController = TextEditingController();
//   Task? task;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (task == null) {
//       task = ModalRoute.of(context)!.settings.arguments as Task;
//       titleController.text = task!.title ?? '';
//       descriptionController.text = task!.description ?? '';
//       selectedDate = task!.dateTime!;
//     }
//
//     listProvider = Provider.of<ListProvider>(context);
//     var provider = Provider.of<AppConfigProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           AppLocalizations.of(context)!.edit_task,
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//       ),
//       body: Container(
//         margin: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.05,
//           vertical: MediaQuery.of(context).size.height * 0.06,
//         ),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color:
//                 provider.isDarkMode() ? MyTheme.blackDark : MyTheme.whiteColor),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Text(
//                 AppLocalizations.of(context)!.edit_task,
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: TextFormField(
//                   controller: titleController,
//                   validator: (text) {
//                     if (text == null || text.isEmpty) {
//                       return 'Please Enter your Task Title..';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                       hintText:
//                           AppLocalizations.of(context)!.enter_your_tasktitle),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: TextFormField(
//                   controller: descriptionController,
//                   validator: (text) {
//                     if (text == null || text.isEmpty) {
//                       return 'Please Enter your Task Description..';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     hintText: AppLocalizations.of(context)!.enter_your_taskdesc,
//                   ),
//                   maxLines: 3,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Text(AppLocalizations.of(context)!.select_date,
//                     style: Theme.of(context).textTheme.titleSmall),
//               ),
//               InkWell(
//                 onTap: () {
//                   showCalender();
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
//                     style: Theme.of(context).textTheme.titleSmall,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               // ElevatedButton(
//               //     onPressed: () {
//               //       editTask();
//               //     },
//               //     child: Padding(
//               //       padding: const EdgeInsets.symmetric(
//               //           vertical: 10, horizontal: 50),
//               //       child: Text(
//               //         AppLocalizations.of(context)!.save,
//               //         style: Theme.of(context)
//               //             .textTheme
//               //             .titleMedium!
//               //             .copyWith(color: MyTheme.whiteColor),
//               //       ),
//               //     )),
//               ElevatedButton(
//                   onPressed: () {
//                     editTask();
//                   },
//                   child: Text(AppLocalizations.of(context)!.save)),
//               SizedBox(
//                 height: 50,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   showCalender() async {
//     var chosenDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime.now(),
//         lastDate: DateTime.now().add(Duration(days: 100000)));
//     if (chosenDate != null) {
//       selectedDate = chosenDate;
//       setState(() {});
//     }
//   }
//
//   void editTask() {
//     if (formKey.currentState?.validate() == true) {
//       task!.title = titleController.text;
//       task!.description = descriptionController.text;
//       task!.dateTime = selectedDate;
//       DialogUtlis.showLoading(context, 'loading...');
//       var authProvider = Provider.of<AuthProvider>(context, listen: false);
//       FirebaseUtils.editTask(task!, authProvider.currentUser!.id!)
//           .then((value) {
//         DialogUtlis.hideLoading(context);
//         DialogUtlis.showMessage(context, 'todo task edited succussfully',
//             posActionName: 'OK', posAction: () {
//           Navigator.pop(context);
//           // Navigator.pop(context);
//         });
//       }).timeout(Duration(milliseconds: 500), onTimeout: () {
//         print('to-do task is edited successfully');
//         listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
//         Navigator.pop(context);
//       });
//     }
//   }
// }

/// session practice isDoneEdit

//=================================

// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_app/my_theme.dart';
//
// import '../../providers/app_config_provider.dart';
//
// class EditTaskTab extends StatefulWidget {
//   static const String routeName = 'edit_task_screen';
//
//   @override
//   State<EditTaskTab> createState() => _EditTaskTabState();
// }
//
// class _EditTaskTabState extends State<EditTaskTab> {
//   DateTime selectedDate = DateTime.now();
//
//   var formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<AppConfigProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           AppLocalizations.of(context)!.edit_task,
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//       ),
//       body: Container(
//         margin: EdgeInsets.symmetric(
//           horizontal: MediaQuery.of(context).size.width * 0.05,
//           vertical: MediaQuery.of(context).size.height * 0.06,
//         ),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color:
//                 provider.isDarkMode() ? MyTheme.blackDark : MyTheme.whiteColor),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Text(
//                 AppLocalizations.of(context)!.edit_task,
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       hintText: AppLocalizations.of(context)!.title,
//                       hintStyle: TextStyle(color: MyTheme.greyColor)),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       hintText: AppLocalizations.of(context)!.task_details,
//                       hintStyle: TextStyle(color: MyTheme.greyColor)),
//                   maxLines: 5,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Text(AppLocalizations.of(context)!.select_date,
//                     style: Theme.of(context).textTheme.titleSmall),
//               ),
//               InkWell(
//                 onTap: () {
//                   showCalender();
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
//                     style: Theme.of(context).textTheme.titleSmall,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               ElevatedButton(
//                   onPressed: () {},
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 50),
//                     child: Text(
//                       AppLocalizations.of(context)!.save,
//                       style: Theme.of(context)
//                           .textTheme
//                           .titleMedium!
//                           .copyWith(color: MyTheme.whiteColor),
//                     ),
//                   )),
//               SizedBox(
//                 height: 50,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   showCalender() async {
//     var chosenDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime.now(),
//         lastDate: DateTime.now().add(Duration(days: 100000)));
//     if (chosenDate != null) {
//       selectedDate = chosenDate;
//       setState(() {});
//     }
//   }
// }

/// ============================
///
/// session practice isDoneEdit
