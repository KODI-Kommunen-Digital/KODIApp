class AppEnv {
  final String name;
  final String domain;
  final String picturesURL;
  final String defaultPictureURL;
  final bool debug;

  const AppEnv({
    required this.name,
    required this.domain,
    required this.picturesURL,
    required this.defaultPictureURL,
    this.debug = true,
  });

  static const staging = AppEnv(
    name: "staging",
    domain: "http://116.203.1.1:3001/v2/",
    picturesURL: "https://gera1heidi.obs.eu-de.otc.t-systems.com/",
    defaultPictureURL: "https://smrauf1heidi.obs.eu-de.otc.t-systems.com/admin/ProfilePicture.png",
    debug: true,
  );

  static const production = AppEnv(
    name: "production",
    domain: "http://116.203.1.1:3001/v2/",
    picturesURL: "https://gera1heidi.obs.eu-de.otc.t-systems.com/",
    defaultPictureURL: "https://smrauf1heidi.obs.eu-de.otc.t-systems.com/admin/ProfilePicture.png",
    debug: false,
  );
}
