import 'dart:ui';
import 'package:apple_shop/bloc/auhtentication/authentication_bloc.dart';
import 'package:apple_shop/ui/screens/cart_screen.dart';
import 'package:apple_shop/ui/screens/category_screen.dart';
import 'package:apple_shop/ui/screens/home_screen.dart';
import 'package:apple_shop/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bloc/basket/basket_bloc.dart';
import 'bloc/basket/basket_event.dart';
import 'bloc/category/category_bloc.dart';
import 'bloc/home/home_bloc.dart';
import 'bloc/home/home_event.dart';
import 'constants/colors.dart';
import 'data/model/addbasket.dart';
import 'data/repository/authentication_repository.dart';
import 'dependency_injection/di.dart';

void main(List<String> args) async {
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('BasketBox');
  initLocator();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 3;
  IAuthenticationRespository respository = locator.get();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: IndexedStack(
              index: selectedIndex,
              children: widgetList(),
            ),
            bottomNavigationBar: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: selectedIndex,
                  onTap: (int index) {
                    setState(
                      () {
                        selectedIndex = index;
                      },
                    );
                  },
                  selectedLabelStyle: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'SB',
                    color: CustomColor.blue,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: 'SB',
                    fontSize: 10,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  items: [
                    BottomNavigationBarItem(
                        icon: Image.asset('assets/images/icon_profile.png'),
                        activeIcon: Container(
                          child: Image.asset(
                              'assets/images/icon_profile_active.png'),
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: CustomColor.blue,
                                spreadRadius: -7,
                                blurRadius: 20,
                                offset: Offset(0.0, 13),
                              ),
                            ],
                          ),
                        ),
                        label: 'حساب کاربری'),
                    BottomNavigationBarItem(
                        icon: Image.asset('assets/images/icon_basket.png'),
                        activeIcon: Container(
                          child: Image.asset(
                              'assets/images/icon_basket_active.png'),
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: CustomColor.blue,
                                spreadRadius: -7,
                                blurRadius: 20,
                                offset: Offset(0.0, 13),
                              ),
                            ],
                          ),
                        ),
                        label: 'سبد خرید'),
                    BottomNavigationBarItem(
                        icon: Image.asset('assets/images/icon_category.png'),
                        activeIcon: Container(
                          child: Image.asset(
                              'assets/images/icon_category_active.png'),
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: CustomColor.blue,
                                spreadRadius: -7,
                                blurRadius: 20,
                                offset: Offset(0.0, 13),
                              ),
                            ],
                          ),
                        ),
                        label: 'دسته بندی'),
                    BottomNavigationBarItem(
                        icon: Image.asset('assets/images/icon_home.png'),
                        activeIcon: Container(
                          child:
                              Image.asset('assets/images/icon_home_active.png'),
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: CustomColor.blue,
                                spreadRadius: -7,
                                blurRadius: 20,
                                offset: Offset(0.0, 13),
                              ),
                            ],
                          ),
                        ),
                        label: 'خانه'),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

List<Widget> widgetList() {
  return <Widget>[
    BlocProvider(
        create: (context) => locator.get<AuthBloc>(),
        child: const LoginScreen()),
    BlocProvider(
      create: (context) {
        var bloc = locator.get<BasketBloc>();
        bloc.add(BasketFetchDataFromHive());
        return bloc;
      },
      child: const CartScreen(),
    ),
    BlocProvider(
      create: (context) => locator.get<CategoryBloc>(),
      child: const CategoryScreen(),
    ),
    BlocProvider(
      create: (conext) {
        var bloc = locator.get<HomeBloc>();
        bloc.add(HomeGetDataEvent());
        return bloc;
      },
      child: const HomeScreen(),
    )
  ];
}
