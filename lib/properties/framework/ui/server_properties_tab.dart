import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minecraft_server_installer/main/framework/ui/strings.dart';
import 'package:minecraft_server_installer/properties/adapter/presenter/server_properties_bloc.dart';
import 'package:minecraft_server_installer/properties/adapter/presenter/server_properties_view_model.dart';
import 'package:minecraft_server_installer/properties/domain/enum/difficulty.dart';
import 'package:minecraft_server_installer/properties/domain/enum/game_mode.dart';
import 'package:minecraft_server_installer/properties/framework/ui/inline_text_field.dart';

class ServerPropertiesTab extends StatelessWidget {
  const ServerPropertiesTab({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: BlocConsumer<ServerPropertiesBloc, ServerPropertiesViewModel>(
            listener: (_, __) {},
            builder: (context, state) {
              final serverPropertiesBloc = context.read<ServerPropertiesBloc>();

              return Column(
                children: [
                  InlineTextField(
                    labelText: 'server-port | ${Strings.fieldServerPort}',
                    defaultValue: ServerPropertiesViewModel.defaultValue.serverPort.toString(),
                    value: state.serverPort.toString(),
                    onChanged: (value) =>
                        serverPropertiesBloc.add(ServerPropertiesUpdatedEvent(serverPort: int.tryParse(value))),
                  ),
                  const Gap(16),
                  InlineTextField(
                    labelText: 'max-player | ${Strings.fieldMaxPlayers}',
                    defaultValue: ServerPropertiesViewModel.defaultValue.maxPlayers.toString(),
                    value: state.maxPlayers.toString(),
                    onChanged: (value) =>
                        serverPropertiesBloc.add(ServerPropertiesUpdatedEvent(maxPlayers: int.tryParse(value))),
                  ),
                  const Gap(16),
                  InlineTextField(
                    labelText: 'spawn-protection | ${Strings.fieldSpawnProtection}',
                    defaultValue: ServerPropertiesViewModel.defaultValue.spawnProtection.toString(),
                    value: state.spawnProtection.toString(),
                    onChanged: (value) =>
                        serverPropertiesBloc.add(ServerPropertiesUpdatedEvent(spawnProtection: int.tryParse(value))),
                  ),
                  const Gap(16),
                  InlineTextField(
                    labelText: 'view-distance | ${Strings.fieldViewDistance}',
                    defaultValue: ServerPropertiesViewModel.defaultValue.viewDistance.toString(),
                    value: state.viewDistance.toString(),
                    onChanged: (value) =>
                        serverPropertiesBloc.add(ServerPropertiesUpdatedEvent(viewDistance: int.tryParse(value))),
                  ),
                  const Gap(16),
                  _dropdown<bool>(
                    labelText: 'pvp | ${Strings.fieldPvp}',
                    defaultValue: ServerPropertiesViewModel.defaultValue.pvp,
                    value: state.pvp,
                    onChanged: (value) => serverPropertiesBloc.add(ServerPropertiesUpdatedEvent(pvp: value)),
                    items: {true: Strings.textEnable, false: Strings.textDisable},
                  ),
                  const Gap(16),
                  _dropdown<GameMode>(
                    labelText: 'gamemode | ${Strings.fieldGameMode}',
                    defaultValue: ServerPropertiesViewModel.defaultValue.gameMode,
                    value: state.gameMode,
                    onChanged: (value) => serverPropertiesBloc.add(ServerPropertiesUpdatedEvent(gameMode: value)),
                    items: {
                      GameMode.survival: Strings.gamemodeSurvival,
                      GameMode.creative: Strings.gamemodeCreative,
                      GameMode.adventure: Strings.gamemodeAdventure,
                      GameMode.spectator: Strings.gamemodeSpectator,
                    },
                  ),
                  const Gap(16),
                  _dropdown<Difficulty>(
                    labelText: 'difficulty | ${Strings.fieldDifficulty}',
                    defaultValue: ServerPropertiesViewModel.defaultValue.difficulty,
                    value: state.difficulty,
                    onChanged: (value) => serverPropertiesBloc.add(ServerPropertiesUpdatedEvent(difficulty: value)),
                    items: {
                      Difficulty.peaceful: Strings.difficultyPeaceful,
                      Difficulty.easy: Strings.difficultyEasy,
                      Difficulty.normal: Strings.difficultyNormal,
                      Difficulty.hard: Strings.difficultyHard,
                    },
                  ),
                  const Gap(16),
                  _dropdown<bool>(
                    labelText: 'enable-command-block | ${Strings.fieldEnableCommandBlock}',
                    defaultValue: ServerPropertiesViewModel.defaultValue.enableCommandBlock,
                    value: state.enableCommandBlock,
                    onChanged: (value) =>
                        serverPropertiesBloc.add(ServerPropertiesUpdatedEvent(enableCommandBlock: value)),
                    items: {true: Strings.textEnable, false: Strings.textDisable},
                  ),
                  const Gap(16),
                  InlineTextField(
                    labelText: 'motd | ${Strings.fieldMotd}',
                    defaultValue: ServerPropertiesViewModel.defaultValue.motd,
                    value: state.motd,
                    onChanged: (value) => serverPropertiesBloc.add(ServerPropertiesUpdatedEvent(motd: value)),
                  ),
                ],
              );
            }),
      );

  Widget _dropdown<T>({
    required String labelText,
    required Map<T, String> items,
    required T defaultValue,
    required T value,
    required void Function(T) onChanged,
  }) =>
      Builder(
        builder: (context) => Row(
          children: [
            Expanded(
              child: DropdownMenu<T>(
                requestFocusOnTap: false,
                expandedInsets: EdgeInsets.zero,
                inputDecorationTheme: Theme.of(context)
                    .inputDecorationTheme
                    .copyWith(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                label: Text(labelText),
                initialSelection: value,
                onSelected: (value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
                dropdownMenuEntries: items.entries
                    .map((item) => DropdownMenuEntry<T>(
                          value: item.key,
                          label: item.value,
                        ))
                    .toList(),
              ),
            ),
            if (value != defaultValue) ...[
              const Gap(8),
              IconButton.filledTonal(
                tooltip: Strings.tooltipResetToDefault,
                onPressed: () => onChanged(defaultValue),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ],
        ),
      );
}
