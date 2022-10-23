import 'package:cervivorbd/Utils/Exports/packages.dart';

class loginSignupButton extends StatelessWidget {
  final String? label;
  final GestureTapCallback? onPressed;
  final IconData? icon;
  const loginSignupButton({@required this.onPressed, this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: .5),
            side: const BorderSide(
                width: 1.0, color: Color.fromARGB(255, 125, 180, 248))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(2.5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    label!,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 125, 180, 248),
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 5),
                Icon(icon, color: const Color.fromARGB(255, 113, 156, 255)),
              ],
            ),
          ),
        ));
  }
}
