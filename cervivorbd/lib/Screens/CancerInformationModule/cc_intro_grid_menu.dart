import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';
import 'package:cervivorbd/Utils/Exports/widgets.dart';

class CCIntroGridMenu extends StatelessWidget {
  const CCIntroGridMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
      padding: EdgeInsets.zero,
      itemCount: introMenu.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => introPageNavigationMenu[index],
            ),
          ),
          child: Card(
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          const Color.fromARGB(255, 52, 1, 27).withOpacity(0.8),
                          BlendMode.darken),
                      fit: BoxFit.cover,
                      image: AssetImage(introPhotoMenu[index]))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(introMenu[index].label!,
                      style: const TextStyle(fontSize: 15, color: kWhiteColor)),
                ),
              ),
            ),
            margin: const EdgeInsets.only(left: 5.0, right: 0.0, top: 5.0),
          ),
          // Container(
          //   constraints: const BoxConstraints(
          //     maxHeight: 81,
          //   ),
          //   child: Column(
          //     children: [

          //       Container(
          //         constraints: const BoxConstraints(
          //           minHeight: 56,
          //           minWidth: 56,
          //           maxHeight: 69,
          //           maxWidth: 69,
          //         ),
          //       child: IntroButton2(
          //           label: introMenu[index].label!,
          //           onPressed:(){}),
          //       )
          //     ],
          //   ),
          // ),
        );
      },
    );
  }
}
