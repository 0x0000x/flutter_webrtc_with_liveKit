import 'core/app_export.dart';
import 'views/splash_view.dart';

class WebRTCApp extends StatelessWidget {
  const WebRTCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      logWriterCallback: appLogWriterCallback,
      debugShowCheckedModeBanner: false,
      enableLog: true,
      title: appName,
      locale: const Locale('ar','YE'),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
          backgroundColor: Colors.black87,
          brightness: Brightness.dark,
        ),
      ),
      initialBinding: BindingsBuilder(() {
       
        Get.lazyPut(
          () => MainController(),
          fenix: true,
        );
      }),
      home: const SplashView(),
    );
  }
}
