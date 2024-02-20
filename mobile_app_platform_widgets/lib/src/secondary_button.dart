import 'package:mobile_app_platform_widgets/common_exports.dart';

class SecondaryButton extends StatelessWidget {
  final dynamic text;
  final bool disable;
  final bool loading;
  final bool isExpanded;
  final Color? textColor;
  final Widget? prefixIcon;
  final Color? borderColor;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double horizontalPadding;
  final double fontSize;

  const SecondaryButton({
    super.key,
    this.onTap,
    this.isExpanded = false,
    this.prefixIcon,
    this.suffixIcon,
    required this.text,
    this.disable = false,
    this.backgroundColor,
    this.loading = false,
    this.borderColor,
    this.textColor,
    this.fontSize = 16,
    this.horizontalPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isIOS) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: borderColor ?? context.primaryColor),
        ),
        child: CupertinoButton(
          onPressed: onTap,
          pressedOpacity: 0.4,
          padding: EdgeInsets.zero,
          child: SizedBox(
            width: isExpanded ? double.infinity : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (prefixIcon == null) ...{
                  SizedBox(width: horizontalPadding),
                } else ...{
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: prefixIcon!,
                  )
                },
                Flexible(
                  child: text is Widget
                      ? text as Widget
                      : Text(
                          text as String,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color:
                                disable ? context.textDisabledColor : textColor,
                          ),
                        ),
                ),
                if (suffixIcon == null) ...{
                  SizedBox(
                    width: prefixIcon != null
                        ? horizontalPadding + 16
                        : horizontalPadding,
                  ),
                } else ...{
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: suffixIcon!,
                  )
                },
              ],
            ),
          ),
        ),
      );
    } else {
      return OutlinedButton(
        onPressed: onTap,
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.zero),
        ),
        child: SizedBox(
          width: isExpanded ? double.infinity : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (prefixIcon == null) ...{
                SizedBox(width: horizontalPadding),
              } else ...{
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: prefixIcon!,
                )
              },
              Flexible(
                child: text is Widget
                    ? text as Widget
                    : Text(
                        text as String,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: disable ? const Color(0xffBDC4CA) : textColor,
                        ),
                      ),
              ),
              if (suffixIcon == null) ...{
                SizedBox(
                  width: prefixIcon != null
                      ? horizontalPadding + 16
                      : horizontalPadding,
                ),
              } else ...{
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: suffixIcon!,
                )
              },
            ],
          ),
        ),
      );
    }
  }
}
