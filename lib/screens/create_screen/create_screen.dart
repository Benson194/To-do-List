import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:to_do_list/config/constant.dart';
import 'package:to_do_list/helper/date_time_helper.dart';
import 'package:to_do_list/helper/ui_helper.dart';
import 'package:to_do_list/screens/create_screen/create_screen_bloc.dart';
import 'package:to_do_list/screens/create_screen/create_screen_event.dart';
import 'package:to_do_list/screens/create_screen/create_screen_state.dart';
import 'package:to_do_list/theme/color.dart';
import 'package:to_do_list/theme/font.dart';

class CreateScreen extends StatefulWidget {
  final int? rowId;
  final String? title;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  const CreateScreen(
      {this.rowId, this.title, this.startDateTime, this.endDateTime})
      : super();

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late CreateBloc _createBloc;
  bool contentUpdated = false;

  @override
  void initState() {
    super.initState();
    _createBloc = BlocProvider.of<CreateBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateBloc, CreateState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            centerTitle: false,
            title: const Text(
              "Add new $appName",
              textAlign: TextAlign.start,
              style: appBarTextStyle,
            ),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
              bottom: false,
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 38.0, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "To-Do Title",
                              style: heading2TextStyle,
                            ),
                            const SizedBox(height: 20),
                            FormBuilderTextField(
                              name: 'title',
                              key: const Key("Note Title"),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  hintText:
                                      'Please key in your To-Do title here.'),
                              maxLines: 10,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.max(context, 400),
                              ]),
                              onChanged: (value) => {contentUpdated = true},
                            ),
                            const SizedBox(height: 33),
                            const Text(
                              "Start Date",
                              style: heading2TextStyle,
                            ),
                            const SizedBox(height: 20),
                            FormBuilderDateTimePicker(
                              name: 'start_date',
                              key: const Key("Start Date time picker"),
                              onChanged: (val) {
                                contentUpdated = true;
                              },
                              initialValue: widget.startDateTime,
                              inputType: InputType.both,
                              format: DateTimeHelper.formatter,
                              decoration: InputDecoration(
                                  labelText: 'Select a date',
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixIcon: InkWell(
                                      onTap: () {},
                                      child: const Icon(Icons.arrow_drop_down,
                                          size: 34))),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                            const SizedBox(height: 33),
                            const Text(
                              "Estimated End Date",
                              style: heading2TextStyle,
                            ),
                            const SizedBox(height: 20),
                            FormBuilderDateTimePicker(
                              name: 'end_date',
                              key: const Key("End Date time picker"),
                              onChanged: (val) {
                                contentUpdated = true;
                              },
                              format: DateTimeHelper.formatter,
                              inputType: InputType.both,
                              initialValue: widget.endDateTime,
                              decoration: InputDecoration(
                                  labelText: 'Select a date',
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixIcon: InkWell(
                                      onTap: () {},
                                      child: const Icon(Icons.arrow_drop_down,
                                          size: 34))),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                          ],
                        ),
                      )),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          if (contentUpdated && widget.title != null) {
                            _createBloc.add(UpdateEvent(
                              rowId: widget.rowId!,
                              title: _formKey
                                  .currentState!.fields["title"]!.value
                                  .toString(),
                              startDateTime: DateTimeHelper.formatter.format(
                                  _formKey.currentState!.fields["start_date"]!
                                      .value as DateTime),
                              endDateTime: DateTimeHelper.formatter.format(
                                  _formKey.currentState!.fields["end_date"]!
                                      .value as DateTime),
                            ));
                          } else {
                            _createBloc.add(CreateEvent(
                              title: _formKey
                                  .currentState!.fields["title"]!.value
                                  .toString(),
                              startDateTime: DateTimeHelper.formatter.format(
                                  _formKey.currentState!.fields["start_date"]!
                                      .value as DateTime),
                              endDateTime: DateTimeHelper.formatter.format(
                                  _formKey.currentState!.fields["end_date"]!
                                      .value as DateTime),
                            ));
                          }
                        }
                      },
                      child: Container(
                          width: double.infinity,
                          color: kSecondaryColor,
                          key: const Key("Submit button"),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              widget.title == null ? "Create Now" : "Update",
                              style: buttonTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                  ],
                ),
              )),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is CreateLoading || state is UpdateLoading) {
          UIUtitilies.showLoadingDialog(context);
        } else if (state is CreateSuccss || state is UpdateSuccss) {
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (state is CreateError || state is UpdateError) {
          Navigator.pop(context);
        }
      },
    );
  }
}
