import 'package:mobile_app_platform_widgets/common_exports.dart';

class OTPInputField extends StatefulWidget {
  final Color? activeBorderColor;
  final Color? inActiveBorderColor;
  final ValueSetter<String> onChangedCallback;
  final List<TextEditingController> textEditingControllers;

  const OTPInputField({
    super.key,
    this.activeBorderColor,
    this.inActiveBorderColor,
    required this.onChangedCallback,
    required this.textEditingControllers,
  });

  @override
  State<OTPInputField> createState() => _OTPInputFieldState();
}

class _OTPInputFieldState extends State<OTPInputField> {
  final List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    super.initState();
    for (final _ in widget.textEditingControllers) {
      _focusNodes.add(FocusNode());
    }
  }

  void changeFocusToNextNodeWhenValueIsEntered(
      {required String value, required int indexOfTextField}) {
    if (value.isNotEmpty) {
      if (indexOfTextField + 1 != widget.textEditingControllers.length) {
        FocusScope.of(context).requestFocus(_focusNodes[indexOfTextField + 1]);
      } else {
        _focusNodes[indexOfTextField].unfocus();
      }
    }
  }

  void changeFocusToPreviousNodeWhenValueIsRemoved(
      {required String value, required int indexOfTextField}) {
    if (value.isEmpty) {
      if (indexOfTextField != 0) {
        FocusScope.of(context).requestFocus(_focusNodes[indexOfTextField - 1]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStater) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...widget.textEditingControllers.map<Widget>(
              (controller) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  height: 64,
                  width: 64,
                  child: TextFormField(
                    autofillHints: ['hello'],
                    cursorHeight: 25,
                    autofocus: true,
                    focusNode: _focusNodes[
                        widget.textEditingControllers.indexOf(controller)],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: controller,
                    maxLength: 1,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: widget.inActiveBorderColor ?? Colors.black,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: widget.activeBorderColor ?? Colors.black,
                          style: BorderStyle.solid,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: widget.inActiveBorderColor ?? Colors.black,
                          style: BorderStyle.solid,
                        ),
                      ),
                      counterText: '',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                      ),
                    ),
                    onChanged: (value) {
                      changeFocusToNextNodeWhenValueIsEntered(
                        value: value,
                        indexOfTextField:
                            widget.textEditingControllers.indexOf(controller),
                      );
                      changeFocusToPreviousNodeWhenValueIsRemoved(
                          value: value,
                          indexOfTextField: widget.textEditingControllers
                              .indexOf(controller));
                      widget.onChangedCallback(value);
                    },
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
