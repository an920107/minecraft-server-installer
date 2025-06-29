import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/framework/ui/basic_configuration_tab.dart';
import 'package:minecraft_server_installer/vanila/adapter/gateway/vanila_repository_impl.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/vanila_bloc.dart';
import 'package:minecraft_server_installer/vanila/application/use_case/download_server_file_use_case.dart';
import 'package:minecraft_server_installer/vanila/application/use_case/get_game_version_list_use_case.dart';
import 'package:minecraft_server_installer/vanila/framework/api/vanila_api_service_impl.dart';
import 'package:minecraft_server_installer/vanila/framework/storage/vanila_file_storage_impl.dart';

class MinecraftServerInstaller extends StatelessWidget {
  const MinecraftServerInstaller({super.key});

  @override
  Widget build(BuildContext context) {
    final gameVersionApiService = VanilaApiServiceImpl();
    final gameVersionFileStorage = VanilaFileStorageImpl();
    final gameVersionRepository = VanilaRepositoryImpl(gameVersionApiService, gameVersionFileStorage);
    final getGameVersionListUseCase = GetGameVersionListUseCase(gameVersionRepository);
    final downloadServerFileUseCase = DownloadServerFileUseCase(gameVersionRepository);

    return MaterialApp(
      title: 'Minecraft Server Installer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<VanilaBloc>(
            create: (context) => VanilaBloc(getGameVersionListUseCase, downloadServerFileUseCase),
          ),
        ],
        child: const Scaffold(
          body: Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32), child: BasicConfigurationTab()),
        ),
      ),
    );
  }
}
