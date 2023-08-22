import 'package:demo/layout/shop_layout_Screen.dart';
import 'package:demo/modules/login/login_screen.dart';
import 'package:demo/modules/search/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/on_boarding/on_boarding_screen.dart';
import 'shared/components/constants.dart';
import 'shared/cubit/cubit.dart';
import 'shared/networks/local/cache_helper.dart';
import 'shared/networks/remote/dio_helper.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget?widget;
  bool? onBoarding=CacheHelper.getData(key:'onBoarding');
token=CacheHelper.getData(key: 'token');
print(token);
if(onBoarding!=null){
  if(token!=null) widget=ShopLayoutScreen();

 else widget=LoginScreen();
}
else widget=OnBoardingScreen();

  runApp(MyApp(onboarding:onBoarding,startwidget:widget));

}
class MyApp extends StatelessWidget {
  bool?onboarding;
  Widget?startwidget;
  MyApp({this.onboarding, required this.startwidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create:(context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData(),
        ),
        BlocProvider(
            create:(context)=>SearchCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:false ,
        home:startwidget,
      ),
    );
  }
}
