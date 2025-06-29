import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_installer/main/framework/ui/basic_configuration_tab.dart';
import 'package:minecraft_server_installer/vanila/adapter/gateway/game_version_repository_impl.dart';
import 'package:minecraft_server_installer/vanila/adapter/presentation/game_version_bloc.dart';
import 'package:minecraft_server_installer/vanila/application/use_case/get_game_version_list_use_case.dart';
import 'package:minecraft_server_installer/vanila/framework/api/game_version_api_service_impl.dart';

class MinecraftServerInstaller extends StatelessWidget {
  const MinecraftServerInstaller({super.key});

  @override
  Widget build(BuildContext context) {
    final gameVersionApiService = GameVersionApiServiceImpl();
    final gameVersionRepository = GameVersionRepositoryImpl(gameVersionApiService);
    final getGameVersionListUseCase = GetGameVersionListUseCase(gameVersionRepository);

    return MaterialApp(
      title: 'Minecraft Server Installer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MultiBlocProvider(
        providers: [BlocProvider<GameVersionBloc>(create: (context) => GameVersionBloc(getGameVersionListUseCase))],
        child: const Scaffold(
          body: Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32), child: BasicConfigurationTab()),
        ),
      ),
    );
  }
}
