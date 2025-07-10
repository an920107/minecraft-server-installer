import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/framework/ui/basic_configuration_tab.dart';
import 'package:minecraft_server_installer/vanilla/adapter/gateway/vanilla_repository_impl.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/vanilla_bloc.dart';
import 'package:minecraft_server_installer/vanilla/adapter/presentation/vanilla_state.dart';
import 'package:minecraft_server_installer/vanilla/application/use_case/download_server_file_use_case.dart';
import 'package:minecraft_server_installer/vanilla/application/use_case/get_game_version_list_use_case.dart';
import 'package:minecraft_server_installer/vanilla/framework/api/vanilla_api_service_impl.dart';
import 'package:minecraft_server_installer/vanilla/framework/storage/vanilla_file_storage_impl.dart';

class MinecraftServerInstaller extends StatelessWidget {
  const MinecraftServerInstaller({super.key});

  Widget get _body =>
      const Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32), child: BasicConfigurationTab());

  @override
  Widget build(BuildContext context) {
    final gameVersionApiService = VanillaApiServiceImpl();
    final gameVersionFileStorage = VanillaFileStorageImpl();
    final gameVersionRepository = VanillaRepositoryImpl(gameVersionApiService, gameVersionFileStorage);
    final getGameVersionListUseCase = GetGameVersionListUseCase(gameVersionRepository);
    final downloadServerFileUseCase = DownloadServerFileUseCase(gameVersionRepository);

    return MaterialApp(
      title: 'Minecraft Server Installer',
      theme: ThemeData.light().copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900)),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<VanillaBloc>(
            create:
                (context) =>
                    VanillaBloc(getGameVersionListUseCase, downloadServerFileUseCase)
                      ..add(VanillaGameVersionListLoadedEvent()),
          ),
        ],
        child: Scaffold(
          body: BlocConsumer<VanillaBloc, VanillaState>(
            listener: (_, __) {},
            builder: (_, state) {
              if (state.isLocked) {
                return MouseRegion(cursor: SystemMouseCursors.forbidden, child: AbsorbPointer(child: _body));
              }

              return _body;
            },
          ),
        ),
      ),
    );
  }
}
