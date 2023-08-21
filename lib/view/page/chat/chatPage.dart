import 'package:bubble/bubble.dart';
import 'package:fake_chat/data/message_data.dart';
import 'package:fake_chat/data/selected_data.dart';
import 'package:fake_chat/view/style/colors.dart';
import 'package:fake_chat/view/style/size_config.dart';
import 'package:fake_chat/view/style/textstyles.dart';
import 'package:flutter/material.dart';

import '../../../util/admob_service.dart';

class ChatPage extends StatefulWidget {
  ChatPage(this._selectedData);
  @override
  _ChatPageState createState() => _ChatPageState();

  final SelectedData _selectedData;
}

class _ChatPageState extends State<ChatPage> {
  List<MessageData> _messageDatas = [];
  late TextEditingController _textController;
  late DateTime pDateTime;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _textController = new TextEditingController();
    pDateTime = DateTime.now();

    if (AdMobService().interstitialAd != null) {
      AdMobService().interstitialAd!.show();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffb2c7da),
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(widget._selectedData.yourId),
      actions: [
        Icon(Icons.search),
        SizedBox(
          width: 8,
        ),
        Icon(Icons.menu),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }

  _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
              child: Text(
                getFakeDate(),
                style: MTextStyles.regular12White,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: _messageDatas.length,
              itemBuilder: (context, index) {
                if (_messageDatas[index].isMine) {
                  return returnMyMessage(index);
                } else {
                  return returnYourMessage(index);
                }
              },
            ),
          ),
        ),
        Container(
          // height: 34,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                InkWell(
                  child: Icon(
                    Icons.add_box_outlined,
                    color: MColors.greyish,
                  ),
                  onTap: () {
                    setState(() {
                      _messageDatas.add(
                        MessageData(
                          isMine: false,
                          message: _textController.text,
                          t: getFakeTime(),
                        ),
                      );
                      scrollToBottom();
                      _textController.clear();
                    });
                  },
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    controller: _textController,
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      InkWell(
                        // onTap: () {
                        //   setState(() {
                        //     _messageDatas.add(
                        //       MessageData(
                        //         isMine: true,
                        //         deviderDate: true,
                        //         message: getFakeDate(),
                        //         t: getFakeTime(),
                        //       ),
                        //     );
                        //   });
                        // },
                        child: Icon(
                          Icons.sentiment_satisfied_sharp,
                          color: MColors.greyish,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        child: Text("#", style: TextStyle(fontSize: 24, color: MColors.greyish)),
                        onTap: () {
                          setState(() {
                            _messageDatas.add(
                              MessageData(
                                isMine: true,
                                message: _textController.text,
                                t: getFakeTime(),
                              ),
                            );
                            scrollToBottom();
                            _textController.clear();
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void scrollToBottom() {
    final bottomOffset = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  Widget returnMyMessage(int index) {
    if (index == 0 && _messageDatas[index].isMine == true) {
      return returnMyFirstMessage(index);
    } else if (index > 0 && _messageDatas[index].isMine == true && _messageDatas[index - 1].isMine == false) {
      {
        return returnMyFirstMessage(index);
      }
    } else if (index > 0 && _messageDatas[index].t.minute != _messageDatas[index - 1].t.minute) {
      return returnMyFirstMessage(index);
    } else {
      return returnMyNormalMessage(index);
    }
  }

  Widget returnMyFirstMessage(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  getTime(index),
                  Flexible(child: getMyFirstMessageBox(index)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget returnMyNormalMessage(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  getTime(index),
                  Flexible(child: getMyNormalMessageBox(index)),
                ],
              ),
            ),
            // Expanded(child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }

  Widget returnYourMessage(int index) {
    if (index == 0 && _messageDatas[index].isMine == false) {
      return returnYourFirstMessage(index);
    } else if (index > 0 && _messageDatas[index].isMine == false && _messageDatas[index - 1].isMine == true) {
      {
        return returnYourFirstMessage(index);
      }
    } else if (index > 0 && _messageDatas[index].t.minute != _messageDatas[index - 1].t.minute) {
      return returnYourFirstMessage(index);
    } else {
      return returnYourNormalMessage(index);
    }
  }

  Widget returnYourFirstMessage(index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CircleAvatar(
            //   backgroundImage: FileImage(widget._selectedData.yourImage),
            //   radius: 20,
            // ),

            Container(
              width: 40.0,
              height: 40.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(widget._selectedData.yourImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget._selectedData.yourId),
                SizedBox(
                  height: 4,
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: getYourFirstMessageBox(index),
                      ),
                      getTime(index),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget returnYourNormalMessage(int index) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      width: SizeConfig.screenWidth * 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // CircleAvatar(
          //   backgroundColor: Colors.transparent,
          //   radius: 20,
          // ),
          SizedBox(
            width: 48,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(child: getYourNormalMessageBox(index)),
                    getTime(index),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget getYourNormalMessageBox(int index) {
    return Bubble(
      // margin: BubbleEdges.only(top: 10),

      nip: BubbleNip.leftTop,
      showNip: false,
      color: MColors.white,
      radius: Radius.circular(8.0),
      child: Text(
        _messageDatas[index].message,
        style: MTextStyles.regular14BlackColor,
      ),
    );
  }

  Widget getMyNormalMessageBox(int index) {
    return Bubble(
      // margin: BubbleEdges.only(top: 10),

      nip: BubbleNip.rightTop,
      showNip: false,

      color: MColors.kakao_yellow,
      radius: Radius.circular(8.0),
      child: Text(
        _messageDatas[index].message,
        style: MTextStyles.regular14BlackColor,
      ),
    );
  }

  Widget getYourFirstMessageBox(int index) {
    return Bubble(
      // margin: BubbleEdges.only(top: 10),

      // alignment: Alignment.topLeft,
      nip: BubbleNip.leftTop,
      nipOffset: 3.0,
      color: MColors.white,
      radius: Radius.circular(8.0),
      child: Text(
        _messageDatas[index].message,
        style: MTextStyles.regular14BlackColor,
      ),
    );
  }

  Widget getMyFirstMessageBox(int index) {
    return Bubble(
      // margin: BubbleEdges.only(top: 10),

      // alignment: Alignment.topRight,
      nip: BubbleNip.rightTop,
      nipOffset: 3.0,
      color: MColors.kakao_yellow,
      radius: Radius.circular(8.0),
      child: Text(
        _messageDatas[index].message,
        style: MTextStyles.regular14BlackColor,
        maxLines: 10,
      ),
    );
  }

  Widget getTime(int index) {
    if (_messageDatas.length > index + 1) {
      if (_messageDatas[index].isMine == _messageDatas[index + 1].isMine) {
        if (_messageDatas[index].t.minute == _messageDatas[index + 1].t.minute) {
          return SizedBox.shrink();
        }
      }
    }

    if (_messageDatas[index].t.hour > 12) {
      int tempHour = _messageDatas[index].t.hour - 12;
      int tempMinutes = _messageDatas[index].t.minute;
      String tempSMinutes;
      if (tempMinutes < 10) {
        tempSMinutes = "0" + tempMinutes.toString();
      } else
        tempSMinutes = tempMinutes.toString();
      return Text("오후 ${tempHour}:" + tempSMinutes, style: MTextStyles.regular10Grey06);
    } else {
      int tempHour = _messageDatas[index].t.hour;
      int tempMinutes = _messageDatas[index].t.minute;
      String tempSMinutes;
      if (tempMinutes < 10) {
        tempSMinutes = "0" + tempMinutes.toString();
      } else
        tempSMinutes = tempMinutes.toString();
      return Text(
        "오전 ${tempHour}:" + tempSMinutes,
        style: MTextStyles.regular10Grey06,
      );
    }
  }

  TimeOfDay getFakeTime() {
    Duration d = DateTime.now().difference(pDateTime);

    int fakeMinute = (widget._selectedData.time.minute + d.inMinutes) % 60;
    int fakeHour = (widget._selectedData.time.hour + d.inHours) % 24;

    TimeOfDay fakeTime = new TimeOfDay(hour: fakeHour, minute: fakeMinute);

    return fakeTime;
  }

  String getFakeDate() {
    String year = widget._selectedData.pickedDate.year.toString() + "년 ";
    String month = widget._selectedData.pickedDate.month.toString() + "월 ";
    String day = widget._selectedData.pickedDate.day.toString() + "일 ";
    late String dayOfTheWeek;
    switch (widget._selectedData.pickedDate.weekday) {
      case 1:
        dayOfTheWeek = "월요일";
        break;
      case 2:
        dayOfTheWeek = "화요일";
        break;
      case 3:
        dayOfTheWeek = "수요일";
        break;
      case 4:
        dayOfTheWeek = "목요일";
        break;
      case 5:
        dayOfTheWeek = "금요일";
        break;
      case 6:
        dayOfTheWeek = "토요일";
        break;
      case 7:
        dayOfTheWeek = "일요일";
        break;
      default:
    }

    String fakeDate = year + month + day + dayOfTheWeek;

    return fakeDate;
  }

  returnDateLine(int index) {}
}
