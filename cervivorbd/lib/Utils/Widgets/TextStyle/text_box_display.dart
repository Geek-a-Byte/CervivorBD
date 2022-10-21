import 'package:cervivorbd/Utils/Exports/packages.dart';

// ignore: must_be_immutable
class TextDisplayBox extends StatelessWidget {
  TextEditingController? controller;
  String? label;
  String? value;
  TextDisplayBox({Key? key, this.controller, this.label, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          height: MediaQuery.of(context).size.height / 14,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value!,
                style: GoogleFonts.lato(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
