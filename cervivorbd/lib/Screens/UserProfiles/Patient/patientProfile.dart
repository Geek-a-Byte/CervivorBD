// ignore_for_file: file_names

import 'package:cervivorbd/Screens/UserProfiles/Patient/patient.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Widgets/TextStyle/text_box_display.dart';

// ignore: must_be_immutable
class UserDetails extends StatefulWidget {
  Patient? patient;
  UserDetails({Key? key, this.patient}) : super(key: key);
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Material(
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                Text(
                  'User Details',
                  style: Theme.of(context).textTheme.headline2,
                ),
                TextDisplayBox(label: "Name", value: widget.patient!.fullname!),
                TextDisplayBox(label: "Email", value: widget.patient!.email!),
                TextDisplayBox(
                    label: "Phone No", value: widget.patient!.phonenumber!),
              ],
            ),
          ),
        ),
      )
    ]));
  }
}
