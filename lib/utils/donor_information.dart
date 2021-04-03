import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/entities/donation.dart';

class DonorInformation {
  DateTime lastDonation;
  String typeOfLastDonation = "N/A";
  int totalAmountOfBloodDonated = 0;
  int totalAmountOfDonatedBloodInCurrentYear = 0;
  int totalAmountOfDonatedBloodInLastYear = 0;
  int nextBadgeFor;
  List<Donation> donations;

  DonorInformation(this.donations) {
    calcDonorInformation();
  }

  factory DonorInformation.fromDonationsMap(
      Map<int, QueryDocumentSnapshot> donationsMap) {
    List<Donation> donationsList = [];
    donationsMap.values.forEach((donation) {
      donationsList.add(Donation.fromMap(donation.data()));
    });
    return DonorInformation(donationsList);
  }

  void calcDonorInformation() {
    lastDonation = donations.first.donationDate;
    typeOfLastDonation = donations.first.donationType;
    donations.forEach((donation) {
      calcTotalAmountOfDonatedBlood(donation);
      calcTotalAmountOfDonatedBloodInCurrentYear(donation);
      calcTotalAmountOfDonatedBloodInLastYear(donation);
    });
  }

  void calcTotalAmountOfDonatedBlood(Donation donation) {
    totalAmountOfBloodDonated += donation.amount;
  }

  void calcTotalAmountOfDonatedBloodInCurrentYear(Donation donation) {
    if(isCurrentYear(donation.donationDate))
      totalAmountOfDonatedBloodInCurrentYear += donation.amount;
  }

  bool isCurrentYear(DateTime donationDate) {
    return donationDate.year == DateTime.now().year;
  }

  void calcTotalAmountOfDonatedBloodInLastYear(Donation donation) {
    if(isLastYear(donation.donationDate))
      totalAmountOfDonatedBloodInLastYear += donation.amount;
  }

  bool isLastYear(DateTime donationDate) {
    return donationDate.year == DateTime.now().year - 1;
  }

  Timestamp getLastDonationTimestamp() {
    return Timestamp.fromDate(lastDonation);
  }
}
