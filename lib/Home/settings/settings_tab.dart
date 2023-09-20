import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/settings/language_bottom_sheet.dart';
import 'package:todo_app/Home/settings/theme_bottom_sheet.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/provider/app_config_provider.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppCongigProvider>(context);

    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Mode',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              showThemeBottomSheet();
            },
            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: provider.isDarkMode()
                        ? MyTheme.blackDark
                        : MyTheme.whiteColor
                    //color:MyTheme.whiteColor

                    ,
                    borderRadius: BorderRadius.circular(0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.isDarkMode() ? 'Dark ' : 'Light ',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: MyTheme.primaryLight),
                    ),
                    Icon(Icons.arrow_drop_down, color: MyTheme.primaryLight),
                  ],
                )),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Language',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              showLanguageSheet();
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: provider.isDarkMode()
                      ? MyTheme.blackDark
                      : MyTheme.whiteColor
                  //color:MyTheme.whiteColor

                  ,
                  borderRadius: BorderRadius.circular(0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chosen Language',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: MyTheme.primaryLight),
                  ),
                  Icon(Icons.arrow_drop_down, color: MyTheme.primaryLight)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: ((context) => ThemeBottomSheet()));
  }

  void showLanguageSheet() {
    showModalBottomSheet(
        context: context, builder: ((context) => LanguageBottomSheet()));
  }
}

// ======================
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../provider/app_config_provider.dart';
// import 'package:todo_app/Home/settings/theme_bottom_sheet.dart';
//
// class SettingsTab extends StatefulWidget {
//   @override
//   State<SettingsTab> createState() => _SettingsTabState();
// }
//
// class _SettingsTabState extends State<SettingsTab> {
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<AppCongigProvider>(context);
//     return Container(
//       margin: EdgeInsets.all(12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             'Theming',
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           InkWell(
//             onTap: () {
//               showThemeBottomSheet();
//             },
//             child: Container(
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   borderRadius: BorderRadius.circular(20)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     provider.isDarkMode() ? 'Dark Mode' : 'Light Mode',
//                     style: Theme.of(context).textTheme.titleSmall,
//                   ),
//                   Icon(Icons.arrow_drop_down),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   void showThemeBottomSheet() {
//     showModalBottomSheet(
//         context: context, builder: ((context) => ThemeBottomSheet()));
//   }
// }
