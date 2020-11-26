class BadgesInfo {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final List<String> images;

  BadgesInfo(
    this.position, {
    this.name,
    this.iconImage,
    this.description,
    this.images,
  });
}

List<BadgesInfo> badges = [
  BadgesInfo(
    1,
    name: 'Awers brązowej odznaki',
    iconImage: 'assets/images/brazowaOdznaka.png',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis aliquet. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis aliquet. ',
  ),
  BadgesInfo(
    2,
    name: 'Awers srebrnej odznaki',
    iconImage: 'assets/images/srebrnaOdznaka.png',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis aliquet.',
  ),
  BadgesInfo(
    3,
    name: 'Awers złotej odznaki',
    iconImage: 'assets/images/zlotaOdznaka.png',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis aliquet.',
  )
];
