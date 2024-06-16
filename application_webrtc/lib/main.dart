import 'core/app_export.dart';

import 'domain/firebase_options.dart';
import 'web_rtc_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(
    AuthenticationRepository(),
    permanent: true,
  );
  Get.put(
    FirestoreRepository(),
    permanent: true,
  );
  Get.put(
    HelperKit(),
    permanent: true,
  );
  

  runApp(const WebRTCApp());
}
