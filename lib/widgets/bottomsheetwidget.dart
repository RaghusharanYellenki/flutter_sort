import 'package:flutter/material.dart';

import 'rounded_button_widget.dart';

class BottomSheetButtonWidget extends StatefulWidget {
  String selectedName = "";
  String buttonText = "";
  List modelList =[];
  Function(String) onSelectedText ;

  BottomSheetButtonWidget({Key? key,
    required this.selectedName,
    required this.buttonText,
    required this.modelList,
    required this.onSelectedText,
  }) : super(key: key);

  @override
  State<BottomSheetButtonWidget> createState() => _BottomSheetButtonWidgetState();
}

class _BottomSheetButtonWidgetState extends State<BottomSheetButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            builder: (BuildContext context) {
              String name = widget.selectedName;
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter localState) {
                    return SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100.0),
                                topRight: Radius.circular(100.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xffF3F5FC),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24.0),
                                      topRight: Radius.circular(24.0))),
                              padding: EdgeInsets.all(18),
                              child: Row(
                                children: [
                                  Text(
                                    "Select "+widget.buttonText,
                                    style: TextStyle(
                                      fontFamily: 'OpenSans-Regular',
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * .04,
                                  top: MediaQuery.of(context).size.width * .02,
                                  right: MediaQuery.of(context).size.width * .04,
                                  bottom: MediaQuery.of(context).size.width * .02),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  spacing: 8.0,
                                  runSpacing: 6.0,
                                  children: List<Widget>.generate(
                                      widget.modelList.length, (int index) {
                                    return InkWell(
                                      onTap: () {
                                        localState(() {
                                          name = widget.modelList[index];
                                        });
                                      },
                                      child: Chip(
                                        label: Text(
                                            widget.modelList[index],
                                            style:TextStyle(
                                              fontFamily: 'OpenSans-Regular',
                                              color: widget.modelList[index]
                                                  ==
                                                  name
                                                  ? Color(0xff3751FF)
                                                  : Color(0xFF2E313E),
                                              fontSize: 13,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w600,
                                            )),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: widget.modelList[index]
                                                  ==
                                                  name
                                                  ? Color(0xff3751FF)
                                                  : Color(0xffE0E4F0),
                                              width: widget.modelList[index] ==
                                                  name
                                                  ? 2
                                                  : 1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 6, right: 6, top: 8, bottom: 8),
                                        backgroundColor: Colors.white,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            Center(
                              child: RoundedButtonWidget(
                                  buttonTitle: "Apply",
                                  onButtonPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      widget.selectedName = name;
                                      widget.onSelectedText(name);
                                    });
                                  },
                                  color: Colors.blue,
                                  buttonTextColor: Colors.white,
                                  fontSize: 16,
                                  buttonPadding: EdgeInsets.all(12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  width: MediaQuery.of(context).size.height * .09),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          );
        },
        child: Container(
            height: MediaQuery.of(context).size.width * .22,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Color(0xffE0E4F0), width: 2),
            ),
            padding: EdgeInsets.all(12),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        widget.buttonText,
                        style:TextStyle(
                          fontFamily: 'OpenSans-Regular',
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                  Flexible(
                    child: Text(widget.selectedName,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'OpenSans-Regular',
                          color: Colors.blue,
                          fontSize: 13,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                        softWrap: true),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}