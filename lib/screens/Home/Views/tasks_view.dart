import 'dart:io';

import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/models/campaign_model.dart';
import 'package:CHATS/router.dart';
import 'package:CHATS/screens/Home/Views/drawer_view.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:CHATS/theme_changer.dart';
import 'package:CHATS/utils/colors.dart';
import 'package:CHATS/utils/custom_text_field.dart';
import 'package:CHATS/utils/text.dart';
import 'package:CHATS/utils/ui_helper.dart';
import 'package:CHATS/widgets/custom_btn.dart';
import 'package:CHATS/widgets/error_widget_handler.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snack/snack.dart';

class TasksView extends StatefulWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  _TasksViewState createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? hTitle = 'My Tasks';
  int pageIndex = 0;
  late PageController _pageController;
  late TextEditingController _taskNameController;
  late TextEditingController _taskDescriptionController;
  final List<Map<String, dynamic>> data = [
    {
      "title": "Feed The Hungry campaign",
      "description": "Short Description",
      "dateCreated": "2022-03-13T23:43:45.321Z",
      "amount": "50,500",
      "status": "ongoing",
      "taskNumber": 4,
    },
    {
      "title": "Feed The Nation campaign",
      "description": "Short Description",
      "dateCreated": "2022-03-13T23:43:45.321Z",
      "amount": "50,500",
      "status": "completed",
      "taskNumber": 2,
    },
    {
      "title": "For Women campaign",
      "description": "Short Description",
      "dateCreated": "2022-03-13T23:43:45.321Z",
      "amount": "50,500",
      "status": "disbursed",
      "taskNumber": 4,
    },
    {
      "title": "Youth Empowerment campaign",
      "description": "Short Description",
      "dateCreated": "2022-03-13T23:43:45.321Z",
      "amount": "50,500",
      "status": "rejected",
      "taskNumber": 4,
    },
  ];
  late String? campaignId = locator<UserService>()
      .data
      ?.campaigns
      ?.firstWhereOrNull((element) => element.type == 'cash-for-work')
      ?.id
      .toString();

  // List of uploaded evidence files
  late List<File> evidences = [];
  // Update the picked TaskId
  late int? assignmentId;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: pageIndex);
    _taskNameController = TextEditingController();
    _taskDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor:
          ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Color.fromRGBO(250, 250, 250, 1)
              : primaryColorDarkMode,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                ? Colors.white
                : primaryColorDarkMode,
        title: CustomText(
          text: hTitle,
          fontFamily: 'Gilroy-medium',
          fontSize: 22,
          edgeInset: EdgeInsets.zero,
          textAlign: TextAlign.left,
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            pageIndex >= 1
                ? _pageController.previousPage(
                    duration: Duration(milliseconds: 300), curve: Curves.ease)
                : scaffoldKey.currentState!.openDrawer();
          },
          child: pageIndex >= 1
              ? Icon(
                  Icons.arrow_back_ios_new,
                  color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white,
                )
              : Image.asset(
                  "assets/Group.png",
                  color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
        ),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        // initialData: data,
        future: pageIndex >= 1
            ? null
            : campaignId == null
                ? null
                : locator<UserService>()
                    .getTasksForC4WCampaign(int.parse(campaignId!)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return ErrorWidgetHandler(onTap: () {
              setState(() {});
            });
          }

          if (snapshot.data is String) {
            return ErrorWidgetHandler(
              onTap: () {
                setState(() {});
              },
              message: snapshot.data.toString(),
            );
          }

          return Container(
            width: double.infinity,
            height: double.infinity,
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.white
                    : primaryColorDarkMode,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  pageIndex = index;
                  if (index < 1) evidences = [];
                });
              },
              physics: pageIndex >= 1
                  ? PageScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    buildTotalHeader((String? id) {
                      setState(() {
                        campaignId = id;
                      });
                    }),
                    SizedBox(height: 20),
                    StatefulBuilder(builder: (context, setState) {
                      return Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            locator<UserService>()
                                .getTasksForC4WCampaign(int.parse(campaignId!));
                            setState(() {});
                          },
                          child: ListView(
                            children: locator<UserService>().tasks != null
                                ? locator<UserService>()
                                    .tasks!
                                    .map(
                                      (item) => buildTaskCard(
                                        item.name,
                                        item.description,
                                        DateTime.parse(item.createdAt!)
                                            .toLocal()
                                            .toString(),
                                        item.amount?.toStringAsFixed(2),
                                        item.isCompleted!
                                            ? 'completed'
                                            : 'ongoing',
                                        () async {
                                          // Call pick task endpoint, if task has already been picked
                                          var resp =
                                              await locator<UserService>()
                                                  .pickC4WTask(item.id);
                                          print(
                                              {"TASK VIEW RESP DETAILS", resp});
                                          var snackBar = SnackBar(
                                              content: CustomText(
                                            text: resp?['message'] ==
                                                    'you have already pick a this task'
                                                ? 'You have already picked this task before'
                                                : resp?['message'],
                                            color: ThemeBuilder.of(context)!
                                                        .getCurrentTheme() ==
                                                    Brightness.light
                                                ? Colors.white
                                                : Colors.black,
                                          ));
                                          if (resp?['status'] != 'success' &&
                                              resp?['message'] !=
                                                  'you have already pick a this task') {
                                            return snackBar.show(context);
                                          } else if (resp?['message'] ==
                                              'you have already pick a this task') {
                                            setState(() {
                                              assignmentId =
                                                  locator<UserService>()
                                                      .pickedTasks!
                                                      .firstWhere((element) =>
                                                          element.taskId ==
                                                          item.id)
                                                      .id!;
                                            });

                                            snackBar.show(context);

                                            _taskNameController.text =
                                                item.name!;
                                            _taskDescriptionController.text =
                                                item.description!;
                                            _pageController.nextPage(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.ease);
                                          } else {
                                            snackBar.show(context);

                                            if (kDebugMode)
                                              print({
                                                "Task pick response",
                                                resp?["data"],
                                                resp?["data"]["id"].runtimeType
                                              });

                                            // Update the TaskId
                                            setState(() {
                                              assignmentId = resp?["data"]["id"]
                                                          .runtimeType ==
                                                      String
                                                  ? int.parse(
                                                      resp?["data"]["id"])
                                                  : resp?["data"]["id"];
                                            });

                                            _taskNameController.text =
                                                item.name!;
                                            _taskDescriptionController.text =
                                                item.description!;
                                            _pageController.nextPage(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.ease);
                                          }
                                        },
                                      ),
                                    )
                                    .toList()
                                : [
                                    Container(
                                      child: CustomText(
                                        text:
                                            'You have not joined any cash for work campaigns yet',
                                        fontSize: 21,
                                        // fontWeight: FontWeight.w600,
                                        fontFamily: 'Gilroy-medium',
                                        textAlign: TextAlign.center,
                                        color: ThemeBuilder.of(context)!
                                                    .getCurrentTheme() ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    SizedBox(
                                      height: 52,
                                      child: CustomButton(
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                              context, campaigns);
                                        },
                                        child: CustomText(
                                          edgeInset: EdgeInsets.zero,
                                          text: 'Go to campaigns',
                                          color: Colors.white,
                                          fontFamily: 'Gilroy-bold',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                          ),
                        ),
                      );
                    }),
                  ]),
                ),
                // Submit Task Page #1
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: _taskNameController,
                        hintText: 'Enter task name',
                        enabled: false,
                        label: CustomText(
                          text: 'Task name',
                          edgeInset: EdgeInsets.zero,
                          fontFamily: 'Gilroy-medium',
                          textAlign: TextAlign.left,
                          fontSize: 19,
                          color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      CustomText(
                        text: 'Activity description',
                        edgeInset: EdgeInsets.zero,
                        fontFamily: 'Gilroy-medium',
                        textAlign: TextAlign.left,
                        fontSize: 19,
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _taskDescriptionController,
                        decoration: InputDecoration(
                          hintText: 'Describe an activity',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                width: .5, color: Constants.borderColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  width: 1, color: Constants.purple)),
                          fillColor:
                              ThemeBuilder.of(context)!.getCurrentTheme() ==
                                      Brightness.light
                                  ? Colors.white
                                  : primaryColorDarkMode,
                          filled: true,
                        ),
                        maxLines: 8,
                      ),
                      SizedBox(height: 30),
                      CustomText(
                        text: 'Photos (Tap to upload)',
                        edgeInset: EdgeInsets.zero,
                        fontFamily: 'Gilroy-medium',
                        textAlign: TextAlign.left,
                        fontSize: 19,
                        color: ThemeBuilder.of(context)!.getCurrentTheme() ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.65,
                          shrinkWrap: true,
                          children: getSelectedEvidences(),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: CustomButton(
                          bgColor: Constants.usedGreen,
                          // margin: EdgeInsets.zero,
                          borderColor: Constants.usedGreen,
                          useOverlay: true,
                          child: CustomText(
                            text: 'Submit Task',
                            edgeInset: EdgeInsets.zero,
                            fontFamily: 'Gilroy-bold',
                            fontSize: 22,
                            color: Colors.white,
                            textAlign: TextAlign.center,
                          ),
                          onTap: () async {
                            if (assignmentId != null && evidences.isNotEmpty) {
                              // Make API Call to submit task evidence
                              var resp = await locator<UserService>()
                                  .submitTaskEvidence(
                                      assignmentId!,
                                      _taskDescriptionController.text,
                                      evidences);

                              var snackBar = SnackBar(
                                  content: Text(
                                resp?['message'],
                              ));
                              snackBar.show(context);
                            } else if (evidences.isEmpty) {
                              SnackBar(
                                  content: Text(
                                'You have to upload some evidences for the task before submitting',
                              )).show(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> getSelectedEvidences() {
    if (evidences.isEmpty)
      return [
        GestureDetector(
          onTap: () async {
            PickedFile? file = await ImagePicker().getImage(
              source: ImageSource.gallery,
              preferredCameraDevice: CameraDevice.front,
              maxHeight: 720,
              maxWidth: 720,
            );

            if (file != null) {
              setState(() {
                evidences.add(File(file.path));
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image_placeholder.png'),
              ),
            ),
          ),
        ),
        // Container(
        //   color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
        //       ? Colors.white
        //       : primaryColorDarkMode,
        //   child: Icon(
        //     Icons.add,
        //     color:
        //         ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
        //             ? Colors.blueGrey
        //             : Colors.white,
        //   ),
        // ),
      ];
    List<Widget> widgetList = evidences.map((e) {
      return GestureDetector(
        onTap: () async {
          PickedFile? file = await ImagePicker().getImage(
            source: ImageSource.gallery,
            preferredCameraDevice: CameraDevice.front,
            maxHeight: 720,
            maxWidth: 720,
          );

          int fileIdx = evidences.indexOf(e);

          if (file != null) {
            setState(() {
              evidences[fileIdx] = File(file.path);
            });
          }
        },
        child: Image.file(e),
      );
    }).toList();

    // Append to end of evidence list
    widgetList.add(GestureDetector(
      onTap: () async {
        PickedFile? file = await ImagePicker().getImage(
          source: ImageSource.gallery,
          preferredCameraDevice: CameraDevice.front,
          maxHeight: 720,
          maxWidth: 720,
        );

        if (file != null) {
          setState(() {
            evidences.add(File(file.path));
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color:
                ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
                    ? Colors.black
                    : Colors.white,
          ),
          borderRadius: BorderRadius.circular(15),
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.white
              : primaryColorDarkMode,
        ),
        child: Icon(
          Icons.add,
          color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
              ? Colors.blueGrey
              : Colors.white,
        ),
      ),
    ));
    return widgetList;
  }

  //? component for header info of the screen
  Widget buildTotalHeader(Function(String?)? onCampaignChange) {
    return Row(
      children: [
        Expanded(
          child: Cash4WorkDropDown(
            onChange: (value) {
              print({value, "c4w change drop down"});
              onCampaignChange!(value);
            },
            prevId: campaignId,
          ),
          // Container(
          //   width: double.infinity,
          //   padding: EdgeInsets.all(18),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(5),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(.2),
          //         offset: Offset(0, 5),
          //         blurRadius: 10,
          //         spreadRadius: 2,
          //       ),
          //     ],
          //   ),
          //   child: CustomText(
          //     text: 'Total: $total Tasks',
          //     edgeInset: EdgeInsets.zero,
          //     fontFamily: 'Gilroy-light',
          //     textAlign: TextAlign.center,
          //     fontSize: 19,
          //   ),
          // ),
        ),
        SizedBox(width: 10),
        Container(
          width: 60,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                offset: Offset(0, 5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: FittedBox(
            child: Icon(Icons.filter_alt_outlined, color: Colors.black),
          ),
        )
      ],
    );
  }

  //? the card for each task from campaigns
  Widget buildTaskCard(
    String? title,
    String? description,
    String? dateCreated,
    String? amount,
    String? status,
    // int? taskNumber,
    Function? viewTaskDetails,
  ) {
    Container tag(value, width) => Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: CustomText(
            fontStyle: FontStyle.normal,
            text: value,
            fontFamily: 'Gilroy-light',
            fontSize: width * .04545,
            edgeInset: EdgeInsets.zero,
            color: value == 'ongoing'
                ? Color.fromRGBO(13, 21, 234, 1)
                : value == 'pending'
                    ? Color.fromRGBO(112, 72, 49, 1)
                    : value == 'completed'
                        ? Color.fromRGBO(51, 113, 56, 1)
                        : value == 'rejected'
                            ? Color.fromRGBO(228, 44, 102, 1)
                            : value == 'disbursed'
                                ? Color.fromRGBO(100, 106, 134, 1)
                                : Colors.white,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: value == 'ongoing'
                ? Color.fromRGBO(182, 207, 255, 1)
                : value == 'pending'
                    ? Color.fromRGBO(255, 234, 182, 1)
                    : value == 'completed'
                        ? Color.fromRGBO(209, 247, 196, 1)
                        : value == 'rejected'
                            ? Color.fromRGBO(255, 205, 199, 1)
                            : value == 'disbursed'
                                ? Color.fromRGBO(241, 241, 241, 1)
                                : Colors.blueGrey,
          ),
        );

    Row rowInfo(String? key, String? value, width) => Row(
          mainAxisAlignment: key != 'Status'
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            CustomText(
              text: '$key:',
              edgeInset: EdgeInsets.zero,
              fontFamily: 'Gilroy-light',
              fontSize: width * .04545,
              color: Colors.black.withOpacity(.4),
            ),
            key != 'Status' ? SizedBox(width: 0) : SizedBox(width: 20),
            key != 'Status'
                ? CustomText(
                    text: value,
                    edgeInset: EdgeInsets.zero,
                    fontFamily: 'Gilroy-light',
                    fontSize: width * .04545,
                    color: Colors.black.withOpacity(.4),
                  )
                : tag(value, width),
          ],
        );

    double width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            offset: Offset(5, 5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            edgeInset: EdgeInsets.zero,
            fontFamily: 'Gilroy-bold',
            fontSize: width * .04545,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                text:
                    '${description!.length > 30 ? description.substring(0, 30) + '...' : description}',
                fontSize: 18,
                fontFamily: 'Gilroy-light',
                edgeInset: EdgeInsets.zero,
              )
            ],
          ),
          // SizedBox(height: 25),
          // rowInfo('Description', description, width),
          SizedBox(height: 25),
          rowInfo('Amount', amount, width),
          SizedBox(height: 25),
          rowInfo('Created', dateCreated?.substring(0, 10), width),
          // SizedBox(height: 25),
          // rowInfo('Status', status, width),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .38,
                height: 52,
                child: CustomButton(
                  bgColor: Colors.white,
                  // margin: EdgeInsets.zero,
                  borderColor: Constants.usedGreen,
                  loadColor: Constants.usedGreen,
                  useOverlay: true,
                  child: CustomText(
                    text: 'Report',
                    edgeInset: EdgeInsets.zero,
                    fontFamily: 'Gilroy-medium',
                    fontSize: 22,
                    color: Constants.usedGreen,
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => viewTaskDetails!(),
                ),
              ),
              tag(status, width),
            ],
          ),
        ],
      ),
    );
  }
}

class Cash4WorkDropDown extends StatefulWidget {
  const Cash4WorkDropDown({Key? key, this.onChange, this.prevId})
      : super(key: key);

  final Function(String?)? onChange;
  final String? prevId;

  @override
  State<Cash4WorkDropDown> createState() => _Cash4WorkDropDownState();
}

class _Cash4WorkDropDownState extends State<Cash4WorkDropDown> {
  late String? _c4wVal;
  late List<Campaign>? displayItems;

  @override
  void initState() {
    super.initState();
    _c4wVal = widget.prevId != null
        ? widget.prevId
        : locator<UserService>()
            .data
            ?.campaigns
            ?.firstWhereOrNull((element) => element.type == 'cash-for-work')
            ?.id
            .toString();
    displayItems = locator<UserService>()
        .data
        ?.campaigns
        ?.where((element) => element.type == 'cash-for-work')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Align(
      //   alignment: Alignment.centerLeft,
      //   child: CustomText(
      //     text: 'Bank Name',
      //     textAlign: TextAlign.left,
      //     color: ThemeBuilder.of(context)!.getCurrentTheme() == Brightness.light
      //         ? Colors.black
      //         : Colors.white,
      //   ),
      // ),
      // SizedBox(height: 10),
      SizedBox(
        width: double.infinity,
        // height: 60,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                offset: Offset(0, 5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: DropdownButton<String>(
            value: _c4wVal,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            iconEnabledColor: Constants.usedGreen,
            iconDisabledColor: Constants.usedGreen,
            iconSize: 28,
            elevation: 4,
            isExpanded: true,
            underline: Container(
              color: Colors.transparent,
              width: 0,
              height: 0,
            ),
            hint: CustomText(
              text: 'Pick Cash 4 Work Campaign',
              fontFamily: 'Gilroy-medium',
              fontWeight: FontWeight.bold,
              color: Constants.usedGreen,
              edgeInset: EdgeInsets.zero,
            ),
            style: const TextStyle(
                color: Constants.usedGreen,
                fontSize: 21,
                fontWeight: FontWeight.w600),
            // underline: Container(
            //   height: 2,
            //   color: Colors.green,
            // ),
            onChanged: (String? newValue) {
              print(newValue);
              setState(() {
                _c4wVal = newValue!;
              });
              widget.onChange!(newValue);
            },
            items:
                displayItems?.map<DropdownMenuItem<String>>((Campaign value) {
              return DropdownMenuItem<String>(
                value: value.id.toString(),
                child: Text(
                  'Campaign: ${value.title!}',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ]);
  }
}
