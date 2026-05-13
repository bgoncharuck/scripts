import 'package:{{PACKAGE_NAME}}/logic/use_case/i_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrl with IUseCase<String, void> {
  const LaunchUrl();

  @override
  Future<void> execute({required String params}) async {
    if (params.contains('@')) {
      await _launchEmail(params);
    } else if (params.contains('linkedin.com')) {
      await _launchLinkedIn(params);
    } else if (params.contains('github.com')) {
      await _launchGitHub(params);
    } else if (params.contains('behance.net')) {
      await _launchBehance(params);
    } else {
      await _launchGeneric(params);
    }
  }

  Future<void> _launchLinkedIn(String url) async {
    final uri = Uri.parse(url);
    final String? appUrl;
    final webUrl = url;

    if (defaultTargetPlatform == TargetPlatform.android) {
      appUrl = 'linkedin://profile/${uri.pathSegments.last}';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      appUrl = 'linkedin://profile/${uri.pathSegments.last}';
    } else {
      await _launchWebUrl(webUrl, 'LinkedIn');
      return;
    }

    if (await canLaunchUrl(Uri.parse(appUrl))) {
      await launchUrl(Uri.parse(appUrl), mode: LaunchMode.externalApplication);
    } else {
      await _launchWebUrl(webUrl, 'LinkedIn');
    }
  }

  Future<void> _launchGitHub(String url) async {
    final uri = Uri.parse(url);
    final username = uri.pathSegments.last;
    final String? appUrl;
    final webUrl = url;

    if (defaultTargetPlatform == TargetPlatform.android) {
      appUrl = 'github://user?login=$username';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      appUrl = 'github://user?username=$username';
    } else {
      await _launchWebUrl(webUrl, 'GitHub');
      return;
    }

    if (await canLaunchUrl(Uri.parse(appUrl))) {
      await launchUrl(Uri.parse(appUrl), mode: LaunchMode.externalApplication);
    } else {
      await _launchWebUrl(webUrl, 'GitHub');
    }
  }

  Future<void> _launchBehance(String url) async {
    await _launchWebUrl(url, 'Behance');
  }

  Future<void> _launchEmail(String email) async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Lodestar User Feedback', 'body': ''},
    );

    await launchUrl(emailUri);
  }

  Future<void> _launchGeneric(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      await _onCantBeLaunched(url);
    }
  }

  Future<void> _launchWebUrl(String webUrl, String serviceName) async {
    if (await canLaunchUrl(Uri.parse(webUrl))) {
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    } else {
      await _onCantBeLaunched(serviceName);
    }
  }

  Future<void> _onCantBeLaunched(String what) async {
    debugPrint("$what can't be launched through url_launcher");
  }
}
