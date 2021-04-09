import 'package:fake_chat/view/style/colors.dart';
import 'package:fake_chat/view/style/size_config.dart';
import 'package:fake_chat/view/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class SelectPage extends StatefulWidget {
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  String _setTime;
  String _startTime;

  final TextEditingController myIdController = new TextEditingController();
  final TextEditingController yourIdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("선택창"),
      elevation: 0.0,
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("시간", style: MTextStyles.bold16Black),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('assets/icons/calendar.svg'),
              SizedBox(
                width: 8,
              ),
              Text(
                setMeetingTime(),
                style: MTextStyles.regular16Pinkish_grey,
              ),
            ],
          ),
          SizedBox(height: 16),
          // 구분줄
          Container(
            height: 1,
            width: SizeConfig.screenWidth - 40,
            decoration: BoxDecoration(
                border: Border.all(
              color: MColors.white_three,
            )),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text("내 대화명", style: MTextStyles.bold16Black),
            ],
          ),
          SizedBox(height: 16),

          Container(
            height: 54,
            // width: SizeConfig.screenWidth - 200,
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: MColors.pinkish_grey, width: 1)),
            child: TextFormField(
              controller: myIdController,
              // onChanged: (value){
              //   if(value.length >15)
              //     _meetingNameController.text = value.substring(0,value.length);
              // },
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
              ],
              decoration: InputDecoration(
                hintText: "자신의 대화명을 입력해주세요..",
                hintStyle: MTextStyles.medium16WhiteThree,
                labelStyle: TextStyle(color: Colors.transparent),
                counterText: '',
                border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          // 구분줄
          Container(
            height: 1,
            width: SizeConfig.screenWidth - 40,
            decoration: BoxDecoration(
                border: Border.all(
              color: MColors.white_three,
            )),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text("상대방 아이디", style: MTextStyles.bold16Black),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 54,
            // width: SizeConfig.screenWidth - 200,
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: MColors.pinkish_grey, width: 1)),
            child: TextFormField(
              controller: yourIdController,
              // onChanged: (value){
              //   if(value.length >15)
              //     _meetingNameController.text = value.substring(0,value.length);
              // },
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
              ],
              decoration: InputDecoration(
                hintText: "상대방 대화명을 입력해주세요..",
                hintStyle: MTextStyles.medium16WhiteThree,
                labelStyle: TextStyle(color: Colors.transparent),
                counterText: '',
                border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          // 구분줄
          Container(
            height: 1,
            width: SizeConfig.screenWidth - 40,
            decoration: BoxDecoration(
                border: Border.all(
              color: MColors.white_three,
            )),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  String setMeetingTime() {
    if (_startTime == null) {
      _setTime = '00월 00일 오후 00:00';
    } else {
      DateTime startDt = DateTime.parse(_startTime);
      // DateTime endDt = DateTime.parse(_meetingEndTime);

      int startHour;
      String startType;

      if (startDt.hour > 12) {
        startHour = startDt.hour - 12;
        startType = '오후';
      } else {
        startHour = startDt.hour;
        startType = '오전';
      }

      // if (endDt.hour > 12) {
      //   endHour = endDt.hour - 12;
      //   endType = '오후';
      // } else {
      //   endHour = endDt.hour;
      //   endType = '오전';
      // }

      _setTime = startDt.year.toString() +
          '년 ' +
          startDt.month.toString().padLeft(2, '0') +
          '월 ' +
          startDt.day.toString().padLeft(2, '0') +
          '일 ' +
          startType.toString() +
          ' ' +
          startHour.toString().padLeft(2, '0') +
          ':' +
          startDt.minute.toString().padLeft(2, '0');
      // +
      // ' ~ ' +
      // endType.toString() +
      // ' ' +
      // endHour.toString().padLeft(2, '0') +
      // ':' +
      // endDt.minute.toString().padLeft(2, '0');
    }
    return _setTime;
  }
}
