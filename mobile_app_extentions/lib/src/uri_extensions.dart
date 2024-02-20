import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tyrios_mobile_app_flutter_extensions/tyrios_mobile_app_flutter_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

extension URIExtensions on Uri {
  void launchURL() async {
    if (await canLaunchUrl(this)) {
      await launchUrl(this);
    } else {
      throw Exception('Could not launch $this');
    }
  }

  void launchPhoneURL() async {
    final String phoneNumberURL = !Platform.isIOS ? 'tel://$path' : 'tel:$path';
    final Uri uri = phoneNumberURL.toUri();
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not launch $uri');
    }
  }

  void launchEmailURL({String? query}) async {
    final Uri emailLaunchUri = Uri(
      path: path,
      query: query,
      scheme: 'mailto',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw Exception('Could not launch $emailLaunchUri');
    }
  }

  Future<Response> httpPost({
    Map<String, String>? headers,
    Object? body,
    ValueNotifier<bool>? httpDelayNotified,
  }) async {
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => httpDelayNotified?.value = false);
    // Timer(
    //     const Duration(seconds: 3),
    //     () => WidgetsBinding.instance
    //         .addPostFrameCallback((_) => httpDelayNotified?.value = true));
    return await post(this, headers: headers, body: body).whenComplete(() =>
        WidgetsBinding.instance
            .addPostFrameCallback((_) => httpDelayNotified?.value = false));
  }

  Future<Response> httpGet({
    Map<String, String>? headers,
    ValueNotifier<bool>? httpDelayNotified,
  }) async {
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => httpDelayNotified?.value = false);
    // Timer(
    //     const Duration(seconds: 3),
    //     () => WidgetsBinding.instance
    //         .addPostFrameCallback((_) => httpDelayNotified?.value = true));
    return await get(this, headers: headers).whenComplete(() => WidgetsBinding
        .instance
        .addPostFrameCallback((_) => httpDelayNotified?.value = false));
  }
}
