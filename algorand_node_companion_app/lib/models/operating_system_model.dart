import 'package:nodex_companion_app/database/entities.dart';
import 'package:nodex_companion_app/themes/algorand_icons.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/utils/enum_utils.dart';

part 'operating_system_model.g.dart';

@HiveType(typeId: operatingSystemTypeId, adapterName: 'OperatingSystemAdapter')
enum OperatingSystem {
  @HiveField(0)
  UNKNOWN,

  @HiveField(1)
  WINDOWS,

  @HiveField(2)
  MAC,

  @HiveField(3)
  LINUX,

  @HiveField(4)
  DEBIAN,

  @HiveField(5)
  RPM,

  @HiveField(6)
  UBUNTU,

  @HiveField(7)
  CENTOS,

  @HiveField(8)
  FEDORA,

  @HiveField(9)
  RASPBIAN,
}

final osMap = <OperatingSystem, String>{
  OperatingSystem.WINDOWS: 'windows',
  OperatingSystem.MAC: 'macos',
  OperatingSystem.DEBIAN: 'debian',
  OperatingSystem.RPM: 'rpm',
  OperatingSystem.UBUNTU: 'ubuntu',
  OperatingSystem.CENTOS: 'centos',
  OperatingSystem.FEDORA: 'fedora',
  OperatingSystem.RASPBIAN: 'raspbian',
  OperatingSystem.LINUX: 'linux',
};

OperatingSystem parseOperatingSystem(String? operatingSystem) {
  return enumDecodeNullable(
        osMap,
        operatingSystem,
        lenient: true,
        unknownValue: OperatingSystem.UNKNOWN,
      ) ??
      OperatingSystem.UNKNOWN;
}

extension OperatingSystemExtension on OperatingSystem {
  IconData get icon {
    switch (this) {
      case OperatingSystem.WINDOWS:
        return AlgorandIcons.microsoft_windows;
      case OperatingSystem.MAC:
        return AlgorandIcons.apple;
      case OperatingSystem.LINUX:
        return AlgorandIcons.linux;
      case OperatingSystem.RASPBIAN:
        return AlgorandIcons.raspberry_pi;
      default:
        return AlgorandIcons.linux;
    }
  }
}
