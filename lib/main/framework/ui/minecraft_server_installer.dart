import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/adapter/gateway/installation_repository_impl.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/installation_bloc.dart';
import 'package:minecraft_server_installer/main/adapter/presentation/navigation_bloc.dart';
import 'package:minecraft_server_installer/main/application/use_case/download_file_use_case.dart';
import 'package:minecraft_server_installer/main/application/use_case/grant_file_permission_use_case.dart';
import 'package:minecraft_server_installer/main/application/use_case/write_file_use_case.dart';
import 'package:minecraft_server_installer/main/constants.dart';
import 'package:minecraft_server_installer/main/framework/api/installation_api_service_impl.dart';
import 'package:minecraft_server_installer/main/framework/storage/installation_file_storage_impl.dart';
import 'package:minecraft_server_installer/main/framework/ui/about_tab.dart';
import 'package:minecraft_server_installer/main/framework/ui/basic_configuration_tab.dart';
import 'package:minecraft_server_installer/main/framework/ui/side_navigation_bar.dart';
import 'package:minecraft_server_installer/vanilla/adapter/gateway/vanilla_repository_impl.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/vanilla_bloc.dart';
import 'package:minecraft_server_installer/vanilla/application/use_case/get_game_version_list_use_case.dart';
import 'package:minecraft_server_installer/vanilla/framework/api/vanilla_api_service_impl.dart';

class MinecraftServerInstaller extends StatelessWidget {
  const MinecraftServerInstaller({super.key});

  @override
  Widget build(BuildContext context) {
    final installationApiService = InstallationApiServiceImpl();
    final installationFileStorage = InstallationFileStorageImpl();
    final installationRepository = InstallationRepositoryImpl(installationApiService, installationFileStorage);

    final gameVersionApiService = VanillaApiServiceImpl();
    final gameVersionRepository = VanillaRepositoryImpl(gameVersionApiService);

    final downloadFileUseCase = DownloadFileUseCase(installationRepository);
    final writeFileUseCase = WriteFileUseCase(installationRepository);
    final grantFilePermissionUseCase = GrantFilePermissionUseCase(installationRepository);
    final getGameVersionListUseCase = GetGameVersionListUseCase(gameVersionRepository);

    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.blue.shade900,
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => NavigationBloc()),
          BlocProvider(
            create: (_) => InstallationBloc(
              downloadFileUseCase,
              writeFileUseCase,
              grantFilePermissionUseCase,
            ),
          ),
          BlocProvider<VanillaBloc>(
            create: (_) => VanillaBloc(getGameVersionListUseCase)..add(VanillaGameVersionListLoadedEvent()),
          ),
        ],
        child: Scaffold(
          body: Row(
            children: [
              const SideNavigationBar(),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (context.watch<InstallationBloc>().state.isLocked) {
                      return MouseRegion(
                        cursor: SystemMouseCursors.forbidden,
                        child: AbsorbPointer(child: _body),
                      );
                    }

                    return _body;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _body => BlocConsumer<NavigationBloc, NavigationItem>(
        listener: (_, __) {},
        builder: (context, state) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Column(
            key: ValueKey('tab${state.toString()}'),
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700, color: Colors.blueGrey.shade900),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: _tabContent(state),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _tabContent(NavigationItem navigationItem) {
    switch (navigationItem) {
      case NavigationItem.basicConfiguration:
        return const BasicConfigurationTab();
      case NavigationItem.modConfiguration:
      case NavigationItem.serverProperties:
        return const Placeholder();
      case NavigationItem.about:
        return const AboutTab();
    }
  }
}
