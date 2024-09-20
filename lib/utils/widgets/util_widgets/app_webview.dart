import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/utils/consts/api_urls.dart';
import 'package:heart_e_homies/utils/util_functions/decoration_functions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatefulWidget {
  final String title;
  final String url;

  AppWebView({super.key, required this.title, required this.url});

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(widget.url));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        titleSpacing: 0,
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.white,
            )),
        title: Text(
          widget.title,
          style: textStyleAleo(fontSize: 16),
        ),
      ),
      body: controller != null
          ? WebViewWidget(controller: controller!)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
