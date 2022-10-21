import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';

class TopDoctorsCard extends StatelessWidget {
  const TopDoctorsCard({Key? key, this.doctor}) : super(key: key);

  final Doctor? doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        color: Colors.transparent,
        height: 80,
        width: MediaQuery.of(context).size.width - 32,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'images/${doctor!.doctorPicture}',
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  width: 88,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/${doctor!.doctorPicture}',
                      ),
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
                            doctor!.doctorIsOpen! ? 'Open' : 'Close',
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
