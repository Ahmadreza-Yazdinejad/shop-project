import 'package:url_launcher/url_launcher.dart';

abstract class UrlLauncher {
  Future<void> lauchUrl(String uri);
}

class Launcher extends UrlLauncher {
  @override
  Future<void> lauchUrl(String uri) async {
    final _url = Uri.parse(uri);
    launchUrl(_url);
  }
}
