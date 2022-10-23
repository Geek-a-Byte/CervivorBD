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
      color: Colors.transparent,
      height: 100,
      width: MediaQuery.of(context).size.width,
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
            width: 16,
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
                  '${doctor!.doctorSpeciality} • ${doctor!.doctorHospital}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline4,
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
                          horizontal: 13,
                          vertical: 3,
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
