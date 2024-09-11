
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mantled_app/model/NBModel.dart';

import 'NBImages.dart';

String details = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
    'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,'
    ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. '
    'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '
    'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing '
    'software like Aldus PageMaker including versions of Lorem Ipsum.\n\n'
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
    'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,'
    ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. '
    'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '
    'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing '
    'software like Aldus PageMaker including versions of Lorem Ipsum.\n\n'
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
    'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,'
    ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. '
    'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '
    'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing '
    'software like Aldus PageMaker including versions of Lorem Ipsum.';

List<NBBannerItemModel> nbGetBannerItems() {
  List<NBBannerItemModel> bannerList = [];
  bannerList.add(NBBannerItemModel(image: NBNewsImage1));
  bannerList.add(NBBannerItemModel(image: NBNewsImage2));
  bannerList.add(NBBannerItemModel(image: NBNewsImage3));
  return bannerList;
}

// List<NBDrawerItemModel> nbGetDrawerItems() {
//   List<NBDrawerItemModel> drawerItems = [];
//   drawerItems.add(NBDrawerItemModel(title: 'Home'));
//   drawerItems.add(NBDrawerItemModel(title: 'Audio', widget: NBAudioArticleScreen()));
//   drawerItems.add(NBDrawerItemModel(title: 'Create New Article', widget: NBCreateNewArticleScreen()));
//   drawerItems.add(NBDrawerItemModel(title: 'Bookmark', widget: NBBookmarkScreen()));
//   drawerItems.add(NBDrawerItemModel(title: 'Membership', widget: const NBMembershipScreen()));
//   drawerItems.add(NBDrawerItemModel(title: 'Setting', widget: const NBSettingScreen()));
//   return drawerItems;
// }

List<NBNewsDetailsModel> nbGetNewsDetails() {
  List<NBNewsDetailsModel> newsDetailsList = [];
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Sports',
    title: 'Wayne Enterprises',
    date: '20 jan 2021',
    image: NBSportSNews1,
    details: details,
    time: '40:18',
    isBookmark: true,
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Technology',
    title: 'Stark Industries',
    date: '20 jan 2021',
    image: NBTechNews1,
    details: details,
    time: '1:40:18',
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Fashion',
    title: 'Bluth Company',
    date: '20 jan 2021',
    image: NBFashion,
    details: details,
    time: '40:00',
    isBookmark: true,
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Science',
    title: 'Wayne Enterprises',
    date: '20 jan 2021',
    image: NBCompany,
    details: details,
    time: '15:00',
    isBookmark: true,
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Sports',
    title: 'Sterling Cooper',
    date: '20 Nov 2020',
    image: NBSportSNews1,
    details: details,
    time: '1:9:30',
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Technology',
    title: 'Bluth Company',
    date: '20 Nov 2020',
    image: NBTechNews1,
    details: details,
    time: '1:9:30',
    isBookmark: true,
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Fashion',
    title: 'Stark Industries',
    date: '20 Nov 2020',
    image: NBFashion,
    details: details,
    time: '40:00',
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Science',
    title: 'Sterling Cooper',
    date: '20 Nov 2020',
    image: NBCompany,
    details: details,
    time: '20:00',
  ));
  return newsDetailsList;
}
//
// List<NBSettingsItemModel> nbGetSettingItems() {
//   List<NBSettingsItemModel> settingList = [];
//   settingList.add(NBSettingsItemModel(title: 'Security Settings', widget: const NBChangePasswordScreen()));
//   settingList.add(NBSettingsItemModel(title: 'Next of Kin', widget: const HLNextOfKinScreen()));
//   settingList.add(NBSettingsItemModel(title: 'Asset Report', widget: const HLAssetReportScreen()));
//   settingList.add(NBSettingsItemModel(title: 'Support' ,widget: const HLSupportScreen()), );
//  // settingList.add(NBSettingsItemModel(title: 'Billings & Subscription', widget: const HLBillingScreen()));
//   settingList.add(NBSettingsItemModel(title: 'Lawyer Info', widget: const HLLawyerInfoScreen()));
//
//   return settingList;
// }

List<NBLanguageItemModel> nbGetLanguageItems() {
  List<NBLanguageItemModel> languageList = [];
  languageList.add(NBLanguageItemModel(NBChineseFlag, 'Chinese'));
  languageList.add(NBLanguageItemModel(NBEnglishFlag, 'English'));
  languageList.add(NBLanguageItemModel(NBFrenchFlag, 'French'));
  languageList.add(NBLanguageItemModel(NBMelayuFlag, 'Melayu'));
  languageList.add(NBLanguageItemModel(NBSpainFlag, 'Spain'));
  return languageList;
}

List<NBNotificationItemModel> nbGetNotificationItems() {
  List<NBNotificationItemModel> notificationList = [];
  notificationList.add(NBNotificationItemModel('App Notification', true));
  notificationList.add(NBNotificationItemModel('Recommended Article', true));
  notificationList.add(NBNotificationItemModel('Promotion', false));
  notificationList.add(NBNotificationItemModel('Latest News', true));
  return notificationList;
}

List<NBCategoryItemModel> nbGetCategoryItems() {
  List<NBCategoryItemModel> categoryList = [];
  categoryList.add(NBCategoryItemModel(NBTechnologyCategory, 'Technology'));
  categoryList.add(NBCategoryItemModel(NBFashionCategory, 'Fashion'));
  categoryList.add(NBCategoryItemModel(NBSportsCategory, 'Sports'));
  categoryList.add(NBCategoryItemModel(NBScienceCategory, 'Science'));
  return categoryList;
}

List<NBMembershipPlanItemModel> nbGetMembershipPlanItems() {
  List<NBMembershipPlanItemModel> planList = [];
  planList.add(NBMembershipPlanItemModel('Monthly', 'N20,000', 'Billed every month'));
  planList.add(NBMembershipPlanItemModel('Quarterly', 'N40,000', 'Billed every month'));
  planList.add(NBMembershipPlanItemModel('Yearly', 'N60,000', 'Billed every month'));

  return planList;
}

List<AssetTypes> allAssetTypes() {
  List<AssetTypes> assets = [];
  assets.add(AssetTypes('Real Estate', '23%', 'Details of all your Real assets Land, houses, terraces, apartments etc','assets/png/house.png'));
  assets.add(AssetTypes('Tangible Assets', '15%', 'Cars, Jewelry, Artworks and collectibles', 'assets/png/tangible.png'));
  assets.add(AssetTypes('Debts and Liabilities', '20%', 'Real, tangible or debts', 'assets/png/debts.png'));
  assets.add(AssetTypes('Personal Assets', '12%', 'Birth Certificates, School leaving certificates, passport data page...','assets/png/car.png'));
  assets.add(AssetTypes('Financial Assets', '18%', 'Cash, Shares, Cryptocurrency, Pension schemes','assets/png/wallet.png'));
  assets.add(AssetTypes('Others', '12%', 'items not included in categories above' ,'assets/png/others.png'));

  return assets;
}

List<AssetTypes> assetsItems() {
  List<AssetTypes> assets = [];
  assets.add(AssetTypes('Liberty Estate, Abeokuta', '23%', 'Added 5th July 2019','assets/png/file.png'));
  assets.add(AssetTypes('Phat Homes, Lekki', '35%', 'Added 5th July 2019', 'assets/png/file.png'));
  assets.add(AssetTypes('Cumana Beach Home, TX', '45%', 'Added 5th July 2019', 'assets/png/file.png'));
  assets.add(AssetTypes('Matthew Land King, ', '45%', 'Added 5th July 2019', 'assets/png/file.png'));
  return assets;
}

List<AssetTypes> uploadedItems() {
  List<AssetTypes> assets = [];
  assets.add(AssetTypes('Legal Ownership Papers', '23%', 'Added 5th July 2019','assets/png/document.png'));
  assets.add(AssetTypes('C Of O Document', '35%', 'Added 5th July 2019', 'assets/png/document.png'));
  assets.add(AssetTypes('Insurance Papers, TX', '45%', 'Added 5th July 2019', 'assets/png/document.png'));
  assets.add(AssetTypes('Security Documentation, ', '45%', 'Added 5th July 2019', 'assets/png/document.png'));
  return assets;
}

List<NBFollowersItemModel> nbGetFollowers() {
  List<NBFollowersItemModel> followersList = [];
  followersList.add(NBFollowersItemModel(NBProfileImage, 'Jones Hawkins', 13));
  followersList.add(NBFollowersItemModel(NBProfileImage, 'Frederick Rodriquez', 8));
  followersList.add(NBFollowersItemModel(NBProfileImage, 'John Jordan', 37));
  followersList.add(NBFollowersItemModel(NBProfileImage, 'Cameron Williamson', 16));
  followersList.add(NBFollowersItemModel(NBProfileImage, 'Cody Fisher', 13));
  followersList.add(NBFollowersItemModel(NBProfileImage, 'Carla Hamilton', 21));
  followersList.add(NBFollowersItemModel(NBProfileImage, 'Fannie Townsend', 25));
  followersList.add(NBFollowersItemModel(NBProfileImage, 'Viola Lloyd', 13));
  return followersList;
}

List<NBCommentItemModel> nbGetCommentList() {
  List<NBCommentItemModel> commentList = [];
  commentList.add(NBCommentItemModel(
    image: NBProfileImage,
    name: 'Jones Hawkins',
    date: 'Jan 18,2021',
    time: '12:15',
    message: 'This is Very Helpful,Thank You.',
  ));
  commentList.add(NBCommentItemModel(
    image: NBProfileImage,
    name: 'Frederick Rodriquez',
    date: 'Jan 19,2021',
    time: '01:15',
    message: 'This is very Important for me,Thank You.',
  ));
  commentList.add(NBCommentItemModel(
    image: NBProfileImage,
    name: 'John Jordan',
    date: 'Feb 18,2021',
    time: '03:15',
    message: 'This is Very Helpful,Thank You.',
  ));
  commentList.add(NBCommentItemModel(
    image: NBProfileImage,
    name: 'Cameron Williamson',
    date: 'Jan 21,2021',
    time: '12:15',
    message: 'This is very Important for me,Thank You.',
  ));
  commentList.add(NBCommentItemModel(
    image: NBProfileImage,
    name: 'Cody Fisher',
    date: 'Jan 28,2021',
    time: '12:15',
    message: 'This is very helpful,thanks',
  ));
  return commentList;
}
