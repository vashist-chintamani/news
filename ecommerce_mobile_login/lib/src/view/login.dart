import 'package:ecommerce_mobile_login/src/utils/common_exports.dart';

late S strings;
final LoginController loginController = LoginController();

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    strings = S.of(context);
    return AppScaffold(
      title: "",
      physics: const NeverScrollableScrollPhysics(),
      border: Border.all(color: Colors.transparent),
      nestedScrollController: ScrollController(initialScrollOffset: 44),
      body: const LoginWithEmailAndPhoneWidget(),
    );
  }
}
