import 'package:intl/intl.dart';
import 'package:mobile_app_platform_widgets/common_exports.dart';

class AppDatePicker extends StatelessWidget {
  final String hint;
  final String value;
  final String title;
  final DateTime date;
  final Widget dateIcon;
  final TextStyle? hintStyle;
  final TextStyle? titleStyle;
  final ColorScheme? colorScheme;
  final void Function(DateTime date) changeDate;

  const AppDatePicker({
    super.key,
    this.hintStyle,
    this.titleStyle,
    this.colorScheme,
    required this.hint,
    required this.title,
    required this.date,
    required this.value,
    required this.dateIcon,
    required this.changeDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              if (context.isIOS)
                {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => SizedBox(
                      height: 250,
                      child: ColoredBox(
                        color: context.canvasColor,
                        child: CupertinoDatePicker(
                          initialDateTime: date,
                          minimumDate: DateTime(1900),
                          maximumDate: DateTime(4000),
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime newDate) =>
                              changeDate(newDate),
                        ),
                      ),
                    ),
                  )
                }
              else
                {
                  showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(4000),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: colorScheme,
                            dialogBackgroundColor: Colors.white,
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    Colors.black, // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      }).then((value) => {
                        if (value != null) changeDate(value),
                      })
                }
            },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputFieldLabel(
              title,
              isRequired: false,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(235, 230, 202, 0.25),
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                      width: 2,
                      color: const Color.fromRGBO(235, 230, 202, 0.25))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  value.isNotEmpty
                      ? Text(
                          DateFormat('dd-MM-yyyy').format(date).toString(),
                          style: titleStyle,
                        )
                      : Text(hint, style: hintStyle),
                  const SizedBox(width: 14),
                  dateIcon
                ],
              ),
            ),
          ],
        ));
  }
}
