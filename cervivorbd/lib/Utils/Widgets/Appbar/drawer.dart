import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';

// ignore: must_be_immutable
class Drawer2 extends StatelessWidget {
  String? uid;
  Patient? p;
  Drawer2({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Image(
              alignment: Alignment.topLeft,
              image: AssetImage('assets/images/logo22.png'),
              fit: BoxFit.contain,
            ),
            decoration: BoxDecoration(
              color: kdarkPink,
            ),
          ),
          Consumer<AuthModel>(
            builder: (_, auth, __) => auth.isSignedIn
                ? ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('My Profile'),
                    onTap: () async {
                      DocumentSnapshot result = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .get();
                      p = Patient.fromMap(result);
                      Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => UserDetails(patient: p)),
                      );
                    },
                  )
                : Container(),
          ),
          Consumer<AuthModel>(
            builder: (_, auth, __) => auth.isSignedIn
                ? ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Edit Profile'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                : Container(),
          ),
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text('F. A. Q'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Consumer<AuthModel>(
            builder: (_, auth, __) => auth.isSignedIn
                ? ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('LogOut'),
                    onTap: () {
                      logout(context);
                    },
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => MainScreen(selectedIndex: 0, initialIndex: 0),
    ));
  }
}
