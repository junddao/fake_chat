import 'package:fake_chat/view/style/size_config.dart';
import 'package:fake_chat/view/style/textstyles.dart';
import 'package:flutter/material.dart';

class ManualPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("사용법", style: MTextStyles.bold18Black),
      ),
      body: Center(
        child: Container(
          height: SizeConfig.screenHeight * 0.7,
          width: SizeConfig.screenWidth * 0.7,
          child: Center(
            child: Image.asset("assets/images/manual.png"),
          ),
        ),
      ),
    );
  }
}
