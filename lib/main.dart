import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as river;
import 'package:provider/provider.dart';
import 'package:while_app/repository/firebase_repository.dart';
import 'package:while_app/theme/pallete.dart';
import 'package:while_app/utils/routes/routes_name.dart';
import 'package:while_app/view_model/current_user_provider.dart';
import 'package:while_app/view_model/firebasedata.dart';
import 'package:while_app/view_model/profile_controller.dart';
import 'utils/routes/routes.dart';
import 'view_model/reel_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.manual,
  //   overlays: [
  //     SystemUiOverlay.top,
  //   ],
  // );
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  runApp(const river.ProviderScope(child: MyApp()));
}

class MyApp extends river.ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, river.WidgetRef ref) {

    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        // systemNavigationBarIconBrightness: Brightness.light,
        // systemNavigationBarColor: Colors.transparent,
        // systemNavigationBarDividerColor: Colors.transparent,
        // systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
    //     overlays: [SystemUiOverlay.bottom]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
            create: (_) => FirebaseAuthMethods(FirebaseAuth.instance)),
        Provider<ReelController>(create: (_) => ReelController()),
        StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        Provider(create: (_) => CurrentUserProvider()),
        Provider(
          create: (_) => FireBaseDataProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ref.watch(themeNotifierProvider),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
