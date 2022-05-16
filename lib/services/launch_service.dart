import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../extensions/build_context_extension.dart';

class LaunchService {
  void launchEvent(String _url, BuildContext context) async => await canLaunchUrl(
        _createUriForString(_url),
      )
          ? await launchUrl(
              _createUriForString(_url),
            )
          : ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: SizedBox(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Failed to launch $_url',
                        style: context.text.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );

  Uri _createUriForString(String _url) {
    return Uri(
      scheme: 'https',
      path: _url.replaceFirst('https', ''),
    );
  }
}
