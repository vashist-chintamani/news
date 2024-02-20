import 'package:mobile_app_platform_widgets/common_exports.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool disable;
  final bool loading;
  final bool isExpanded;
  final Color? textColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double horizontalPadding;
  final double? fontSize;

  const PrimaryButton({
    super.key,
    this.textColor,
    this.isExpanded = false,
    this.prefixIcon,
    this.suffixIcon,
    required this.text,
    this.onTap,
    this.backgroundColor,
    this.disable = false,
    this.loading = false,
    this.horizontalPadding = 16,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isIOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(4),
        pressedOpacity: onTap == null ? 1 : 0.4,
        color: backgroundColor ?? context.primaryColor,
        onPressed: disable ? null : (onTap ?? () {}),
        child: SizedBox(
          width: isExpanded ? double.infinity : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (prefixIcon == null) ...{
                SizedBox(width: horizontalPadding)
              } else ...{
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: prefixIcon!,
                ),
              },
              Flexible(
                child: Text(
                  text,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    color: disable
                        ? context.textDisabledColor
                        : textColor ?? Colors.white,
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
                ),
              },
            ],
          ),
        ),
      );
    } else {
      return IgnorePointer(
        ignoring: onTap == null ? true : false,
        child: ElevatedButton(
          onPressed: disable ? null : (onTap ?? () {}),
          style: ButtonStyle(
            padding: const MaterialStatePropertyAll(EdgeInsets.zero),
            backgroundColor: disable
                ? MaterialStatePropertyAll(
                    context.primaryColor.withOpacity(0.5))
                : MaterialStatePropertyAll(backgroundColor),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: prefixIcon!,
                  ),
                },
                Flexible(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: disable
                          ? context.secondaryColor.withOpacity(0.5)
                          : null,
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
                  ),
                },
              ],
            ),
          ),
        ),
      );
    }
  }
}
