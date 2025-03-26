// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/data/model/model_group_posts.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/main_screen.dart';
import 'package:heidi/src/presentation/main/account/change_password/change_password_screen.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/all_listings_screen.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_requests/all_requests_screen.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_requests/cubit/all_requests_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/dashboard_screen.dart';
import 'package:heidi/src/presentation/main/account/dashboard/my_groups/cubit/my_groups_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/my_groups/my_groups_screen.dart';
import 'package:heidi/src/presentation/main/account/dashboard/my_listings/my_listings_screen.dart';
import 'package:heidi/src/presentation/main/account/edit_profile/edit_profile_screen.dart';
import 'package:heidi/src/presentation/main/account/faq/cubit/faq_cubit.dart';
import 'package:heidi/src/presentation/main/account/faq/faq_screen.dart';
import 'package:heidi/src/presentation/main/account/legal/legal.dart';
import 'package:heidi/src/presentation/main/account/legal/rsag_screen.dart';
import 'package:heidi/src/presentation/main/account/profile/cubit/profile_cubit.dart';
import 'package:heidi/src/presentation/main/account/profile/profile_screen.dart';
import 'package:heidi/src/presentation/main/account/profile_settings/profile_settings_screen.dart';
import 'package:heidi/src/presentation/main/account/setting/settings_screen.dart';
import 'package:heidi/src/presentation/main/add_listing/add_listing_screen.dart';
import 'package:heidi/src/presentation/main/add_listing/add_listing_success/add_listing_success.dart';
import 'package:heidi/src/presentation/main/discovery/discovery_screen_detail.dart';
import 'package:heidi/src/presentation/main/home/filter_screen.dart';
import 'package:heidi/src/presentation/main/home/forum/add_group_screen/add_group_screen.dart';
import 'package:heidi/src/presentation/main/home/forum/add_group_screen/cubit/add_group_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/add_new_post/add_post_screen.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/add_new_post/cubit/add_post_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/cubit/cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/forum_image_zoom/forum_image_zoom_screen.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/cubit/group_details_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/group_details_screen.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/group_members/cubit/group_members_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/group_members/group_members_screen.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/member_requests/cubit/member_request_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/member_requests/member_request_screen.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/post_detail/cubit/post_detail_cubit.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/group_details/post_detail/post_detail_screen.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/list_groups_screen.dart';
import 'package:heidi/src/presentation/main/home/list_product/list_product.dart';
import 'package:heidi/src/presentation/main/home/product_detail/booking/booking_screen.dart';
import 'package:heidi/src/presentation/main/home/product_detail/booking/cubit/booking_cubit.dart';
import 'package:heidi/src/presentation/main/home/product_detail/image_zoom/image_zoom_screen.dart';
import 'package:heidi/src/presentation/main/home/product_detail/product_detail_screen.dart';
import 'package:heidi/src/presentation/main/login/forgot_password/forgot_password_screen.dart';
import 'package:heidi/src/presentation/main/login/signin/signin_screen.dart';
import 'package:heidi/src/presentation/main/login/signup/signup.dart';
import 'package:heidi/src/presentation/main/account/contact_us/contact_us_screen.dart';
import 'package:heidi/src/presentation/main/account/contact_us/contact_us_success/contact_us_success.dart';
import 'package:heidi/src/presentation/main/trolley_maker/cards/trolley_maker_cards_screen.dart';
import 'package:heidi/src/presentation/main/trolley_maker/my_credit/trolley_maker_my_credit_screen.dart';
import 'package:heidi/src/presentation/main/trolley_maker/partner/trolley_maker_partner_screen.dart';
import 'package:heidi/src/presentation/main/trolley_maker/partner_details/trolley_maker_partner_details_screen_screen.dart';
import 'package:heidi/src/presentation/main/trolley_maker/register/trolley_maker_register_screen.dart';
import 'package:heidi/src/presentation/main/trolley_maker/sign_in/trolley_maker_sign_in_screen.dart';
import 'package:heidi/src/presentation/main/trolley_maker/trolley_news/trolley_news_screen.dart';
import 'package:heidi/src/presentation/main/waste_calendar/waste_main/waste_calendar_screen.dart';
import 'package:matomo_tracker/matomo_tracker.dart';

class RouteArguments<T> {
  final T? item;
  final VoidCallback? callback;

  RouteArguments({this.item, this.callback});
}

class Routes {
  static const String home = "/home";
  static const String main = "/home";
  static const String discovery = "/discovery";
  static const String discoveryDetail = "/discoveryDetail";
  static const String wishList = "/wishList";
  static const String account = "/account";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String forgotPassword = "/forgotPassword";
  static const String productDetail = "/productDetail";
  static const String searchHistory = "/searchHistory";
  static const String category = "/category";
  static const String profile = "/profile";
  static const String submit = "/submit";
  static const String editProfile = "/editProfile";
  static const String changePassword = "/changePassword";
  static const String createAppointment = "/createAppointment";
  static const String selectHolidays = "/selectHolidays";
  static const String changeLanguage = "/changeLanguage";
  static const String contactUs = "/contactUs";
  static const String aboutUs = "/aboutUs";
  static const String gallery = "/gallery";
  static const String themeSetting = "/themeSetting";
  static const String listProduct = "/listProduct";
  static const String filterScreen = "/filterScreen";
  static const String review = "/review";
  static const String writeReview = "/writeReview";
  static const String setting = "/setting";
  static const String fontSetting = "/fontSetting";
  static const String picker = "/picker";
  static const String galleryUpload = "/galleryUpload";
  static const String categoryPicker = "/categoryPicker";
  static const String gpsPicker = "/gpsPicker";
  static const String submitSuccess = "/submitSuccess";
  static const String contactUsSuccess = "/contactUsSuccess";
  static const String openTime = "/openTime";
  static const String socialNetwork = "/socialNetwork";
  static const String tagsPicker = "/tagsPicker";
  static const String webView = "/webView";
  static const String booking = "/booking";
  static const String bookingManagement = "/bookingManagement";
  static const String bookingDetail = "/bookingDetail";
  static const String scanQR = "/scanQR";
  static const String deepLink = "/deepLink";
  static const String legal = "/legal";
  static const String imprint = "/imprint";
  static const String privacy = "/privacy";
  static const String imageZoom = "/imageZoom";
  static const String forumImageZoom = "/forumImageZoom";
  static const String profileSettings = "/profileSettings";
  static const String faq = "/faq";
  static const String allListings = "/allListings";
  static const String allRequests = "/allRequests";
  static const String listGroups = "/listGroups";
  static const String myGroups = "/myGroups";
  static const String groupDetails = "/groupDetails";
  static const String groupMembersDetails = "/groupMembersDetails";
  static const String memberRequestDetails = "/memberRequestDetails";
  static const String postDetails = "/postDetails";
  static const String dashboard = "/dashboard";
  static const String addGroups = "/addGroup";
  static const String addPosts = "/addPosts";
  static const String myListings = "/myListings";
  static const String mitredenWebview = "/mitredenWebview";
  static const String appointments = "/appointments";
  static const String myAppointments = "/myAppointments";
  static const String appointmentDetails = "/appointmentDetails";
  static const String appointmentRequests = "/appointmentRequests";
  static const String wasteCalendar = "/wasteCalendar";
  static const String rsag = "/rsag";
  static const String trolleyMakerSignIn = "/trolleyMaker";
  static const String trolleyMakerCards = "/trolleyMakerCards";
  static const String trolleyMakerMyCredit = "/trolleyMakerMyCredit";
  static const String trolleyMakerPartner = "/trolleyMakerPartner";
  static const String trolleyMakerSignUp = '/trolleyMakerSignUp';
  static const String trolleyNewsScreen = '/trolleyNewsScreen';
  static const String trolleyMakerPartnerDetails =
      "/trolleyMakerPartnerDetails";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(
            builder: (context) {
              return MainScreen();
            },
            settings: settings);
      case listProduct:
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        if (arguments['type'] == "category" ||
            arguments['type'] == "categoryService") {
          trackMatomoEvent(
              true, null, arguments['categoryId'] ?? arguments['id'], null);
        }
        return MaterialPageRoute(
          builder: (context) {
            return ListProductScreen(arguments: arguments);
          },
        );
      // case test:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return TestScreen();
      //     },
      //   );
      case productDetail:
        return MaterialPageRoute(
          builder: (context) {
            ProductModel product = settings.arguments as ProductModel;
            if ((product.city?.id != null || product.cityId != null) &&
                product.userId != 0) {
              trackMatomoEvent(false, product.title, product.id,
                  product.cityId ?? product.city?.id);
            }
            return ProductDetailScreen(
              item: product,
              isRealProduct: product.userId != 0,
            );
          },
        );

      case signIn:
        return MaterialPageRoute(
          builder: (context) {
            return const SignInScreen();
          },
          fullscreenDialog: true,
        );

      case signUp:
        return MaterialPageRoute(
          builder: (context) {
            return const SignUpScreen();
          },
        );

      case forgotPassword:
        return MaterialPageRoute(
            builder: (context) {
              return const ForgotPasswordScreen();
            },
            settings: settings);

      case editProfile:
        return MaterialPageRoute(
          builder: (context) {
            return const EditProfileScreen();
          },
        );
      case allListings:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => AllListingsCubit(),
              child: AllListingsScreen(user: arguments["user"] as UserModel),
            );
          },
        );

      case allRequests:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => AllRequestsCubit(),
              child: AllRequestsScreen(user: arguments["user"] as UserModel),
            );
          },
        );

      case profile:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => ProfileCubit(
                context.read(),
                arguments['user'] as UserModel,
              ),
              child: ProfileScreen(
                user: arguments['user'] as UserModel,
                isEditable: arguments['editable'] as bool,
              ),
            );
          },
        );

      case setting:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return SettingsScreen(
              user: arguments['user'] as UserModel?,
            );
          },
        );

      case submit:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return AddListingScreen(
              item: arguments['item'] as ProductModel?,
              isNewList: arguments['isNewList'] as bool,
            );
          },
          fullscreenDialog: true,
        );

      case imageZoom:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return ImageZoomScreen(
              sourceId: arguments['sourceId'] as int,
              imageList: arguments['imageList']! as List<ImageListModel>?,
              pdf: arguments['pdf'] ?? '',
            );
          },
          fullscreenDialog: true,
        );

      case forumImageZoom:
        return MaterialPageRoute(
          builder: (context) {
            return ForumImageZoomScreen(imageUrl: settings.arguments as String);
          },
          fullscreenDialog: true,
        );

      case booking:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => BookingCubit(
                context.read(),
              ),
              child: BookingScreen(
                listingTitle: settings.arguments as String,
              ),
            );
          },
        );

      case submitSuccess:
        return MaterialPageRoute(
          builder: (context) {
            return const AddListingSuccessScreen();
          },
          fullscreenDialog: true,
        );

      case changePassword:
        return MaterialPageRoute(
          builder: (context) {
            return const ChangePasswordScreen();
          },
        );

      case legal:
        return MaterialPageRoute(
          builder: (context) {
            return const LegalScreen();
          },
        );

      case rsag:
        return MaterialPageRoute(
          builder: (context) {
            return const RsagScreen();
          },
        );

      case profileSettings:
        return MaterialPageRoute(
          builder: (context) {
            return const ProfileSettingsScreen();
          },
        );
      case contactUs:
        return MaterialPageRoute(
          builder: (context) {
            return const ContactUsScreen();
          },
        );

      case dashboard:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => ProfileCubit(
                context.read(),
                arguments['user'] as UserModel,
              ),
              child: DashboardScreen(
                isEditable: arguments['editable'] as bool,
              ),
            );
          },
        );

      case myListings:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => ProfileCubit(
                context.read(),
                arguments['user'] as UserModel,
              ),
              child: MyListingsScreen(
                user: arguments['user'] as UserModel,
                isEditable: arguments['editable'] as bool,
              ),
            );
          },
        );

      case contactUsSuccess:
        return MaterialPageRoute(
          builder: (context) {
            return const ContactUsSuccessScreen();
          },
          fullscreenDialog: true,
        );

      case faq:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => FaqCubit(),
              child: const FaqScreen(),
            );
          },
        );

      case myGroups:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => MyGroupsCubit(
                context.read(),
              ),
              child: const MyGroupsScreen(),
            );
          },
          fullscreenDialog: true,
        );

      case listGroups:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => ListGroupsCubit(
                context.read(),
              ),
              child: ListGroupScreen(arguments: arguments),
            );
          },
          fullscreenDialog: true,
        );

      case groupDetails:
        return MaterialPageRoute(
          builder: (context) {
            final ForumGroupModel arguments =
                settings.arguments as ForumGroupModel;
            return BlocProvider(
              create: (context) => GroupDetailsCubit(context.read(), arguments),
              child: const GroupDetailsScreen(),
            );
          },
          fullscreenDialog: true,
        );

      case groupMembersDetails:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            final int groupId = arguments['groupId'] as int;
            final int cityId = arguments['cityId'] as int;

            return BlocProvider(
              create: (context) =>
                  GroupMembersCubit(context.read(), groupId, cityId),
              child: GroupMembersScreen(groupId),
            );
          },
          fullscreenDialog: true,
        );

      case memberRequestDetails:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => MembersRequestsCubit(
                  context.read(), arguments['groupId'], arguments['cityId']),
              child: MemberRequestScreen(arguments['groupId']),
            );
          },
          fullscreenDialog: true,
        );

      case postDetails:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            final GroupPostsModel item = arguments['item'];
            final int cityId = arguments['cityId'] as int;
            final int userId = arguments['userId'] as int;
            final bool isAdmin = arguments['isAdmin'] as bool;

            return BlocProvider(
              create: (context) => PostDetailCubit(
                  context.read(), item, cityId, userId, isAdmin),
              child: PostDetailsScreen(item),
            );
          },
          fullscreenDialog: true,
        );

      case addGroups:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => AddGroupCubit(
                context.read(),
              ),
              child: AddGroupScreen(
                item: arguments['forumDetails'] as ForumGroupModel?,
                isNewGroup: arguments['isNewGroup'] as bool,
              ),
            );
          },
          fullscreenDialog: true,
        );

      case addPosts:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => AddPostCubit(
                context.read(),
              ),
              child: AddPostScreen(
                item: arguments['item'],
                isNewPost: arguments['isNewPost'] as bool,
              ),
            );
          },
          fullscreenDialog: true,
        );

      case filterScreen:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return FilterScreen(multiFilter: arguments["multifilter"]);
          },
        );

      case Routes.wasteCalendar:
        return MaterialPageRoute(
          builder: (context) {
            return WasteCalendar();
          },
        );

      case discoveryDetail:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return DiscoveryScreenDetail(arguments: arguments);
          },
        );

      case trolleyMakerSignIn:
        return MaterialPageRoute(
          builder: (context) {
            return TrolleyMakerSigninScreen();
          },
        );

      case trolleyMakerCards:
        return MaterialPageRoute(
          builder: (context) {
            return TrolleyMakerCardsScreen();
          },
        );
      case trolleyMakerMyCredit:
        return MaterialPageRoute(
          builder: (context) {
            return TrolleyMakerMyCreditScreen();
          },
        );

      case trolleyMakerPartner:
        return MaterialPageRoute(
          builder: (context) {
            return TrolleyMakerPartnersScreen();
          },
        );
      case trolleyMakerSignUp:
        return MaterialPageRoute(
          builder: (context) {
            return TrolleyMakerRegisterScreen();
          },
        );

      case trolleyMakerPartnerDetails:
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        var gguid = arguments["gguid"];
        var companyName = arguments["company_name"];
        return MaterialPageRoute(
          builder: (context) {
            return TrolleyMakerPartnerDetailsScreen(gguid, companyName);
          },
        );

      case trolleyNewsScreen:
        return MaterialPageRoute(
          builder: (context) {
            return TrolleyNewsScreen();
          },
        );

      default:
        const SignInScreen();

        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          },
          fullscreenDialog: true,
        );
    }
  }

  static void trackMatomoEvent(
      bool isCategory, String? name, int id, int? cityId) {
    late String eventName;
    late String type;
    if (isCategory) {
      name = _getCategoryName(id);
      eventName = "category_${name}_${id.toString()}";
      type = 'category';
    } else if (isCategory && name != null) {
      eventName = "${name}_${id.toString()}_${cityId.toString()}";
      type = 'listing';
    } else {
      name = _getServiceName(id);
      eventName = "service_${name}_${id.toString()}";
      type = 'service';
    }
    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(
        category: type,
        name: eventName,
        action: 'click',
        value: 1,
      ),
    );
  }

  static String _getCategoryName(int id) {
    Map<int, String> categories = {
      1: "News",
      3: "Events",
      5: "Mobilität",
      6: "Online-Dienste",
      7: "Stadtwerke",
      8: "Freizeitkarte",
    };
    return categories[id] ?? '';
  }

  static String _getServiceName(int id) {
    Map<int, String> categories = {
      3: "Terminbuchung_Bürgerbüro",
      5: "Bürger:innenbeteiligung",
      62: "Parken",
      7: "Chatbot",
      8: "Mängelmelder",
      10: "Abfallkalender",
      11: "Neubürger:innen",
      12: "Aggua",
      14: "Jeti-Line-Glasfaser",
      15: "Virtuelles_Beratungsbüro"
    };
    return categories[id] ?? '';
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
