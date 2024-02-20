import 'package:ecommerce_mobile_login/src/utils/common_exports.dart';

class UserModel extends LoginModel {
  final int id;
  final bool admin;
  final bool kicked;
  final String? url;
  final String? name;
  final String email;
  final bool sysadmin;
  final String? title;
  final bool posUsage;
  final String? lastIp;
  final bool ajaxState;
  final String? preName;
  final String? company;
  final String? logData;
  final String nickname;
  final String? position;
  final String? birthDay;
  final String? password;
  final String? oTPLogin;
  final String? orderData;
  final String? department;
  final String? loginToken;
  final String? contactFax;
  final String? salutation;
  final String? profileText;
  final String? mobilePhone;
  final String? userHistory;
  final String? orgUnitData;
  final String? billSepaLog;
  final bool reloadSettings;
  final String? xingProfile;
  final String? registerDate;
  final String? lastProvider;
  final String? profileImage;
  final String? customerData;
  final String? contactPhone;
  final bool activateRestApi;
  final String? supplierData;
  final String? userSepaData;
  final String restApiSecret;
  final String? lastLoginTime;
  final List<String> language;
  final String? userAssetData;
  final String uniqueUserHash;
  final String? billDetailRule;
  final String? bookingAccount;
  final int acceptedAgbVersion;
  final String? twitterProfile;
  final String? linkedInProfile;
  final String? facebookProfile;
  final String? userAddressData;
  final String? userContactData;
  final String? pageAnalyzerJob;
  final bool userAuthentication;
  final String? eventParticipant;
  final String? announcementData;
  final bool adminAuthentication;
  final List<UserGroup> userGroup;
  final String? userConfiguration;
  final List<UserRight> userRights;
  final String? orderDataAssistant;
  final String? newsletterMailData;
  final String? consultantNoteData;
  final String? knowledgeBaseEntry;
  final String? passwordChangeDate;
  final String? userDirectLoginLink;
  final String? appRegistrationHash;
  final String? eventPageUserDataNote;
  final String? userAuthenticationCode;
  final bool isStockCountExportEnabled;
  final String? userSpecificPdfTemplate;
  final String? pointOfSalesCountReport;
  final String? productTestUserDataNote;
  final String? recurringOrderDetailRule;
  final String? bonusPointSharingCompany;
  final String? userMobileAppRegistration;
  final String? bonusPointTransactionData;
  final String? customerRelationshipNotes;
  final String? userSpecificPaymentOption;
  final bool activateUserSpecificOrderAPI;
  final String userSpecificPriceCalculation;
  final bool activateUserSpecificProductAPI;
  final String? eventPageUserDataAssociation;
  final String? newsletterRegistrationSetting;
  final String? productInventoryItemCountData;
  final bool activateUserSpecificDropShipping;
  final String? productTestUserDataAssociation;
  final String? individualPriceCalculationRule;
  final String? pageAnalyzerPageAnalysisResult;
  final bool userSpecificExportWithCommaPrices;
  final String? bonusPointManagementTerminalPin;
  final bool isTwoFactorAuthenticationActivated;
  final bool isUserSpecificProductExportEnabled;
  final String? bonusPointSharingCompanyEmployee;
  final bool provideUserSpecificStockInformation;
  final bool userSpecificExportWithRoundedPrices;
  final String? twoFactorAuthenticationSecretLink;
  final String? bonusPointTransactionDataCompanyAssistant;

  UserModel({
    this.url,
    this.name,
    this.title,
    this.lastIp,
    this.preName,
    this.logData,
    this.company,
    this.birthDay,
    this.password,
    this.position,
    this.oTPLogin,
    this.orderData,
    this.salutation,
    this.department,
    this.contactFax,
    this.billSepaLog,
    this.loginToken,
    this.orgUnitData,
    this.xingProfile,
    required this.id,
    this.userHistory,
    this.profileText,
    this.mobilePhone,
    this.customerData,
    this.profileImage,
    this.lastProvider,
    this.contactPhone,
    this.supplierData,
    this.userSepaData,
    this.registerDate,
    this.lastLoginTime,
    this.userAssetData,
    this.twitterProfile,
    this.bookingAccount,
    this.billDetailRule,
    required this.email,
    required this.admin,
    this.userAddressData,
    this.pageAnalyzerJob,
    this.userContactData,
    this.linkedInProfile,
    this.facebookProfile,
    required this.kicked,
    this.eventParticipant,
    this.announcementData,
    required this.nickname,
    required this.sysadmin,
    required this.language,
    required this.posUsage,
    this.userConfiguration,
    this.newsletterMailData,
    this.consultantNoteData,
    this.orderDataAssistant,
    this.knowledgeBaseEntry,
    this.passwordChangeDate,
    required this.ajaxState,
    required this.userGroup,
    this.userDirectLoginLink,
    required this.userRights,
    this.appRegistrationHash,
    this.eventPageUserDataNote,
    required this.restApiSecret,
    this.userAuthenticationCode,
    required this.uniqueUserHash,
    required this.reloadSettings,
    this.pointOfSalesCountReport,
    this.productTestUserDataNote,
    this.userSpecificPdfTemplate,
    required this.activateRestApi,
    this.recurringOrderDetailRule,
    this.bonusPointSharingCompany,
    this.bonusPointTransactionData,
    this.userSpecificPaymentOption,
    this.customerRelationshipNotes,
    this.userMobileAppRegistration,
    required this.acceptedAgbVersion,
    required this.userAuthentication,
    required this.adminAuthentication,
    this.eventPageUserDataAssociation,
    this.newsletterRegistrationSetting,
    this.productInventoryItemCountData,
    this.productTestUserDataAssociation,
    this.pageAnalyzerPageAnalysisResult,
    this.individualPriceCalculationRule,
    this.bonusPointManagementTerminalPin,
    this.bonusPointSharingCompanyEmployee,
    this.twoFactorAuthenticationSecretLink,
    required this.isStockCountExportEnabled,
    required this.userSpecificPriceCalculation,
    required this.activateUserSpecificOrderAPI,
    required this.activateUserSpecificProductAPI,
    required this.activateUserSpecificDropShipping,
    this.bonusPointTransactionDataCompanyAssistant,
    required this.userSpecificExportWithCommaPrices,
    required this.isTwoFactorAuthenticationActivated,
    required this.isUserSpecificProductExportEnabled,
    required this.userSpecificExportWithRoundedPrices,
    required this.provideUserSpecificStockInformation,
    required super.key,
    required super.lang,
    required super.userData,
    required super.loginType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      url: json['url']?.toString(),
      admin: json['admin'] as bool,
      name: json['name']?.toString(),
      kicked: json['kicked'] as bool,
      title: json['title']?.toString(),
      email: json['eMail'].toString(),
      id: json['id'].toString().toInt(),
      lastIp: json['lastIP']?.toString(),
      posUsage: json['posUsage'] as bool,
      sysadmin: json['sysadmin'] as bool,
      preName: json['preName']?.toString(),
      company: json['company']?.toString(),
      ajaxState: json['ajaxState'] as bool,
      logData: json['LogData']?.toString(),
      nickname: json['nickName'].toString(),
      birthDay: json['birthday']?.toString(),
      password: json['password']?.toString(),
      position: json['position']?.toString(),
      oTPLogin: json['OTPLogin']?.toString(),
      orderData: json['OrderData']?.toString(),
      loginToken: json['LoginToken']?.toString(),
      salutation: json['salutation']?.toString(),
      contactFax: json['contactFax']?.toString(),
      department: json['department']?.toString(),
      userHistory: json['UserHistory']?.toString(),
      profileText: json['profileText']?.toString(),
      mobilePhone: json['mobilePhone']?.toString(),
      orgUnitData: json['OrgUnitData']?.toString(),
      xingProfile: json['xingProfile']?.toString(),
      billSepaLog: json['BillSepaLog']?.toString(),
      supplierData: json['SupplierData']?.toString(),
      userSepaData: json['UserSepaData']?.toString(),
      registerDate: json['registerDate']?.toString(),
      lastProvider: json['lastProvider']?.toString(),
      profileImage: json['profileImage']?.toString(),
      customerData: json['CustomerData']?.toString(),
      contactPhone: json['contactPhone']?.toString(),
      reloadSettings: json['reloadSettings'] as bool,
      restApiSecret: json['restApiSecret'].toString(),
      userAssetData: json['UserAssetData']?.toString(),
      lastLoginTime: json['lastLoginTime']?.toString(),
      activateRestApi: json['activateRestApi'] as bool,
      uniqueUserHash: json['uniqueUserHash'].toString(),
      activateUserSpecificOrderAPI:
          json['activateUserSpecificOrderAPI'] as bool,
      billDetailRule: json['BillDetailRule']?.toString(),
      bookingAccount: json['bookingAccount']?.toString(),
      twitterProfile: json['twitterProfile']?.toString(),
      userAddressData: json['UserAddressData']?.toString(),
      userContactData: json['UserContactData']?.toString(),
      linkedInProfile: json['linkedInProfile']?.toString(),
      facebookProfile: json['facebookProfile']?.toString(),
      pageAnalyzerJob: json['PageAnalyzerJob']?.toString(),
      userSpecificPriceCalculation:
          json['userSpecificPriceCalculation'].toString(),
      eventPageUserDataAssociation:
          json['EventPageUserDataAssociation']?.toString(),
      activateUserSpecificProductAPI:
          json['activateUserSpecificProductAPI'] as bool,
      productInventoryItemCountData:
          json['ProductInventoryItemCountData']?.toString(),
      newsletterRegistrationSetting:
          json['NewsletterRegistrationSetting']?.toString(),
      individualPriceCalculationRule:
          json['individualPriceCalculationRule']?.toString(),
      announcementData: json['AnnouncementData']?.toString(),
      eventParticipant: json['EventParticipant']?.toString(),
      userAuthentication: json['userAuthentication'] as bool,
      productTestUserDataAssociation:
          json['ProductTestUserDataAssociation']?.toString(),
      activateUserSpecificDropShipping:
          json['activateUserSpecificDropShipping'] as bool,
      bonusPointManagementTerminalPin:
          json['bonusPointManagementTerminalPin']?.toString(),
      userSpecificExportWithCommaPrices:
          json['userSpecificExportWithCommaPrices'] as bool,
      pageAnalyzerPageAnalysisResult:
          json['PageAnalyzerPageAnalysisResult']?.toString(),
      userConfiguration: json['UserConfiguration']?.toString(),
      language: (json['Language'] as List?)?.castToListOfString() ?? [],
      bonusPointSharingCompanyEmployee:
          json['BonusPointSharingCompanyEmployee']?.toString(),
      isUserSpecificProductExportEnabled:
          json['isUserSpecificProductExportEnabled'] as bool,
      twoFactorAuthenticationSecretLink:
          json['twoFactorAuthenticationSecretLink']?.toString(),
      provideUserSpecificStockInformation:
          json['provideUserSpecificStockInformation'] as bool,
      userSpecificExportWithRoundedPrices:
          json['userSpecificExportWithRoundedPrices'] as bool,
      adminAuthentication: json['adminAuthentication'] as bool,
      newsletterMailData: json['NewsletterMailData']?.toString(),
      consultantNoteData: json['ConsultantNoteData']?.toString(),
      knowledgeBaseEntry: json['KnowledgeBaseEntry']?.toString(),
      passwordChangeDate: json['passwordChangeDate']?.toString(),
      orderDataAssistant: json['OrderData_Assistant']?.toString(),
      appRegistrationHash: json['appRegistrationHash']?.toString(),
      userDirectLoginLink: json['UserDirectLoginLink']?.toString(),
      isTwoFactorAuthenticationActivated:
          json['isTwoFactorAuthenticationActivated'] as bool,
      eventPageUserDataNote: json['EventPageUserDataNote']?.toString(),
      userRights: UserRight.toList(
          (json['UserRight'] as List).castToListOfMapOfStringDynamic()),
      userGroup: UserGroup.toList(
          (json['UserGroup'] as List).castToListOfMapOfStringDynamic()),
      bonusPointTransactionDataCompanyAssistant:
          json['BonusPointTransactionDataCompanyAssistant']?.toString(),
      acceptedAgbVersion: json['acceptedAgbVersion'].toString().toInt(),
      userAuthenticationCode: json['userAuthenticationCode']?.toString(),
      pointOfSalesCountReport: json['PointOfSalesCountReport']?.toString(),
      productTestUserDataNote: json['ProductTestUserDataNote']?.toString(),
      userSpecificPdfTemplate: json['userSpecificPdfTemplate']?.toString(),
      isStockCountExportEnabled: json['isStockCountExportEnabled'] as bool,
      bonusPointSharingCompany: json['BonusPointSharingCompany']?.toString(),
      recurringOrderDetailRule: json['RecurringOrderDetailRule']?.toString(),
      bonusPointTransactionData: json['BonusPointTransactionData']?.toString(),
      userMobileAppRegistration: json['UserMobileAppRegistration']?.toString(),
      customerRelationshipNotes: json['CustomerRelationshipNotes']?.toString(),
      userSpecificPaymentOption: json['userSpecificPaymentOption']?.toString(),
      key: json['key'].toString(),
      lang: json['lang'].toString(),
      userData: json['UserData'],
      loginType: json['loginType'].toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'id': id,
        'url': url,
        'name': name,
        'eMail': email,
        'title': title,
        'admin': admin,
        'lastIp': lastIp,
        'kicked': kicked,
        'preName': preName,
        'company': company,
        'LogData': logData,
        'nickName': nickname,
        'position': position,
        'birthday': birthDay,
        'password': password,
        'sysadmin': sysadmin,
        'OTPLogin': oTPLogin,
        'posUsage': posUsage,
        'OrderData': orderData,
        'ajaxState': ajaxState,
        'department': department,
        'salutation': salutation,
        'LoginToken': loginToken,
        'contactFax': contactFax,
        'xingProfile': xingProfile,
        'UserHistory': userHistory,
        'profileText': profileText,
        'OrgUnitData': orgUnitData,
        'mobilePhone': mobilePhone,
        'BillSepaLog': billSepaLog,
        'SupplierData': supplierData,
        'UserSepaData': userSepaData,
        'registerDate': registerDate,
        'lastProvider': lastProvider,
        'profileImage': profileImage,
        'CustomerData': customerData,
        'contactPhone': contactPhone,
        'UserAssetData': userAssetData,
        'restApiSecret': restApiSecret,
        'lastLoginTime': lastLoginTime,
        'reloadSettings': reloadSettings,
        'BillDetailRule': billDetailRule,
        'twitterProfile': twitterProfile,
        'uniqueUserHash': uniqueUserHash,
        'bookingAccount': bookingAccount,
        'UserAddressData': userAddressData,
        'UserContactData': userContactData,
        'activateRestApi': activateRestApi,
        'facebookProfile': facebookProfile,
        'PageAnalyzerJob': pageAnalyzerJob,
        'linkedInProfile': linkedInProfile,
        'EventParticipant': eventParticipant,
        'AnnouncementData': announcementData,
        'isTwoFactorAuthenticationActivated':
            isTwoFactorAuthenticationActivated,
        'UserConfiguration': userConfiguration,
        'isUserSpecificProductExportEnabled':
            isUserSpecificProductExportEnabled,
        'provideUserSpecificStockInformation':
            provideUserSpecificStockInformation,
        'userSpecificExportWithRoundedPrices':
            userSpecificExportWithRoundedPrices,
        'passwordChangeDate': passwordChangeDate,
        'acceptedAgbVersion': acceptedAgbVersion,
        'NewsletterMailData': newsletterMailData,
        'ConsultantNoteData': consultantNoteData,
        'userAuthentication': userAuthentication,
        'OrderData_Assistant': orderDataAssistant,
        'adminAuthentication': adminAuthentication,
        'appRegistrationHash': appRegistrationHash,
        'UserDirectLoginLink': userDirectLoginLink,
        'KnowledgeBaseEntry': knowledgeBaseEntry,
        'BonusPointTransactionDataCompanyAssistant':
            bonusPointTransactionDataCompanyAssistant,
        'Language': language.map((e) => e.toString()),
        'UserGroup': userGroup.map((e) => e.toJson()),
        'UserRight': userRights.map((e) => e.toJson()),
        'EventPageUserDataNote': eventPageUserDataNote,
        'userAuthenticationCode': userAuthenticationCode,
        'userSpecificPdfTemplate': userSpecificPdfTemplate,
        'ProductTestUserDataNote': productTestUserDataNote,
        'PointOfSalesCountReport': pointOfSalesCountReport,
        'RecurringOrderDetailRule': recurringOrderDetailRule,
        'BonusPointSharingCompany': bonusPointSharingCompany,
        'BonusPointTransactionData': bonusPointTransactionData,
        'UserMobileAppRegistration': userMobileAppRegistration,
        'userSpecificPaymentOption': userSpecificPaymentOption,
        'isStockCountExportEnabled': isStockCountExportEnabled,
        'CustomerRelationshipNotes': customerRelationshipNotes,
        'userSpecificPriceCalculation': userSpecificPriceCalculation,
        'EventPageUserDataAssociation': eventPageUserDataAssociation,
        'activateUserSpecificOrderAPI': activateUserSpecificOrderAPI,
        'NewsletterRegistrationSetting': newsletterRegistrationSetting,
        'ProductInventoryItemCountData': productInventoryItemCountData,
        'individualPriceCalculationRule': individualPriceCalculationRule,
        'activateUserSpecificProductAPI': activateUserSpecificProductAPI,
        'PageAnalyzerPageAnalysisResult': pageAnalyzerPageAnalysisResult,
        'ProductTestUserDataAssociation': productTestUserDataAssociation,
        'bonusPointManagementTerminalPin': bonusPointManagementTerminalPin,
        'BonusPointSharingCompanyEmployee': bonusPointSharingCompanyEmployee,
        'activateUserSpecificDropShipping': activateUserSpecificDropShipping,
        'twoFactorAuthenticationSecretLink': twoFactorAuthenticationSecretLink,
        'userSpecificExportWithCommaPrices': userSpecificExportWithCommaPrices,
      };
}
