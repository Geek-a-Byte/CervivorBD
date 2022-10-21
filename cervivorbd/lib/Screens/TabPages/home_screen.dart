import 'package:cervivorbd/Utils/Exports/widgets.dart';
import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

final List<String> imgList = [
  'assets/images/video-ss-1.png',
  'assets/images/video-ss-2.png',
  'assets/images/video-ss-3.png',
  'assets/images/video-ss-4.png',
  'assets/images/video-ss-5.png',
  'assets/images/video-ss-8.png',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(item,
                      fit: BoxFit.cover, width: 500.0, height: 500.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        '${imgList.indexOf(item) + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ))
    .toList();

class ComplicatedImageDemo extends StatelessWidget {
  const ComplicatedImageDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imageSliders,
    );
  }
}

class _HomeTabPageState extends State<HomeTabPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  // TabController? tabController;
  // int selectedIndex = 0;
  // onItemClicked(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //     tabController!.index = selectedIndex;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            // "${loggedInUser.firstName} ${loggedInUser.secondName}"
            // Text(
            //   'স্বাগতম ${loggedInUser.fullname}!',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            const ComplicatedImageDemo(),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 5.0, top: 8.0, bottom: 0),
                  child: Text(
                    'জরায়ুর ক্যান্সার সম্পর্কে জানুন',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const CCIntroGridMenu(),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 5.0, top: 8.0, bottom: 0),
                  child: Text(
                    'বাংলাদেশে স্ক্রিনিং সেন্টারগুলো সম্পর্কে জানুন',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[0],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[1],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[2],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[3],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[4],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[5],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: centerMenu[6],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    'বিশেষজ্ঞ ডাক্তারগণ',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                TextButton2(
                    label: 'সব দেখুন ->',
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      // builder: (c) => const LoginScreen()));
                    }),
              ],
            ),
            // const TopDoctorsList(),
            const SizedBox(
              height: 20,
            ),

            // const CenterGridMenu(),
          ]),
        ),
      )),
    );
  }
}
