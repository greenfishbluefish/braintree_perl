# vim: sw=4 ts=4 ft=perl

package # hide from pause
    WebService::Braintree::Types;

use 5.010_001;
use strictures 1;

use Hash::Inflator;

use Moose;
use Moose::Util::TypeConstraints;

use MooseX::Types -declare => [qw(
    AchMandate
    Address
    AmexExpressCheckoutCard
    AndroidPayCard
    ApplePayCard
    BinData
    CodeRef
    CoinbaseAccount
    ConnectedMerchantPayPalStatusChanged
    ConnectedMerchantStatusTransitioned
    CreditCard
    CreditCardVerification
    Descriptor
    Disbursement
    Dispute
    DisputeTransaction
    DisputeTransactionDetails
    EuropeBankAccount
    GrantedPaymentInstrumentUpdate
    IbanBankAccount
    IdealPayment
    MasterpassCard
    MerchantAccount
    MerchantAccountAddressDetails
    MerchantAccountBusinessDetails
    MerchantAccountFundingDetails
    MerchantAccountIndividualDetails
    PaymentMethodNonce
    PaymentMethodNonceDetails
    PaymentMethodNonce
    PayPalAccount
    Subscription
    ThreeDSecureInfo
    Transaction
    TransactionAddressDetail
    TransactionAmexExpressCheckoutDetail
    TransactionAndroidPayDetail
    TransactionApplePayDetail
    TransactionCoinbaseDetail
    TransactionCreditCardDetail
    TransactionCustomerDetail
    TransactionDisbursementDetail
    TransactionFacilitatedDetail
    TransactionFacilitatorDetail
    TransactionIdealPaymentDetail
    TransactionMasterpassCardDetail
    TransactionPayPalDetail
    TransactionRiskData
    TransactionSubscriptionDetail
    TransactionUsBankAccountDetail
    TransactionVenmoAccountDetail
    TransactionVisaCheckoutCardDetail
    UnknownPaymentMethod
    UsBankAccount
    VenmoAccount
    VisaCheckoutCard

    ArrayRefOfAddOn
    ArrayRefOfAddress
    ArrayRefOfAmexExpressCheckoutCard
    ArrayRefOfAndroidPayCard
    ArrayRefOfApplePayCard
    ArrayRefOfAuthorizationAdjustment
    ArrayRefOfCoinbaseAccount
    ArrayRefOfCreditCard
    ArrayRefOfCreditCardVerification
    ArrayRefOfDiscount
    ArrayRefOfDispute
    ArrayRefOfDisputeEvidence
    ArrayRefOfDisputeHistoryEvent
    ArrayRefOfEuropeBankAccount
    ArrayRefOfMasterpassCard
    ArrayRefOfMerchantAccount
    ArrayRefOfPayPalAccount
    ArrayRefOfSettlementBatchSummaryRecord
    ArrayRefOfSubscription
    ArrayRefOfSubscriptionStatusDetail
    ArrayRefOfTransaction
    ArrayRefOfTransactionStatusDetail
    ArrayRefOfUsBankAccount
    ArrayRefOfVenmoAccount
    ArrayRefOfVisaCheckoutCard

    ErrorResult
    ValidationErrorCollection

    HashInflator
)];

use MooseX::Types::Moose qw(
    ArrayRef HashRef Undef
);

sub build_type {
    my ($class_prefix, $type) = @_;

    my $class = "${class_prefix}::${type}";

    # MooseX::Types cannot handle types with colons in their names.
    $type =~ s/:://g;

    # Even though Moose declares a type with the classname, that's really
    # long. Declare a short version of the classname as a type.
    class_type $type, { class => $class };
    eval qq{
    coerce 'WebService::Braintree::Types::$type',
        from HashRef,
        via { $class->new(\$_) };
    }; if ($@) { die $@ }

    my $x = qq{
        subtype ArrayRefOf${type},
            as ArrayRef[$type];

        coerce ArrayRefOf${type} =>
            from ArrayRef[HashRef],
            via {[ map { $class->new(\$_) } \@{\$_} ]};
    };

#    warn "$x\n" if $type eq 'AchMandate';
#    eval $x; if ($@) {
#        die $@
#    }
}

foreach my $type (qw(
    AccountUpdaterDailyReport
    AchMandate
    AddOn
    Address
    AmexExpressCheckoutCard
    AndroidPayCard
    ApplePay
    ApplePayCard
    ApplePayOptions
    AuthorizationAdjustment
    BinData
    CoinbaseAccount
    ConnectedMerchantPayPalStatusChanged
    ConnectedMerchantStatusTransitioned
    CreditCard
    CreditCardVerification
    Customer
    Descriptor
    Disbursement
    DisbursementDetails
    Discount
    Dispute
    DocumentUpload
    EuropeBankAccount
    GrantedPaymentInstrumentUpdate
    IbanBankAccount
    IdealPayment
    MasterpassCard
    Merchant
    MerchantAccount
    PaymentMethodNonce
    PaymentMethodNonceDetails
    PayPalAccount
    Plan
    SettlementBatchSummary
    SettlementBatchSummaryRecord
    Subscription
    ThreeDSecureInfo
    Transaction
    UnknownPaymentMethod
    UsBankAccount
    VenmoAccount
    VisaCheckoutCard
    WebhookNotification
    Dispute::Evidence
    Dispute::HistoryEvent
    Dispute::Transaction
    Dispute::TransactionDetails
    MerchantAccount::AddressDetails
    MerchantAccount::BusinessDetails
    MerchantAccount::FundingDetails
    MerchantAccount::IndividualDetails
    Subscription::StatusDetail
    Transaction::AddressDetail
    Transaction::AmexExpressCheckoutDetail
    Transaction::AndroidPayDetail
    Transaction::ApplePayDetail
    Transaction::CoinbaseDetail
    Transaction::CreditCardDetail
    Transaction::CustomerDetail
    Transaction::DisbursementDetail
    Transaction::FacilitatedDetail
    Transaction::FacilitatorDetail
    Transaction::IdealPaymentDetail
    Transaction::MasterpassCardDetail
    Transaction::PayPalDetail
    Transaction::RiskData
    Transaction::StatusDetail
    Transaction::SubscriptionDetail
    Transaction::UsBankAccountDetail
    Transaction::VenmoAccountDetail
    Transaction::VisaCheckoutCardDetail
)) {
    build_type('WebService::Braintree::_', $type);
}

# These are unconverted classes
foreach my $type (qw(
    ErrorResult
    ValidationErrorCollection
)) {
    build_type('WebService::Braintree', $type);
}

class_type HashInflator, { class => 'Hash::Inflator' };
coerce HashInflator,
    from HashRef,
    via { Hash::Inflator->new($_) };

1;
__END__
