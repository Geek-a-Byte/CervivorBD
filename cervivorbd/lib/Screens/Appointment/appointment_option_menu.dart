import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/widgets/Buttons/intro_button.dart';

class OptionGridMenu extends StatelessWidget {
  const OptionGridMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 1,
      ),
      padding: EdgeInsets.zero,
      itemCount: optionMenu.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 81,
            ),
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 60,
                    minWidth: 60,
                    maxHeight: 100,
                    maxWidth: 100,
                  ),
                  child: IntroButton3(
                      label: optionMenu[index].label!, onPressed: () {}),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
