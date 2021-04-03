class Donation {
  final int amount;
  final DateTime donationDate;
  final String donationType;

  Donation(this.amount, this.donationDate, this.donationType);

  factory Donation.fromMap(Map<String, dynamic> donation) {
    return Donation(donation['amount'], donation['donationDate'].toDate(),
        donation['donationType']);
  }
}
