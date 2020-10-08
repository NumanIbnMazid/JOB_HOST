import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:job_host/shared/textInputDecoration.dart';
import 'package:job_host/userProfile/userProfileFieldProperties.dart';
import 'package:job_host/userProfile/utils/helpers.dart';
import 'package:country_code_picker/country_code_picker.dart';

class UserProfileFormFields extends StatefulWidget {
  final String formFieldKey;

  UserProfileFormFields({Key key, @required this.formFieldKey})
      : super(key: key);

  @override
  _UserProfileFormFieldsState createState() => _UserProfileFormFieldsState();
}

class _UserProfileFormFieldsState extends State<UserProfileFormFields> {
  @override
  Widget build(BuildContext context) {
    return userProfileFieldProperties[widget.formFieldKey]['isText'] == true
        ? TextField(
            enabled: true,
            focusNode: userProfileFieldProperties[widget.formFieldKey]
                ['focusNode'],
            maxLines: userProfileFieldProperties[widget.formFieldKey]
                        ['isTextArea'] ==
                    true
                ? 4
                : 1,
            // initialValue: state.profileData[
            //     'user__username'],
            // autofocus:
            //     userProfileFieldProperties[
            //         key]['isEditable'],
            // index == 0 ? true : false,
            decoration: textInputDecoration(
              fieldStatus: userProfileFieldProperties[widget.formFieldKey]
                  ['fieldStatus'],
              fieldMessage: userProfileFieldProperties[widget.formFieldKey]
                  ['fieldMessage'],
              isChanged: userProfileFieldProperties[widget.formFieldKey]
                  ['isChanged'],
              labelText: userProfileFieldProperties[widget.formFieldKey]
                  ['displayName'],
              prefixIcon: userProfileFieldProperties[widget.formFieldKey]
                  ['prefixIcon'],
            ),
            controller: userProfileFieldProperties[widget.formFieldKey]
                ['controller'],
            // controller:
            //     TextEditingController(
            //   text: state.profileData[
            //       'user__username'],
            // ),
            // validator: _validateUsername,
            onChanged: (value) {
              // _formFieldOnChanged(
              //   fieldName: 'username',
              //   fieldValue: value,
              //   requiredField: true,
              //   modelName: 'User',
              //   searchType: 'iexact',
              // );
              if (userProfileFieldProperties[widget.formFieldKey]
                      ['controller'] !=
                  null) {
                TextSelection previousSelection =
                    userProfileFieldProperties[widget.formFieldKey]
                            ['controller']
                        .selection;
                userProfileFieldProperties[widget.formFieldKey]['controller']
                    .selection = previousSelection;
              }
              setState(() {
                userProfileFieldProperties[widget.formFieldKey]['value'] =
                    value;
              });
            },
          )
        : userProfileFieldProperties[widget.formFieldKey]['isDropdown'] == true
            ? Container(
                // color: Colors.white,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: userProfileFieldProperties[widget.formFieldKey]
                                ['value'] ==
                            ''
                        ? Colors.white
                        : Colors.blue,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  color: Colors.white,
                ),
                child: DropDownFormField(
                  titleText: userProfileFieldProperties[widget.formFieldKey]
                      ['displayName'],
                  hintText: userProfileFieldProperties[widget.formFieldKey]
                      ['hintText'],
                  value: userProfileFieldProperties[widget.formFieldKey]
                      ['value'],
                  onSaved: (value) {
                    setState(() {
                      userProfileFieldProperties[widget.formFieldKey]['value'] =
                          value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      userProfileFieldProperties[widget.formFieldKey]['value'] =
                          value;
                    });
                  },
                  dataSource: userProfileFieldProperties[widget.formFieldKey]
                      ['dropdownDataSource'],
                  textField: 'display',
                  valueField: 'value',
                  required: false,
                  validator: (value) {
                    if (value == null) {
                      return "Please select ${userProfileFieldProperties[widget.formFieldKey]['displayName']}!";
                    }
                    return null;
                  },
                ),
              )
            : userProfileFieldProperties[widget.formFieldKey]['isDate'] == true
                ? TextField(
                    enabled: false,
                    controller: TextEditingController(
                        text: userProfileFieldProperties[widget.formFieldKey]
                                ['value'] ??
                            "Undefined"),
                    decoration: textInputDecoration(
                      fieldStatus: true,
                      fieldMessage: '',
                      isChanged: false,
                      labelText: userProfileFieldProperties[widget.formFieldKey]
                          ['displayName'],
                      prefixIcon: Icons.label,
                    ),
                  )
                : userProfileFieldProperties[widget.formFieldKey]
                            ['isPhoneField'] ==
                        true
                    ? IntlPhoneField(
                        focusNode:
                            userProfileFieldProperties[widget.formFieldKey]
                                ['focusNode'],
                        decoration: textInputDecoration(
                          fieldStatus:
                              userProfileFieldProperties[widget.formFieldKey]
                                  ['fieldStatus'],
                          fieldMessage:
                              userProfileFieldProperties[widget.formFieldKey]
                                  ['fieldMessage'],
                          isChanged:
                              userProfileFieldProperties[widget.formFieldKey]
                                  ['isChanged'],
                          labelText:
                              userProfileFieldProperties[widget.formFieldKey]
                                  ['displayName'],
                          prefixIcon:
                              userProfileFieldProperties[widget.formFieldKey]
                                  ['prefixIcon'],
                        ),
                        controller:
                            userProfileFieldProperties[widget.formFieldKey]
                                ['controller'],
                        initialCountryCode:
                            userProfileFieldProperties['contact_country_code']
                                ['selectedCode'],
                        onChanged: (phone) async {
                          // print(phone.completeNumber);
                          // print(phone.countryCode);
                          // print(phone.number);
                          setState(() {
                            userProfileFieldProperties['contact_country_code']
                                ['value'] = phone.countryCode;
                            userProfileFieldProperties['contact_number']
                                ['value'] = phone.number;
                            userProfileFieldProperties[widget.formFieldKey]
                                ['value'] = phone.completeNumber;
                          });
                          await generateCountryCode(context).then((code) {
                            setState(() {
                              userProfileFieldProperties['contact_country_code']
                                  ['selectedCode'] = code;
                            });
                          });

                          userProfileFieldProperties[widget.formFieldKey]
                                  ['focusNode']
                              .requestFocus();
                          if (userProfileFieldProperties[widget.formFieldKey]
                                  ['controller'] !=
                              null) {
                            TextSelection previousSelection =
                                userProfileFieldProperties[widget.formFieldKey]
                                        ['controller']
                                    .selection;
                            userProfileFieldProperties[widget.formFieldKey]
                                    ['controller']
                                .selection = previousSelection;
                          }
                        },
                      )
                    : userProfileFieldProperties[widget.formFieldKey]
                                ['isCountryField'] ==
                            true
                        ? CountryCodePicker(
                            hideMainText: false,
                            showFlagMain: true,
                            showFlag: false,
                            initialSelection:
                                userProfileFieldProperties[widget.formFieldKey]
                                    ['value'],
                            hideSearch: false,
                            showCountryOnly: true,
                            showOnlyCountryWhenClosed: true,
                            alignLeft: false,
                            onChanged: (value) {
                              setState(() {
                                userProfileFieldProperties[widget.formFieldKey]
                                    ['value'] = value.name.toString();
                              });
                            },
                          )
                        : TextField(
                            enabled: false,
                            controller: TextEditingController(
                                text: userProfileFieldProperties[
                                        widget.formFieldKey]['value'] ??
                                    "Input"),
                            decoration: textInputDecoration(
                              fieldStatus: true,
                              fieldMessage: '',
                              isChanged: false,
                              labelText: userProfileFieldProperties[
                                  widget.formFieldKey]['displayName'],
                              prefixIcon: Icons.label,
                            ),
                          );
  }
}
