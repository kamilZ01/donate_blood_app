class BadgesInfo {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final int minBloodForMale;
  final int maxBloodForMale;
  final int minBloodForFemale;
  final int maxBloodForFemale;

  BadgesInfo(this.position,
      {this.name,
      this.iconImage,
      this.description,
      this.minBloodForMale,
      this.maxBloodForMale,
      this.minBloodForFemale,
      this.maxBloodForFemale});

}

List<BadgesInfo> badges = [
  BadgesInfo(1,
      name: 'Zasłużony Honorowy Dawca Krwi 3 º',
      iconImage: 'assets/images/brazowaOdznaka.png',
      description:
          "Otrzmuje dawcy krwi: \n1) kobiecie, która oddała w dowolnym okresie co najmniej 5 litrów krwi lub odpowiadającą tej objętości ilość jej składników, \n2) mężczyźnie, który oddał w dowolnym okresie co najmniej 6 litrów krwi lub odpowiadającą tej objętości ilość jej składników\n– przysługuje tytuł „Zasłużony Honorowy Dawca Krwi III stopnia” i brązowa odznaka honorowa „Zasłużony Honorowy Dawca Krwi III stopnia”."
      + "Otrzmuje dawcy krwi: \n1) kobiecie, która oddała w dowolnym okresie co najmniej 5 litrów krwi lub odpowiadającą tej objętości ilość jej składników, \n2) mężczyźnie, który oddał w dowolnym okresie co najmniej 6 litrów krwi lub odpowiadającą tej objętości ilość jej składników\n– przysługuje tytuł „Zasłużony Honorowy Dawca Krwi III stopnia” i brązowa odznaka honorowa „Zasłużony Honorowy Dawca Krwi III stopnia”."
              + "Otrzmuje dawcy krwi: \n1) kobiecie, która oddała w dowolnym okresie co najmniej 5 litrów krwi lub odpowiadającą tej objętości ilość jej składników, \n2) mężczyźnie, który oddał w dowolnym okresie co najmniej 6 litrów krwi lub odpowiadającą tej objętości ilość jej składników\n– przysługuje tytuł „Zasłużony Honorowy Dawca Krwi III stopnia” i brązowa odznaka honorowa „Zasłużony Honorowy Dawca Krwi III stopnia”.",
      minBloodForMale: 6000,
      maxBloodForMale: 11999,
      minBloodForFemale: 5000,
      maxBloodForFemale: 9999),
  BadgesInfo(2,
      name: 'Zasłużony Honorowy Dawca Krwi 2 º',
      iconImage: 'assets/images/srebrnaOdznaka.png',
      description:
          "Dawcy krwi:\n1) kobiecie, która oddała w dowolnym okresie co najmniej 10 litrów krwi lub odpowiadającą tej objętości ilość jej składników,\n2) mężczyźnie, który oddał w dowolnym okresie co najmniej 12 litrów krwi lub odpowiadającą tej objętości ilość jej składników\n– przysługuje tytuł „Zasłużony Honorowy Dawca Krwi II stopnia” i srebrna odznaka honorowa „Zasłużony Honorowy Dawca Krwi II stopnia”.",
      minBloodForMale: 10000,
      maxBloodForMale: 17999,
      minBloodForFemale: 12000,
      maxBloodForFemale: 14999),
  BadgesInfo(3,
      name: 'Zasłużony Honorowy Dawca Krwi 1 º',
      iconImage: 'assets/images/zlotaOdznaka.png',
      description:
          "Dawcy krwi:\n1) kobiecie, która oddała w dowolnym okresie co najmniej 15 litrów krwi lub odpowiadającą tej objętości ilość jej składników,\n2) mężczyźnie, który oddał w dowolnym okresie co najmniej 18 litrów krwi lub odpowiadającą tej objętości ilość jej składników\n– przysługuje tytuł „Zasłużony Honorowy Dawca Krwi I stopnia” i złota odznaka honorowa „Zasłużony Honorowy Dawca Krwi I stopnia”.",
      minBloodForMale: 18000,
      maxBloodForMale: -1,
      minBloodForFemale: 15000,
      maxBloodForFemale: -1)
];
