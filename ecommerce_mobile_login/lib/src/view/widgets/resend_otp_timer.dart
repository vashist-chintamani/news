import 'package:ecommerce_mobile_login/src/utils/common_exports.dart';

class ResendOTPTimer extends StatefulWidget {
  final Future<bool> Function() resend;

  const ResendOTPTimer({super.key, required this.resend});

  @override
  State<ResendOTPTimer> createState() => _ResendOTPTimerState();
}

class _ResendOTPTimerState extends State<ResendOTPTimer> {
  late Timer _timer;
  final ValueNotifier<int> seconds = ValueNotifier<int>(59);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (seconds.value == 0) {
          timer.cancel();
        } else {
          seconds.value--;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: seconds,
      builder: (context, value, _) => Column(
        children: [
          Text(
            "0:${value.toString()}",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              // color: EcommerceLoginColors.mediumGray
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                strings.didNotReceivedTheOtp,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              AbsorbPointer(
                absorbing: value != 0,
                child: TextButton(
                  onPressed: () async {
                    final bool result = await widget.resend();

                    if (result) {
                      startTimer();
                      seconds.value = 59;
                    }
                  },
                  child: Text(
                    strings.resend,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      // color: value == 0
                      // ? EcommerceLoginColors.secondary
                      // : EcommerceLoginColors.secondary.withOpacity(0.50),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
