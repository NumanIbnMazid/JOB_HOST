import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_host/shared/loading.dart';
import 'package:job_host/shared/snackBars.dart';
import 'package:job_host/userProfile/bloc/user_profile_bloc.dart';
import 'package:job_host/userProfile/userProfileFieldProperties.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:job_host/userProfile/userProfileFormFields.dart';
import 'dart:convert';

import 'package:job_host/userProfile/utils/helpers.dart';

class UserProfileDetailsPage extends StatefulWidget {
  @override
  _UserProfileDetailsPageState createState() => _UserProfileDetailsPageState();
}

class _UserProfileDetailsPageState extends State<UserProfileDetailsPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    try {
      // fetch user profile data
      BlocProvider.of<UserProfileBloc>(context).add(
        UserProfileFetchEvent(),
      );

      // Make loading false after getting data
      setState(() {
        isLoading = false;
      });

      // Focus Node
      userProfileFieldProperties.forEach((key, value) {
        userProfileFieldProperties[key]['focusNode'] =
            userProfileFieldProperties[key]['focusNode'];
      });
    } catch (error) {
      print(error);
    }

    // Set initial country code value
    generateCountryCode(context);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    // Focus Node
    userProfileFieldProperties.forEach((key, value) {
      userProfileFieldProperties[key]['focusNode'].dispose();
    });

    super.dispose();
  }

  _editButtonPressed({@required String key}) async {
    setState(() {
      userProfileFieldProperties[key]['isEditable'] =
          !userProfileFieldProperties[key]['isEditable'];
    });

    if (userProfileFieldProperties[key]['isDate'] == true &&
        userProfileFieldProperties[key]['isEditable'] == true) {
      DateTime selectedDOB = await showRoundedDatePicker(
        context: context,
        initialDate: DateTime.parse(userProfileFieldProperties[key]['value']),
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year - 10),
        borderRadius: 16,
      );
      if (selectedDOB != null) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDOB);
        setState(
            () => userProfileFieldProperties[key]['value'] = formattedDate);
      }
      userProfileFieldProperties[key]['focusNode'].requestFocus();
    }
    userProfileFieldProperties[key]['focusNode'].requestFocus();
    // print(userProfileFieldProperties['contact_number']['value']);
  }

  Widget _fieldData({@required String key}) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            userProfileFieldProperties[key]['displayName'] ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            userProfileFieldProperties[key]['value'] ?? "",
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (isLoading == true) {
    //   BlocProvider.of<UserProfileBloc>(context).add(
    //     UserProfileFetchEvent(),
    //   );
    //   setState(() {
    //     isLoading = false;
    //   });
    // }

    return BlocListener<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileFetchFailure) {
          Scaffold.of(context).showSnackBar(
            errorSnackBar(
              duration: 7,
              errorText: state.error,
            ),
          );
        }
        if (state is UserProfileFetchSuccess) {
          userProfileFieldProperties.forEach((key, value) {
            setState(() {
              userProfileFieldProperties[key]['value'] = state.profileData[key];
            });
            if (userProfileFieldProperties[key]['controller'] != null) {
              if (userProfileFieldProperties[key]['isPhoneField'] == true) {
                userProfileFieldProperties[key]['controller'].text =
                    userProfileFieldProperties['contact_number']['value'];
              } else {
                userProfileFieldProperties[key]['controller'].text =
                    userProfileFieldProperties[key]['value'];
              }
            }
          });
        }
      },
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          return isLoading == true
              ? LoadingIndicator()
              : Container(
                  child: state is UserProfileFetchSuccess
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 30, bottom: 23, left: 10, right: 15),
                                child: ListView.builder(
                                  // shrinkWrap: true,
                                  // scrollDirection: Axis.horizontal,
                                  itemCount: userProfileFieldProperties.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String key = userProfileFieldProperties.keys
                                        .elementAt(index);
                                    return userProfileFieldProperties[key]
                                                ['hiddenField'] ==
                                            false
                                        ? Row(
                                            children: [
                                              Expanded(
                                                flex: 9,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          13, 7, 3, 6),
                                                  child: userProfileFieldProperties[
                                                                  key]
                                                              ['isEditable'] ==
                                                          true
                                                      ? UserProfileFormFields(
                                                          formFieldKey: key,
                                                        )
                                                      : _fieldData(key: key),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: IconButton(
                                                  icon: Icon(
                                                    userProfileFieldProperties[
                                                                    key][
                                                                'isEditable'] ==
                                                            false
                                                        ? Icons.edit
                                                        : Icons.check_box,
                                                  ),
                                                  onPressed: () async {
                                                    _editButtonPressed(
                                                        key: key);
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox.shrink();
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : LoadingIndicator(),
                );
        },
      ),
    );
  }
}
