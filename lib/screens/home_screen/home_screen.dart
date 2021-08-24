import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/config/constant.dart';
import 'package:to_do_list/helper/date_time_helper.dart';
import 'package:to_do_list/helper/ui_helper.dart';
import 'package:to_do_list/model/note_model.dart';
import 'package:to_do_list/repository/repository.dart';
import 'package:to_do_list/screens/create_screen/create_screen.dart';
import 'package:to_do_list/screens/create_screen/create_screen_bloc.dart';
import 'package:to_do_list/screens/create_screen/create_screen_state.dart';
import 'package:to_do_list/screens/home_screen/home_screen_bloc.dart';
import 'package:to_do_list/screens/home_screen/home_screen_event.dart';
import 'package:to_do_list/screens/home_screen/home_screen_state.dart';
import 'package:to_do_list/theme/color.dart';
import 'package:to_do_list/theme/font.dart';
import 'package:to_do_list/theme/shape.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NoteModel> noteModelList = [];
  late HomeBloc _homeBloc;
  int updatedListIndex = 0;

  @override
  void initState() {
    super.initState();
    _openDB();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  void dispose() {
    Repository().closeDB();
    super.dispose();
  }

  Future<void> _openDB() async {
    await Repository().openDB().then((value) {
      _homeBloc.add(GetNoteEvent());
    });
  }

  void updateCompletedNote(int index) {
    setState(() {
      updatedListIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is GetNoteSuccess) {
                Navigator.pop(context);
                setState(() {
                  if (state.noteList != null) {
                    noteModelList = state.noteList!;
                  }
                });
              } else if (state is GetNoteError) {
                Navigator.pop(context);
              } else if (state is GetNoteLoading ||
                  state is UpdateNoteLoading) {
                UIUtitilies.showLoadingDialog(context);
              } else if (state is UpdateNoteSuccess) {
                Navigator.pop(context);
                setState(() {
                  noteModelList[updatedListIndex].completed = state.completed;
                });
              } else if (state is UpdateNoteCompletedSuccess) {
                updateCompletedNote(state.rowId);
              }
            },
          ),
          BlocListener<CreateBloc, CreateState>(
            listener: (context, state) {
              if (state is CreateSuccss) {
                _homeBloc.add(GetNoteEvent());
              } else if (state is UpdateLoading) {
                UIUtitilies.showLoadingDialog(context);
              } else if (state is UpdateSuccss) {
                Navigator.pop(context);
                _homeBloc.add(GetNoteEvent());
              } else if (state is UpdateError) {
                Navigator.pop(context);
              }
            },
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            centerTitle: false,
            title: const Text(
              appName,
              textAlign: TextAlign.start,
              style: appBarTextStyle,
            ),
          ),
          body: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    NoteList(noteModelList: noteModelList, homeBloc: _homeBloc),
              )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, createScreenRouteName);
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }
}

class NoteList extends StatelessWidget {
  const NoteList({
    Key? key,
    required this.noteModelList,
    required HomeBloc homeBloc,
  })   : _homeBloc = homeBloc,
        super(key: key);

  final List<NoteModel> noteModelList;
  final HomeBloc _homeBloc;

  @override
  Widget build(BuildContext context) {
    if (noteModelList.isEmpty) {
      return const Center(
        child: Text(
          "Tap + Button to create a note",
          key: Key("Empty note list"),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: noteModelList.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateScreen(
                        rowId: noteModelList[i].id,
                        title: noteModelList[i].title,
                        startDateTime: noteModelList[i].startDateTime,
                        endDateTime: noteModelList[i].endDateTime,
                      ),
                    ));
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(cardBorderRadius),
                          topLeft: Radius.circular(cardBorderRadius),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              noteModelList[i].title == null
                                  ? ""
                                  : noteModelList[i].title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: heading1TextStyle,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 15),
                            Row(children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Text(
                                      "Start Date",
                                      textAlign: TextAlign.start,
                                      style: heading3TextStyle,
                                    ),
                                    Text(
                                        noteModelList[i].startDateTime == null
                                            ? ""
                                            : DateTimeHelper.formatterToDisplay
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
                                    const Text(
                                      "End Date",
                                      textAlign: TextAlign.start,
                                      style: heading3TextStyle,
                                    ),
                                    Text(
                                        noteModelList[i].endDateTime == null
                                            ? ""
                                            : DateTimeHelper.formatterToDisplay
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
                                    const Text(
                                      "Time Left",
                                      textAlign: TextAlign.start,
                                      style: heading3TextStyle,
                                    ),
                                    Text(
                                        noteModelList[i].startDateTime == null
                                            ? ""
                                            : DateTimeHelper.dateTimeDifference(
                                                noteModelList[i].startDateTime!,
                                                noteModelList[i].endDateTime!),
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
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(cardBorderRadius),
                          bottomRight: Radius.circular(cardBorderRadius),
                        ),
                        color: Colors.grey[100],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Visibility(
                                visible: noteModelList[i].completed == null
                                    ? true
                                    : noteModelList[i].completed!
                                        ? false
                                        : true,
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text("Tick if completed"),
                                    ),
                                    Container(
                                      height: 24.0,
                                      width: 24.0,
                                      child: Checkbox(
                                        value: noteModelList[i].completed,
                                        onChanged: (value) {
                                          _homeBloc.add(
                                              UpdateNoteCompletedEvent(
                                                  index: i));
                                          _homeBloc.add(UpdateNoteEvent(
                                              rowId: noteModelList[i].id!,
                                              completed: value!));
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
