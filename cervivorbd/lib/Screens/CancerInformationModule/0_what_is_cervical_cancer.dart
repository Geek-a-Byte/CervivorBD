import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Exports/widgets.dart';

class WhatisCervicalCancer extends StatelessWidget {
  const WhatisCervicalCancer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 35.0, left: 25.0, right: 25.0),
        child: Column(
          children: [
            Heading(label: introMenu[0].label),
            const SizedBox(height: 5),
            Text(introCCMenu[0],
                style: const TextStyle(fontSize: 15, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
