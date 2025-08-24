import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/preview_model.dart';
import '../../data/model/price.dart';
import '../config/icon_config.dart';


List<PreviewModel> onBoardingList = [
  PreviewModel(
      body:
      'Since its beginning.Velvet \n cream was a local hangout \n for the city Youth'.tr,
      title: 'Socialize'.tr,
      image: ImageAsset.onBoardingImageTwo),
  PreviewModel(
      body:
      'No longer content with just fries \n customer preferences shifted \n towards more sophisticated tastes.'.tr,
      title: 'Love Food'.tr,
      image: ImageAsset.onBoardingImageOne),
  PreviewModel(
      body:
      'Always the most objective reviews \n of food from top reviewers.'.tr,
      title: 'Review'.tr,
      image: ImageAsset.onBoardingImageThree),
];

class ValidationRegex{
 static String validationEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

 static String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
 static String passwordRegex=r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
 // static String alphapetPattern = r'^[A-Za-z]+$/';
 static String alphapetNumbericPattern = r'^[a-zA-Z0-9_]*$';
 static final  validCharacters =RegExp(r'^[a-zA-Z_ ]*$');
  final  validCharacters1 =RegExp('^[a-zA-Z]');
  final numberPlates = RegExp(r'^[A-Z0-9-]+$');

}

class  NameValues{
  NameValues._();
static   String singIn='Sign In';
  static String singInWithYourEmail='Sign In with your email';

  static String singUP='Sign Up';
  static String singUPWithYourEmail='Sign Up with your email';
  static String email='Email';
  static String firstName='First Name';
  static String lastName='Last Name';
  static String mobileNumber='Mobile Number';
  static String location='Location';
  static String password='Password';
  static String confirmPassword='Confirm Password';
  static String selectSize='Select Size';
  static String chooseQuanity='Choose Quanity';
  static String chooseSize='Size';
  static String customizeCategory='Customize Category';
  static String customizeOrder='Customize order';
  static String customizeOrderSubText='You can add more toppings';
  static String add='ADD';
  static String productupdate='Update';
  static String nothingFavourite='Nothing in Favorites !';
  static String nothingCart='Nothing in Cart !';
  static String changePassword='Change Password';
  static String forgotPassword='Forgot Password';
  static String changePasswordSubtitle='Create a new password and please never share it with anyone for safe use';
  static String keyValues='rpH384l8rT02vnH4rpH3';
  static String privacyPollicy='Privacy Policy';
  static String contactUs='Contact Us';
  static String giftCard='Gift Card';
  static String giftCardHistory='Gift Card History';
  static String enterGiftCardAmount='Please Enter Amount';
  static String aboutUs='About Us';
  static String myOrders='My Orders';
  static String orderDetails='Order Details';
  static String rewardsProduct='Reward Products';
  static int terminalValues=5271001;
  static String integrationId="00705796-6e0d-44d1-a065-523645a41aee";
  static String authToken="ceab7d0dfd06a1d386142dde4eece3d2adf67d8c0c06a345f7533f110823bf50e3b2941f4dcaf31d77214cc21b870908ce7225a619e709d0fc37f3de8ffaec5c";
  static String pleaseEnterMobileNumber='Please Enter Mobile Number';
  static String pleaseEnterValidMobileNumber='Please Enter Valid Mobile Number';
  static String pleaseEnterEmail='Please Enter Email';
  static String pleaseEnterValidEmail='Please Enter Valid Email';
  static String pleaseEnterFirstName='Please Enter First Name';
  static String pleaseEnterValidFirstName='Please Enter Valid Firstname';
  static String pleaseEnterFullName='Please Enter Full Name';
  static String pleaseEnterLastName='Please Enter Last Name';
  static String pleaseEnterValidLastName='Please Enter Valid Last Name';
  static String pleaseEnterLocation='Please Enter Location';
  static String pleaseEnterPassword='Please Enter Password';
  static String pleaseEnterConfirmPassword='Please Enter Confirm Password';
  static String pleaseWrongPassword='Your password must contain at least 8 characters, including one special character and one uppercase letter.';
  static String passwordNotMatch='The password and confirm password do not match.';
  static String login='Sign In';
  static String pickFromGallery='Pick From Gallery';
  static String pickFromCamera='Pick From Camera';
  static String completeYourProfile='Complete your profile';
  static String change='Change';
  static String update="Update";
  static String updateProfile="Update Profile";
  static String myProfile="My Profile";
  static String history="Our History";
  static String rewards="Rewards";
  static String wallet="Dip Wallet";
  static String logout="Log out";
  static String deleteAccount="Delete Account";
  static String withoutLogin="Login to your account";
  static String favorite="My Favorite";
  static String products="Products";
  static String cart="Cart";
  static String payment="Payment";
  static String checkout="Checkout";
  static String scheduleLater="Schedule for later";
  static String orderNow="Order Now";
  static String paymentMethod="Payment Method";
  static String creditCardOrDebitCard="Credit Card / Debit Card";
  static String gPay="G Pay";
  static String browseProduct="Browse product";
  static String proceedToPay="Proceed to Pay";
  static String reOrder="Reorder";
  static String finalTotal="Final Total";
  static String discount="Discount";
  static String remove="Remove";
  static String apply="Apply";
  static String orderTotal="Order Total";
  static String orderMode="Order Mode";
  static String driveThru="Drive Thru";
  //static String giftCard="Gift Card";
  static String pleaseEnterAmount='Please Enter Amount';
  static String amount='Amount';
  static String message='Message';
  static String pleaseEnterValidAmount='Please Enter Valid Amount';
  static String pleaseEnterCode='Please Enter Coupon Code';
  static String couponCode='Coupon Code';
  static String pleaseUseDipWallet='Please use Dip Wallet to Topup your Account';
  static String notCheckIn='Currently No Active Orders,Please place the order to proceed with Check-in.';
  static String activeOrder='Active order';
  static String createGiftCard='Create Gift Card';
  static String purchasedGiftCards='Purchased Gift Cards';
  static String myTransactions='My Transactions';
  static String rewardPointsPurchasedFor='Reward Product Purchased for';
  static String tryAgain='Try Again';
  static String nothingInYourRewardProducts='Nothing in your Reward Products';
  static String guest='Continue As Guest';
  static String youHaveNoOrders='You have no orders';
  static String yourOrders='Your Order';
  static String pleaseEnterValidPassword='Please Enter Valid Password';
  static String backToHome='Back To Home';
}

// class ContactUsContent{
//    String onlineOrderingTitle="Online Ordering";
//   static String onlineOrderingContent='Your will be notified of your order status via our new Mobile App when your order is ready for pickup.  Please enable location in your app to allow us to have your order at the window when you arrive!';
//   static String openingHrsTitle='Opening Hours';
//   static String openingHrsNote='Note: The Following List is our Walk-Up Closing Times.';
//   static String openingHrsContent='(The Online order portal will be unavailable 30 minutes before closing for end of day procedures)';
//   static String openingHrsDayContent=' Monday: 11:00am – 10:00pm \n Tuesday: 11:00am – 10:00pm \n Wednesday: 11:00am – 10:00pm \n Thursday: 11:00am  – 10:00pm \n Friday: 11:00am  – 10:00pm \n Saturday: 11:00am – 10:00pm \n Sunday: 11:00am – 9:00pm';
//   static String driveThruServiceTitle='Drive Thru Service';
//   static String driveThruServiceContent=' Stay tuned for our newly redesigned drive-thru kiosk.  This state of the art system will allow you to order, pay and pickup you purchases much more efficiently.';
//   static String contactLocationTitle='Contact Location';
//   static String contactLocationSubtitle='Come see us today!';
//   static String contactLocationContent='We’re ready to tempt your tastebuds with made-to-order favorites. We’re located just two blocks north of the historic DeSoto County courthouse in Hernando, Mississippi. ';
// }
class PrivacyPolicy{
  static String privacyPolicy1="Protecting your private information is our priority. This Statement of Privacy applies to www.dipmenu.com and Velvet Cream and governs data collection and usage. For the purposes of this Privacy Policy, unless otherwise noted, all references to Velvet Cream include www.dipmenu.com and The Dip. The The Dip website is a self-service ordering site. By using the The Dip website, you consent to the data practices described in this statement.";
  static String privacyPolicy2='Use of your Personal Information';
  static String privacyPolicy3='The Dip collects and uses your personal information to operate its website(s) and deliver the services you have requested.';
  static String privacyPolicy4='The Dip may also use your personally identifiable information to inform you of other products or services available from The Dip and its affiliates.';
  static String privacyPolicyLocationAccessTittle='Location Data Usage';
  static String privacyPolicyLocationAccessContent='We use background location access to track your location only during active orders for food delivery purposes. Your location data is used to notify the shop for order preparation and ensure timely delivery.';
  static String privacyPolicyLocationAccessPoint1='- Purpose: To facilitate smooth order management and delivery.';
  static String privacyPolicyLocationAccessPoint2='- Duration: Location tracking stops immediately once your order is delivered.';
  static String privacyPolicyLocationAccessPoint3='- Data Storage: We do not store your location data after delivery.';
  static String privacyPolicyLocationAccessPoint4='- Data Sharing: Your location data is not shared with any unauthorized parties.';

  static String privacyPolicy5='Collection of your Personal Information';
  static String privacyPolicy6='In order to better provide you with products and services offered on our Site, The Dip may collect personally identifiable information, such as your:';
  // static String privacyPolicy7='Collection of your Personal Information';
  // static String privacyPolicy8='Collection of your Personal Information';
  // static String privacyPolicy9='Collection of your Personal Information';
  static String collectioOfInfoTitle='- First and Last Name - Mailing Address - E-mail Address - Phone Number \n if you purchase The Dip\'s products and services, we collect billing and credit card information. This information is used to complete the purchase transaction. \n We do not collect any personal information about you unless you voluntarily provide it to us. However, you may be required to provide certain personal information to us when you elect to use certain products or services available on the Site. These may include: (a) registering for an account on our Site; (b) entering a sweepstakes or contest sponsored by us or one of our partners; (c) signing up for special offers from selected third parties; (d) sending us an email message; (e) submitting your credit card or other payment information when ordering and purchasing products and services on our Site. To wit, we will use your information for, but not limited to, communicating with you in relation to services and/or products you have requested from us. We also may gather additional personal or non-personal information in the future.';
  static String collectioOfInfoContent1='if you purchase The Dip\'s products and services, we collect billing and credit card information. This information is used to complete the purchase transaction. \n We do not collect any personal information about you unless you voluntarily provide it to us. However, you may be required to provide certain personal information to us when you elect to use certain products or services available on the Site. These may include: (a) registering for an account on our Site; (b) entering a sweepstakes or contest sponsored by us or one of our partners; (c) signing up for special offers from selected third parties; (d) sending us an email message; (e) submitting your credit card or other payment information when ordering and purchasing products and services on our Site. To wit, we will use your information for, but not limited to, communicating with you in relation to services and/or products you have requested from us. We also may gather additional personal or non-personal information in the future.';
  static String collectioOfInfoContent2='We do not collect any personal information about you unless you voluntarily provide it to us. However, you may be required to provide certain personal information to us when you elect to use certain products or services available on the Site. These may include: (a) registering for an account on our Site; (b) entering a sweepstakes or contest sponsored by us or one of our partners; (c) signing up for special offers from selected third parties; (d) sending us an email message; (e) submitting your credit card or other payment information when ordering and purchasing products and services on our Site. To wit, we will use your information for, but not limited to, communicating with you in relation to services and/or products you have requested from us. We also may gather additional personal or non-personal information in the future.';
  static String sharingInfoTitle='Sharing Information with Third Parties';
  static String sharingInfoContent1='The Dip does not sell, rent or lease its customer lists to third parties.\n The Dip may share data with trusted partners to help perform statistical analysis, send you email or postal mail, provide customer support, or arrange for deliveries. All such third parties are prohibited from using your personal information except to provide these services to The Dip, and they are required to maintain the confidentiality of your information.';
  static String sharingInfoContent2='The Dip may disclose your personal information, without notice, if required to do so by law or in the good faith belief that such action is necessary to: (a) conform to the edicts of the law or comply with legal process served on The Dip or the site; (b) protect and defend the rights or property of The Dip; and/or (c) act under exigent circumstances to protect the personal safety of users of The Dip, or the public.';
  static String autoSharingInfoTitle='Automatically Collected Information';
  static String autoSharingInfoContent='Information about your computer hardware and software may be automatically collected by The Dip. This information can include: your IP address, browser type, domain names, access times and referring website addresses. This information is used for the operation of the service, to maintain quality of the service, and to provide general statistics regarding use of the The Dip website.';
  static String useCookiesTitle='Use of Cookies';
  static String useCookiesContent='The The Dip website may use "cookies" to help you personalize your online experience. A cookie is a text file that is placed on your hard disk by a web page server. Cookies cannot be used to run programs or deliver viruses to your computer. Cookies are uniquely assigned to you, and can only be read by a web server in the domain that issued the cookie to you.\n '
      'One of the primary purposes of cookies is to provide a convenience feature to save you time. The purpose of a cookie is to tell the Web server that you have returned to a specific page. For example, if you personalize The Dip pages, or register with The Dip site or services, a cookie helps The Dip to recall your specific information on subsequent visits. This simplifies the process of recording your personal information, such as billing addresses, shipping addresses, and so on. When you return to the same The Dip website, the information you previously provided can be retrieved, so you can easily use the The Dip features that you customized.\n'
      'You have the ability to accept or decline cookies. Most Web browsers automatically accept cookies, but you can usually modify your browser setting to decline cookies if you prefer. If you choose to decline cookies, you may not be able to fully experience the interactive features of the The Dip services or websites you visit.';
  static String securityPersonalInfoTitle='Security of your Personal Information';
  static String securityPersonalInfoContent='The Dip secures your personal information from unauthorized access, use, or disclosure. The Dip uses the following methods for this purpose:\n '
      '- SSL Protocol\n'
      'When personal information (such as a credit card number) is transmitted to other websites, it is protected through the use of encryption, such as the Secure Sockets Layer (SSL) protocol.\n'
      'We strive to take appropriate security measures to protect against unauthorized access to or alteration of your personal information. Unfortunately, no data transmission over the Internet or any wireless network can be guaranteed to be 100% secure. As a result, while we strive to protect your personal information, you acknowledge that: (a) there are security and privacy limitations inherent to the Internet which are beyond our control; and (b) security, integrity, and privacy of any and all information and data exchanged between you and us through this Site cannot be guaranteed.';
  static String childrenthirteenTitle='Children Under Thirteen';
  static String childrenthirteenContent='The Dip does not knowingly collect personally identifiable information from children under the age of thirteen. If you are under the age of thirteen, you must ask your parent or guardian for permission to use this website.';
  static String changesStatementTitle='Changes to this Statement';
  static String changesStatementContent='The Dip reserves the right to change this Privacy Policy from time to time. We will notify you about significant changes in the way we treat personal information by sending a notice to the primary email address specified in your account, by placing a prominent notice on our site, and/or by updating any privacy information on this page. Your continued use of the Site and/or Services available through this Site after such modifications will constitute your: (a) acknowledgment of the modified Privacy Policy; and (b) agreement to abide and be bound by that Policy.';
  static String questionsTitle='Questions or Comments';
  static String questionsContent='The Dip welcomes your questions or comments regarding this Statement of Privacy. If you believe that The Dip has not adhered to this Statement, please contact The Dip at:\n'
      'Velvet Cream 2290 Hwy 51 S Hernando, Mississippi 38632\n '
      'Email Address: velvetcream@gmail.com  \n Effective as of January 22, 2020';
  static String refundPolicyTitle='Refund/Cancellation Policy';
  static String refundPolicyContent='Once payment has been processed and received by the merchant (Velvet Cream or The Dip), there will be no refunds or cancellations processed. Submittal of payment is considered intent to pay for the items “you” have selected in your cart and have processed for payment.';

}

class AlertPrivacyDialog{
  static String alertTitle='Privacy Policy';
  static String alertTitle1='Introduction';
  static String alertTitle1Content='Welcome to Velvet Cream. We are committed to protecting your privacy. This policy outlines how we collect, use, and protect your information.';
static String alertTitle2="Information";
static String alertTitle2ContentPart1="Location Data : We collect real-time location data from your mobile device to optimize order preparation and delivery.";
static String alertTitle2ContentPart2="We collect real-time location data from your mobile device to optimize order preparation and delivery.";
static String alertTitle3='Use of Location Data';
static String alertTitle3Content='We use your location data to monitor your proximity to the delivery location and to time the preparation of your order.';
  static String alertTitle4='Data Sharing and Disclosure';
  static String alertTitle4Content='We do not share, sell, or rent your location data to any third parties. It is used solely to enhance service efficiency.';
  static String alertTitle5='Your Rights';
  static String alertTitle5Content='You can access, update, or delete your location data through your device settings or the App settings.';
  static String alertTitle6='Children’s Privacy';
  static String alertTitle6Content='Velvet Cream does not knowingly collect personally identifiable information from children under the age of thirteen. If you are under the age of thirteen, you must ask your parent or guardian for permission to use this App';
  static String alertTitle7='Contact Us';
  static String alertTitle7Content='If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at: velvetcream@gmail.com';
  static String alertTitle8='Location Data Usage';
  static String alertTitle8Content='We use background location access during active food orders to notify the shop for preparation and ensure timely delivery. The purpose is to manage orders and deliveries efficiently. Location tracking stops immediately after delivery, and no location data is stored post-delivery. Your location data is not shared with any unauthorized parties.';

}


itemPriceId(int? defalutSize, List<Price>? values){
  String? productPriceValues;
  for (var element in values!) {
    if(element.itemsizeId == defalutSize){
      productPriceValues= element.price;
    }
  }
  return productPriceValues;
}


itemPointsId(int? defalutSize, List<Price>? values){
  String? productPriceValues;
  for (var element in values!) {
    if(element.itemsizeId == defalutSize){
      productPriceValues= element.points;
    }
  }

  return productPriceValues;
}

selectItemsDifferentForms(String?  values) {
  List<String> differentFormsItemsID = ['424'];
  return differentFormsItemsID.contains(values);
}
// List<PopularCategoriesModel> popularCategoriesList = [
//   PopularCategoriesModel(
//       body:
//       'Piled high with two large chicken strips. served with mayonnaise,lettuce and tomato'.tr,
//       title: 'Fried Chicken Sandwitch'.tr,
//       image: 'http://www.pngimagesfree.com/Food/Indian-Fast-Food/Samosa-Png_indian-image.png'),
//
// ];
