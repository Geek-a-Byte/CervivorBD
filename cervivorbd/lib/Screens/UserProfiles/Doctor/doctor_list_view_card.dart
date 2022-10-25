import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Theme/color_constants.dart';

class ListViewCard extends StatelessWidget {
  const ListViewCard({Key? key, this.doctor}) : super(key: key);
  final Doctor? doctor;
  @override
  Widget build(BuildContext context) {
    // final doctor = ModalRoute.of(context)!.settings.arguments as Doctor;
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffeeeeee), width: 1.0),
        color: Colors.white38,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: const [
          BoxShadow(
            color: Colors.white10,
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 120,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: 'assets/images/${doctor!.doctorPicture}',
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        AssetImage('assets/images/${doctor!.doctorPicture!}'),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: doctor!.fullname!,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      doctor!.fullname!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                Text(
                  '${doctor!.doctorHospital}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline5,
                ),Text(
                  '${doctor!.doctorSpeciality}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 136,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 24,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: doctor!.doctorIsOpen!
                              ? kGreenLightColor
                              : kRedLightColor,
                        ),
                        child: Text(
                          doctor!.doctorIsOpen! ? 'Available' : 'Not Available',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: doctor!.doctorIsOpen!
                                        ? kGreenColor
                                        : kRedColor,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
