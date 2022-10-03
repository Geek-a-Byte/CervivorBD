import 'package:cervivorbd/utils/Widgets/FormOptions/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class TestCheckBox extends StatelessWidget {
  const TestCheckBox(
      {Key? key,
      this.question,
      required this.checkboxButtons,
      required this.checkboxesController,
      required this.type})
      : super(key: key);
  final String? question;
  final List<String> checkboxButtons;
  final GroupButtonController checkboxesController;
  final bool type;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Text(
            ////////! quesitons
            question!,
            style: theme.textTheme.headline5,
          ),
        ),
        GroupButton(
            ////////! checkboxcontroller
            controller: checkboxesController,
            isRadio: type,
            options: const GroupButtonOptions(
              groupingType: GroupingType.column,
            ),
            ////////! checkboxbutton
            buttons: checkboxButtons,
            buttonIndexedBuilder: (selected, index, context) {
              return CheckBoxTile(
                //////! checkboxbutton
                title: checkboxButtons[index],
                selected: selected,
                onTap: () {
                  if (!selected) {
                    ////! checkboxcontroller
                    checkboxesController.selectIndex(index);
                    return;
                  }
                  ////! checkboxcontroller
                  checkboxesController.unselectIndex(index);
                },
              );
              
            }
            
            )
      ],
    );
  }
}
