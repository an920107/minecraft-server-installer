import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minecraft_server_installer/main/adapter/presenter/navigation_bloc.dart';
import 'package:minecraft_server_installer/main/constants.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SideNavigationBar extends StatefulWidget {
  const SideNavigationBar({super.key});

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  bool _isExpanded = false;

  double get width => _isExpanded ? 340 : 80;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            boxShadow: [
              const BoxShadow(color: Colors.black26, offset: Offset(0, 0), blurRadius: 8),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _animatedText(
                  text: Constants.appName,
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Image.asset('assets/img/mcsi_logo.png', width: 32, height: 32),
                  ),
                  padding: const EdgeInsets.only(left: 4),
                  expandedKey: const ValueKey('expandedTitle'),
                  collapsedKey: const ValueKey('collapsedTitle'),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w900, color: Colors.blueGrey.shade900),
                ),
                Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: InkWell(
                      key: ValueKey(_isExpanded),
                      borderRadius: BorderRadius.circular(8),
                      onTap: _toggleIsExpanded,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(_isExpanded ? Icons.menu_open : Icons.menu, color: Colors.blueGrey.shade600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(32),
            _navigationButton(NavigationItem.basicConfiguration),
            const Gap(8),
            _navigationButton(NavigationItem.modConfiguration),
            const Gap(8),
            _navigationButton(NavigationItem.serverProperties),
            const Gap(8),
            _navigationButton(NavigationItem.about),
            const Spacer(),
            FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) => _animatedText(
                text: 'Version ${snapshot.data?.version ?? ''}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                padding: EdgeInsets.zero,
                expandedKey: const ValueKey('expandedVersion'),
                collapsedKey: const ValueKey('collapsedVersion'),
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      );

  void _toggleIsExpanded() => setState(() => _isExpanded = !_isExpanded);

  Widget _animatedText({
    required String text,
    required Key expandedKey,
    required Key collapsedKey,
    EdgeInsetsGeometry padding = const EdgeInsets.only(left: 8),
    TextStyle? style,
    AlignmentGeometry alignment = Alignment.centerLeft,
    Widget? leading,
  }) =>
      Expanded(
        child: ClipRect(
          child: Container(
            alignment: alignment,
            padding: padding,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isExpanded
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (leading != null)
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: leading,
                            ),
                          ),
                        Flexible(
                          child: Text(
                            text,
                            key: expandedKey,
                            style: style,
                            softWrap: false,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(key: collapsedKey),
            ),
          ),
        ),
      );

  Widget _navigationButton(NavigationItem navigationItem) {
    final selectedNavigationItem = context.watch<NavigationBloc>().state;
    final isSelected = selectedNavigationItem == navigationItem;
    final color = isSelected ? Colors.blue.shade900 : Colors.blueGrey.shade600;
    return Material(
      color: isSelected ? Colors.blueGrey.shade100 : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => context.read<NavigationBloc>().add(NavigationChangedEvent(navigationItem)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(navigationItem.iconData, color: color),
            ),
            _animatedText(
              text: navigationItem.title,
              expandedKey: ValueKey('expanded${navigationItem.toString()}'),
              collapsedKey: ValueKey('collapsed${navigationItem.toString()}'),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

extension NavigationItemContent on NavigationItem {
  String get title {
    switch (this) {
      case NavigationItem.basicConfiguration:
        return Strings.tabBasicConfiguration;
      case NavigationItem.modConfiguration:
        return Strings.tabModConfiguration;
      case NavigationItem.serverProperties:
        return Strings.tabServerProperties;
      case NavigationItem.about:
        return Strings.tabAbout;
    }
  }

  IconData get iconData {
    switch (this) {
      case NavigationItem.basicConfiguration:
        return Icons.dashboard_rounded;
      case NavigationItem.modConfiguration:
        return Icons.extension;
      case NavigationItem.serverProperties:
        return Icons.settings;
      case NavigationItem.about:
        return Icons.info;
    }
  }
}
