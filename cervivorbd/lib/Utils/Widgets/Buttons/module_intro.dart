import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';
import 'package:cervivorbd/Utils/Exports/widgets.dart';

var moduleIntroMenu = [
  IntroButton2(label: 'হোম', onPressed: () {}),
  IntroButton2(label: 'প্রাথমিক স্ক্রিনিং', onPressed: () {}),
  IntroButton2(label: 'অ্যাপয়েন্টসমূহ', onPressed: () {}),
  IntroButton2(label: 'পাব্লিক ফোরাম', onPressed: () {}),
];

var moduleIntroPageNavigationMenu = [
  MainScreen(selectedIndex: 0, initialIndex: 0),
  MainScreen(selectedIndex: 1, initialIndex: 1),
  MainScreen(selectedIndex: 2, initialIndex: 2),
  MainScreen(selectedIndex: 3, initialIndex: 3),
];

var moduleIntroIconMenu = [
  Icons.home,
  FontAwesomeIcons.vial,
  Icons.calendar_today,
  Icons.forum,
];

class ModuleIntroGridMenu extends StatelessWidget {
  const ModuleIntroGridMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
      padding: EdgeInsets.zero,
      itemCount: moduleIntroMenu.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => moduleIntroPageNavigationMenu[index],
                  ),
                ),
            child: Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          moduleIntroIconMenu[index],
                          size: 50,
                        ),
                      ),
                      Text(moduleIntroMenu[index].label!,
                          style:
                              const TextStyle(fontSize: 15, color: kdarkPink)),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
