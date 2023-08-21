import 'dart:io';

import 'package:fake_chat/data/selected_data.dart';
import 'package:fake_chat/view/style/colors.dart';
import 'package:fake_chat/view/style/size_config.dart';
import 'package:fake_chat/view/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../util/admob_service.dart';

class SelectPage extends StatefulWidget {
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  late DateTime pickedDate;
  late TimeOfDay time;

  File? _yourImage;
  final picker = ImagePicker();

  final TextEditingController myIdController = new TextEditingController();
  final TextEditingController yourIdController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
    AdMobService().getNewInterstitial();
  }

  @override
  void dispose() {
    myIdController.dispose();
    yourIdController.dispose();
    super.dispose();
  }

  Future getYourImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _yourImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        child: Text(
          "사용법",
          style: MTextStyles.bold12Black,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed("ManualPage");
        },
      ),
    );
  }

  _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("선택창", style: MTextStyles.bold18Black),
      centerTitle: true,
      elevation: 0.0,
    );
  }

  _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("채팅 시작 시간", style: MTextStyles.bold16Black),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () async {
                      _pickDate().then((value) {
                        _pickTime();
                      });
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/calendar.svg'),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${pickedDate.year}년 ${pickedDate.month}월 ${pickedDate.day}일  " +
                              "${time.hour}시 ${time.minute}분",
                          style: MTextStyles.regular16Pinkish_grey,
                        ),
                      ],
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

                  Text("내 대화명", style: MTextStyles.bold16Black),
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

                  divideLine(),
                  SizedBox(height: 16),
                  Text("상대방 아이디", style: MTextStyles.bold16Black),

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
                  Text("상대방 사진", style: MTextStyles.bold16Black),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(width: 16),
                      InkWell(
                        onTap: () {
                          getYourImage();
                        },
                        child: Container(
                          height: 44,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(24)),
                              border: Border.all(color: MColors.white_three, width: 1),
                              color: MColors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/camera_g.svg'),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text('사진 선택', style: MTextStyles.medium12BrownishGrey),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      //사진 추가 listview

                      Container(
                        height: 70,
                        width: 70,
                        child: _yourImage == null
                            ? SizedBox.shrink()
                            : CircleAvatar(
                                backgroundImage: FileImage(_yourImage!),
                                radius: 20,
                              ),
                      ),
                    ],
                  ),
                  divideLine(),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: MColors.tomato,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            minimumSize: Size(SizeConfig.screenWidth, 50),
          ),
          onPressed: () async {
            if (myIdController.text == "" || yourIdController.text == "" || _yourImage == null) {
              showAlertDialog(context);
            } else {
              // 초기에 광고 하나 보여주자

              SelectedData selectedData = new SelectedData(
                pickedDate: pickedDate,
                myId: myIdController.text,
                yourId: yourIdController.text,
                time: time,
                // myImage: _myImage,
                yourImage: _yourImage!,
              );

              Navigator.of(context).pushNamed("ChatPage", arguments: selectedData);
            }
          },
          child: Text(
            "채팅방 열기",
            style: MTextStyles.bold12White,
          ),
        ),
      ],
    );
  }

  Widget divideLine() {
    return Container(
      height: 1,
      width: SizeConfig.screenWidth - 40,
      decoration: BoxDecoration(
          border: Border.all(
        color: MColors.white_three,
      )),
    );
  }

  loadImage() {}

  Future<void> _pickDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
  }

  void _pickTime() async {
    TimeOfDay? t = await showTimePicker(context: context, initialTime: time);
    if (t != null) {
      setState(() {
        time = t;
      });
    }
  }

  Future<void> showAlertDialog(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('에러.'),
          content: Text("누락된 항목이 있습니다."),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
          ],
        );
      },
    );
  }
}
