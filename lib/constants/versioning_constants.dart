enum ReleaseVersion {
  alpha,
  beta,
  release,
}

class VersioningConstants {
  static final String version = _getVersion();

  static const _majorVersion = 0;
  static const _minorVersion = 11;
  static const _patchVersion = 1;

  static const _releaseVersion = ReleaseVersion.alpha;

  static String _getVersion() {
    var releaseSuffix = _releaseVersion != ReleaseVersion.release ? _releaseVersion.toString().split('.').last : '';
    return 'v$_majorVersion.$_minorVersion.$_patchVersion $releaseSuffix'.trim();
  }

  static const bool isAlpha = _releaseVersion == ReleaseVersion.alpha;
  static const bool isBeta = _releaseVersion == ReleaseVersion.beta;
}
