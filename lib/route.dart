import 'package:fake_chat/view/page/chat/chatPage.dart';
import 'package:fake_chat/view/page/manual/manualPage.dart';
import 'package:fake_chat/view/page/select/selectPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;

    switch (settings.name) {
      case 'SelectPage':
        return CupertinoPageRoute(builder: (_) => SelectPage());
      case 'ManualPage':
        return CupertinoPageRoute(builder: (_) => ManualPage());
      case 'ChatPage':
        return CupertinoPageRoute(
            builder: (_) => ChatPage(selectedDate: arguments));

      // case 'ClassProceedingPage':
      //   return CupertinoPageRoute(
      //       builder: (_) => ClassProceedingPage(id: arguments));

      // case 'GuestProfilePage':
      //   return CupertinoPageRoute(
      //       builder: (_) => ChangeNotifierProvider(
      //             create: (_) =>
      //                 OtherUserProfileProvider('${UserInfo.myProfile.id}'),
      //             child: GuestProfilePage(),
      //           ));

      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child:
                        Text('${settings.name} 는 lib/route.dart에 정의 되지 않았습니다.'),
                  ),
                ));
    }
  }
}
