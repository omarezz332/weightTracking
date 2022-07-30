import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../settings/helpers/extensions.dart';
import '../../../../settings/helpers/sized_boxes.dart';


class BasicDateField extends StatelessWidget {
  final String title;
  final Function(String) onSave;
  BasicDateField({Key? key, required this.title, required this.onSave})
      : super(key: key);
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: context.textTheme.button!.copyWith(
              color: context.theme.disabledColor.withOpacity(0.6),
              fontFamily: 'segoe',
              fontWeight: FontWeight.w300,
            ),
          ),
          kVerticalSizedBoxXXSmall,
          DateTimeField(
            format: format,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100),
              );
            },
            onSaved: (value) {
              onSave(value!.toString());
            },
          ),
        ],
      ),
    );
}
