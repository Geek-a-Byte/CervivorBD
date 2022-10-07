import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';

class Cards extends StatelessWidget {
  const Cards({Key? key, this.doctor}) : super(key: key);
  final Doctor? doctor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffeeeeee), width: 2.0),
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
      width: 150, // width of the card
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 120, // height of the photo container
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        AssetImage('assets/images/${doctor!.doctorPicture}')),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              doctor!.doctorName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              doctor!.doctorSpecialty,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              doctor!.doctorHospital,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
