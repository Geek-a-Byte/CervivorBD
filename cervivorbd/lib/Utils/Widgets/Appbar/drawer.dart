import 'package:cervivorbd/Utils/Exports/screens.dart';
import 'package:cervivorbd/Utils/Exports/packages.dart';
import 'package:cervivorbd/Utils/Exports/firebase.dart';
import 'package:cervivorbd/Utils/Exports/theme.dart';


class Drawer2 extends StatelessWidget {
  const Drawer2({Key? key}) : super(key: key);

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
                    onTap: () {
                      Navigator.push(
                        (context),
                        MaterialPageRoute(builder: (context) => UserDetails()),
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
            leading: const Icon(Icons.privacy_tip),
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()));
  }
}
