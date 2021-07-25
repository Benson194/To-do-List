import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/config/constant.dart';
import 'package:to_do_list/helper/date_time_helper.dart';
import 'package:to_do_list/helper/ui_helper.dart';
import 'package:to_do_list/model/NoteModel.dart';
import 'package:to_do_list/repository/repository.dart';
import 'package:to_do_list/screens/create_screen/create_screen.dart';
import 'package:to_do_list/screens/home_screen/home_screen_bloc.dart';
import 'package:to_do_list/screens/home_screen/home_screen_event.dart';
import 'package:to_do_list/screens/home_screen/home_screen_state.dart';
import 'package:to_do_list/services/local_db.dart';
import 'package:to_do_list/theme/color.dart';
import 'package:to_do_list/theme/font.dart';
import 'package:to_do_list/theme/shape.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NoteModel> noteModelList = [
    // NoteModel(
    //     id: 0,
    //     startDateTime: DateTime.parse("1969-07-20 20:18:04Z"),
    //     endDateTime: DateTime.parse("1969-07-20 24:48:04Z"),
    //     completed: false,
    //     title: "Note 1"),
    // NoteModel(
    //     id: 1,
    //     startDateTime: DateTime.parse("1969-07-20 20:18:04Z"),
    //     endDateTime: DateTime.parse("1969-07-21 20:48:04Z"),
    //     completed: false,
    //     title: "Note 2"),
    // NoteModel(
    //     id: 2,
    //     startDateTime: DateTime.parse("1969-07-20 20:18:04Z"),
    //     endDateTime: DateTime.parse("1969-07-21 00:48:04Z"),
    //     completed: false,
    //     title: "Note 3")
  ];
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _openDB();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  _openDB() async {
    await Repository().openDB().then((value) {
      _homeBloc.add(GetNoteEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          centerTitle: false,
          title: Text(
            appName,
            textAlign: TextAlign.start,
            style: appBarTextStyle,
          ),
        ),
        body: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: noteModelList.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(cardBorderRadius),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(cardBorderRadius),
                                topLeft: Radius.circular(cardBorderRadius),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  Text(
                                    noteModelList[i].title == null
                                        ? ""
                                        : noteModelList[i].title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: heading1TextStyle,
                                  ),
                                  SizedBox(height: 15),
                                  Row(children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            "Start Date",
                                            textAlign: TextAlign.start,
                                            style: heading3TextStyle,
                                          ),
                                          Text(
                                              noteModelList[i].startDateTime ==
                                                      null
                                                  ? ""
                                                  : DateTimeHelper
                                                      .formatterToDisplay
                                                      .format(noteModelList[i]
                                                          .startDateTime!),
                                              textAlign: TextAlign.start,
                                              style: heading4TextStyle),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            "End Date",
                                            textAlign: TextAlign.start,
                                            style: heading3TextStyle,
                                          ),
                                          Text(
                                              noteModelList[i].endDateTime ==
                                                      null
                                                  ? ""
                                                  : DateTimeHelper
                                                      .formatterToDisplay
                                                      .format(noteModelList[i]
                                                          .endDateTime!),
                                              textAlign: TextAlign.start,
                                              style: heading4TextStyle),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            "Time Left",
                                            textAlign: TextAlign.start,
                                            style: heading3TextStyle,
                                          ),
                                          Text(
                                              noteModelList[i].startDateTime ==
                                                      null
                                                  ? ""
                                                  : DateTimeHelper
                                                      .dateTimeDifference(
                                                          noteModelList[i]
                                                              .startDateTime!,
                                                          noteModelList[i]
                                                              .endDateTime!),
                                              textAlign: TextAlign.start,
                                              style: heading4TextStyle),
                                        ],
                                      ),
                                    ),
                                  ])
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(cardBorderRadius),
                                bottomRight: Radius.circular(cardBorderRadius),
                              ),
                              color: Colors.grey[100],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("Status: "),
                                      Text(
                                        noteModelList[i].completed == null
                                            ? "Incomplete"
                                            : noteModelList[i].completed!
                                                ? "Completed"
                                                : "Incomplete",
                                        style: heading4TextStyle,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text("Tick if completed"),
                                      ),
                                      Visibility(
                                        visible:
                                            noteModelList[i].completed == null
                                                ? false
                                                : !noteModelList[i].completed!,
                                        child: Container(
                                          height: 24.0,
                                          width: 24.0,
                                          child: Checkbox(
                                            value: noteModelList[i].completed,
                                            onChanged: (bool? value) {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateScreen(),
              ),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }, listener: (BuildContext context, Object? state) {
      if (state is GetNoteSuccess) {
        Navigator.pop(context);
        setState(() {
          if (state.noteList != null) {
            noteModelList = state.noteList!;
          }
        });
      } else if (state is GetNoteError) {
        Navigator.pop(context);
      } else if (state is GetNoteLoading) {
        UIUtitilies.showLoadingDialog(context);
      }
    });
  }
}
