import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:to_do_list/config/constant.dart';
import 'package:to_do_list/theme/color.dart';
import 'package:to_do_list/theme/font.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          "Add new " + appName,
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
                        Text(
                          "To-Do Title",
                          style: heading2TextStyle,
                        ),
                        SizedBox(height: 20),
                        FormBuilderTextField(
                          name: 'title',
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.grey),
                              ),
                              hintText: 'Please key in your To-Do title here.'),
                          maxLines: 10,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.max(context, 70),
                          ]),
                        ),
                        SizedBox(height: 33),
                        Text(
                          "Start Date",
                          style: heading2TextStyle,
                        ),
                        SizedBox(height: 20),
                        FormBuilderDateTimePicker(
                          name: 'start_date',
                          onChanged: (val) {},
                          inputType: InputType.both,
                          decoration: InputDecoration(
                              labelText: 'Select a date',
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.grey),
                              ),
                              suffixIcon: InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 34),
                                  onTap: () {})),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        SizedBox(height: 33),
                        Text(
                          "Estimated End Date",
                          style: heading2TextStyle,
                        ),
                        SizedBox(height: 20),
                        FormBuilderDateTimePicker(
                          name: 'end_date',
                          onChanged: (val) {},
                          inputType: InputType.both,
                          decoration: InputDecoration(
                              labelText: 'Select a date',
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.grey),
                              ),
                              suffixIcon: InkWell(
                                  child: Icon(Icons.arrow_drop_down, size: 34),
                                  onTap: () {})),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                      ],
                    ),
                  )),
                ),
                GestureDetector(
                  child: Container(
                      width: double.infinity,
                      color: kSecondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Create Now",
                          style: buttonTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      )),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      print(_formKey.currentState!.fields["title"]!.value
                          .toString());
                      print(_formKey.currentState!.fields["start_date"]!.value
                          .toString());
                      print(_formKey.currentState!.fields["end_date"]!.value
                          .toString());
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
