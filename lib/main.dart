import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'modules/onBoardingScreen.dart';
import 'shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();
  Bloc.observer = MyBlocObserver();

  var skippedLanding =await CachHelper.getData(key: "skippedLanding");
   token = await CachHelper.getData(key: "token");
  Widget startWidget;
  if(!skippedLanding||skippedLanding==null){
    startWidget = OnBoardingScreen();
  }else if(token==null){
    startWidget = const LoginScreen();}
  else{
    startWidget =  ShopLayout();
  }

  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;
  const MyApp(this.startWidget, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(),
          textTheme: GoogleFonts.ralewayTextTheme(),
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: primaryColor,
              onPrimary: onPrimaryColor,
              secondary: secondaryColor,
              onSecondary: onSecondaryColor,
              error: errorColor,
              onError: onErrorColor,
              background: backgroundColor,
              onBackground: onBackgroundColor,
              surface: surfaceColor,
              onSurface: onSurfaceColor)),
      home: startWidget,
    );
  }

}


class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
