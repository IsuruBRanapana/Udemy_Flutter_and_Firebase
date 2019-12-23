import 'package:flutter/material.dart';
import 'package:udemy_course/common_widgets/custom_raised_buttons.dart';

class FormSubmitButtons extends CustomRaisedButton {
  FormSubmitButtons({
    @required String text,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          height: 44.0,
          color: Colors.indigo,
          borderRadius: 4.0,
          onPressed: onPressed,
        );
}
