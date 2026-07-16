/// B2B invoice request payload (CDC Partie B).
///
/// Mirrors the backend `InvoiceRequestCreate` schema. Only the questionnaire
/// fields are sent; the order data (amounts, product, vendor constants...) is
/// injected server-side from the frozen order, never re-asked here.
class InvoiceRequestModel {
  InvoiceRequestModel({
    required this.companyName,
    required this.addressStreet,
    required this.addressPostalCode,
    required this.addressCity,
    required this.addressCountry,
    required this.registrationNumber,
    required this.billingEmail,
    this.legalForm,
    this.vatNumber,
    this.contactName,
  });

  final String companyName;
  final String? legalForm;
  final String addressStreet;
  final String addressPostalCode;
  final String addressCity;
  final String addressCountry;
  final String registrationNumber; // SIREN (9) or SIRET (14)
  final String? vatNumber;
  final String billingEmail;
  final String? contactName;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "company_name": companyName,
      "legal_form": legalForm,
      "address_street": addressStreet,
      "address_postal_code": addressPostalCode,
      "address_city": addressCity,
      "address_country": addressCountry,
      "registration_number": registrationNumber,
      "vat_number": vatNumber,
      "billing_email": billingEmail,
      "contact_name": contactName,
    };
  }
}
