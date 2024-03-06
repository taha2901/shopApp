import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubits/changes_cubit/chng_cubit.dart';
import 'package:shopapp/cubits/shop_cubit/shops_cubit.dart';
import 'package:shopapp/helper/api.dart';
import 'package:shopapp/helper/cach.dart';
import 'package:shopapp/layout/shop_app/shop_layout.dart';
import 'package:shopapp/styles/themes.dart';
import 'package:shopapp/views/login.dart';
import 'package:shopapp/views/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await ChachHelper.init();
  bool? isDark = ChachHelper.getData(key: 'isDark') ?? true;
  Widget widget;
  bool? onBoarding = ChachHelper.getData(key: 'onBoarding');
  String? token = ChachHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  // print(onBoarding);
  runApp(MyApp(
    isDark: isDark!,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isDark, required this.startWidget});
  final bool isDark;
  final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopsCubit()..getHomeData()..getCategoryData()..getFavouriteData()..getUsersData(),
        ),
        BlocProvider(
          create: (context) => ChangeCubit()..changeAppMode(fromShared: isDark),
        )
      ],
      child: BlocConsumer<ChangeCubit, ChangeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: BlocProvider.of<ChangeCubit>(context).isDark
                ? ThemeMode.light
                : ThemeMode.dark,
            home: startWidget,
          );
        },
      ),
    );
  }
}
