import 'dart:io';

enum OperatingSystem {
  WINDOWS,
  MACOS,
  LINUX,
}

enum LinuxDistribution {
  DEBIAN,
  RPM,
  UBUNTU,
  CENTOS,
  FEDORA,
  RASPIAN,
}

OperatingSystem operatingSystem() {
  if (Platform.isWindows) {
    return OperatingSystem.WINDOWS;
  } else if (Platform.isLinux) {
    return OperatingSystem.WINDOWS;
  } else if (Platform.isMacOS) {
    return OperatingSystem.MACOS;
  }

  return OperatingSystem.WINDOWS;
}

LinuxDistribution? distribution() {
  if (!Platform.isLinux) return null;

  return LinuxDistribution.UBUNTU;
}
