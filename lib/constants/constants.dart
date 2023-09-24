class Constants {
  static const bool debugBuild = true;

  static const double desiredUfps = 60;
  static const double desiredUdt = 1 / desiredUfps;

  // How many frames we want to catch up on if we fall behind at the most.
  static const double maxFrameCatchup = 10;

  static const desireAspectRatio = 16 / 9;
  static const desiredWidth = 1100.0;
  static const desiredHeight = desiredWidth / desireAspectRatio;
}
