import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';

class DoctorAvailableHoursGrid extends StatefulWidget {
  final List availableHours = [];
  DoctorAvailableHoursGrid({Key? key, required availableHours})
      : super(key: key);

  @override
  State<DoctorAvailableHoursGrid> createState() =>
      _DoctorAvailableHoursGridState();
}

class _DoctorAvailableHoursGridState extends State<DoctorAvailableHoursGrid> {
  StreamController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = StreamController();
  }

  @override
  void dispose() {
    _controller!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.availableHours.isEmpty
        ? Container()
        : StreamBuilder(
            stream: _controller!.stream,
            builder: (context, snapshot) {
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                padding: EdgeInsets.zero,
                itemCount: widget.availableHours.length,
                itemBuilder: (BuildContext context, index) {
                  return OutlinedButton(
                    onPressed: () {},
                    child: SizedBox(
                      height: 300,
                      width: double.infinity,
                      // decoration: BoxDecoration(
                      //     borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      //     image: DecorationImage(
                      //         colorFilter: ColorFilter.mode(
                      //             const Color.fromARGB(255, 52, 1, 27).withOpacity(0.8),
                      //             BlendMode.darken),
                      //         fit: BoxFit.cover,
                      //         image: AssetImage(introPhotoMenu[index]))),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(widget.availableHours[index].toString(),
                              style: const TextStyle(
                                  fontSize: 15, color: kBlackColor900)),
                        ),
                      ),
                    ),
                  );
                },
              );
            });
  }
}
