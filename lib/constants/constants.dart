class Constants {
  static const bool debugBuild = false;

  static const double desiredUfps = 60;
  static const double desiredUdt = 1 / desiredUfps;

  // How many frames we want to catch up on if we fall behind at the most.
  static const double maxFrameCatchup = 10;
}
