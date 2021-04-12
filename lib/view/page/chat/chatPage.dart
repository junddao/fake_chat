import 'package:fake_chat/data/message_data.dart';
import 'package:fake_chat/data/selected_data.dart';
import 'package:fake_chat/view/style/colors.dart';
import 'package:fake_chat/view/style/textstyles.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage({SelectedData selectedDate}) : _selectedData = selectedDate;
  @override
  _ChatPageState createState() => _ChatPageState();

  final SelectedData _selectedData;
}

class _ChatPageState extends State<ChatPage> {
  List<MessageData> _messageDatas = [];
  TextEditingController _textController;
  DateTime pDateTime;

  @override
  void initState() {
    super.initState();
    _textController = new TextEditingController();

    pDateTime = DateTime.now();
  }

  @override
  void dispose() {
    _textController.dispose();
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
        Expanded(
          child: ListView.builder(
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
                      Icon(
                        Icons.sentiment_satisfied_sharp,
                        color: MColors.greyish,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        child: Text("#",
                            style: TextStyle(
                                fontSize: 24, color: MColors.greyish)),
                        onTap: () {
                          setState(() {
                            _messageDatas.add(
                              MessageData(
                                isMine: true,
                                message: _textController.text,
                                t: getFakeTime(),
                              ),
                            );
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

  Widget returnMyMessage(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          getTime(index),
          getMessageBox(index),
        ],
      ),
    );
  }

  Widget returnYourMessage(int index) {
    if (_messageDatas.last.isMine == false &&
        _messageDatas.last.t.minute < getFakeTime().minute) {
      return returnFirstMessage(index);
    } else {
      return returnNormalMessage(index);
    }
  }

  Widget returnFirstMessage(index) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: FileImage(widget._selectedData.yourImage),
          radius: 20,
        ),
        Column(
          children: [
            Text(widget._selectedData.yourId),
            getMessageBox(index),
          ],
        ),
      ],
    );
  }

  Widget returnNormalMessage(int index) {}

  TimeOfDay getFakeTime() {
    Duration d = DateTime.now().difference(pDateTime);

    int fakeMinute = (widget._selectedData.time.minute + d.inMinutes) % 60;
    int fakeHour = (widget._selectedData.time.hour + d.inHours) % 24;

    TimeOfDay fakeTime = new TimeOfDay(hour: fakeHour, minute: fakeMinute);

    return fakeTime;
  }

  Widget getMessageBox(int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          border: Border.all(
              color: _messageDatas[index].isMine == true
                  ? MColors.kakao_yellow
                  : MColors.white,
              width: 8),
          color: _messageDatas[index].isMine == true
              ? MColors.kakao_yellow
              : MColors.white),
      child: Text(
        _messageDatas[index].message,
        style: MTextStyles.regular18black,
      ),
    );
  }

  Widget getTime(int index) {
    if (_messageDatas[index].t.hour > 12) {
      int tempHour = _messageDatas[index].t.hour - 12;
      int tempMinutes = _messageDatas[index].t.minute;
      String tempSMinutes;
      if (tempMinutes < 10) {
        tempSMinutes = "0" + tempMinutes.toString();
      } else
        tempSMinutes = tempMinutes.toString();
      return Text("오후 ${tempHour}:" + tempSMinutes,
          style: MTextStyles.regular10Grey06);
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
}
