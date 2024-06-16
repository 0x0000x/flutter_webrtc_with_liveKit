import '../core/app_export.dart';
import 'widgets/auth_button.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: AuthButtonWidget(
              onPressed: () async {
                // await AuthenticationRepository.instance
                //     .loginWithEmailAndPassword(
                //   'amgadcyber@gmail.com',
                //   '12345678',
                // );
                await AuthenticationRepository.instance.continueWithGoogle();
              },
              logoPath: "assets/images/google_icon.png",
              authText: "الإستمرار عبر جوجل",
            ),
          ),
        ],
      ),
    );
  }
}
