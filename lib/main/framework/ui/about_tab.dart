import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:minecraft_server_installer/main/constants.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 460,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/img/mcsi_logo.png', width: 100, height: 100),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Constants.appName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w900, color: Colors.blueGrey.shade900),
                    ),
                    FutureBuilder(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) => Text(
                        'Version ${snapshot.data?.version ?? ''}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(32),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border(left: BorderSide(color: Colors.blueGrey.shade300, width: 6)),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Icon(Icons.format_quote_rounded, color: Colors.grey.shade700),
                  ),
                  const Gap(8),
                  Text(
                    Strings.textSlogen,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            const Gap(32),
            Row(
              children: [
                _actionButton(
                  onPressed: () => launchUrl(Uri.parse(Constants.tutorialVideoUrl)),
                  text: Strings.buttonTutorialVideo,
                  svgAssetName: 'assets/svg/youtube.svg',
                ),
                const Gap(12),
                _actionButton(
                  onPressed: () => launchUrl(Uri.parse(Constants.bugReportUrl)),
                  text: Strings.buttonBugReport,
                  svgAssetName: 'assets/svg/bug.svg',
                ),
                const Gap(12),
                _actionButton(
                  onPressed: () => launchUrl(Uri.parse('mailto:${Constants.authorEmail}')),
                  text: Strings.buttonContactAuthor,
                  svgAssetName: 'assets/svg/send.svg',
                ),
                const Gap(12),
                _actionButton(
                  onPressed: () => launchUrl(Uri.parse(Constants.sourceCodeUrl)),
                  text: Strings.buttonSourceCode,
                  svgAssetName: 'assets/svg/github.svg',
                ),
              ],
            ),
            const Spacer(),
            Text(
              Strings.textCopyright,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
            ),
          ],
        ),
      );

  Widget _actionButton({
    required String text,
    required String svgAssetName,
    required void Function()? onPressed,
  }) =>
      Builder(
        builder: (context) => Expanded(
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blueGrey.shade50, width: 2),
              ),
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        svgAssetName,
                        width: 32,
                        height: 32,
                        colorFilter: ColorFilter.mode(Colors.grey.shade800, BlendMode.srcIn),
                      ),
                      const Gap(12),
                      Text(
                        text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
