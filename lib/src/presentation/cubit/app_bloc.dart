import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:heidi/src/presentation/cubit/user/user_cubit.dart';
import 'package:heidi/src/presentation/main/account/account_profile/cubit/account_cubit.dart';
import 'package:heidi/src/presentation/main/account/change_password/cubit/change_password_cubit.dart';
import 'package:heidi/src/presentation/main/account/contact_us/cubit/contact_us_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_requests/cubit/all_requests_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/customer/customer_card/cubit/customer_card_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/customer/customer_page/cubit/customer_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_orders_screen/cubit/owner_orders_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_screen/cubit/owner_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_products_screen/cubit/owner_products_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_seller_screen/cubit/owner_seller_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_shelves_screen/cubit/owner_shelves_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/create_product/cubit/create_product_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_page/cubit/seller_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_request/cubit/seller_request_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_requests_view/cubit/seller_requests_view_cubit.dart';
import 'package:heidi/src/presentation/main/account/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:heidi/src/presentation/main/add_listing/cubit/add_listing_cubit.dart';
import 'package:heidi/src/presentation/main/discovery/cubit/discovery_cubit.dart';
import 'package:heidi/src/presentation/main/home/home_screen/cubit/home_cubit.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/cubit.dart';
import 'package:heidi/src/presentation/main/home/product_detail/cubit/cubit.dart';
import 'package:heidi/src/presentation/main/login/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:heidi/src/presentation/main/login/signin/cubit/login_cubit.dart';
import 'package:heidi/src/presentation/main/login/signup/cubit/signup_cubit.dart';
import 'package:heidi/src/presentation/main/wishlist/cubit/cubit.dart';

import 'bloc.dart';

class AppBloc {
  static final applicationCubit = ApplicationCubit();
  static final userCubit = UserCubit();
  static final languageCubit = LanguageCubit();
  static final themeCubit = ThemeCubit();
  static final authenticateCubit = AuthenticationCubit();
  static final accountCubit = AccountCubit();
  static final loginCubit = LoginCubit();
  static final signupCubit = SignUpCubit();
  static final editProfileCubit = EditProfileCubit();
  static final forgotPasswordCubit = ForgotPasswordCubit();
  static final changePasswordCubit = ChangePasswordCubit();
  static final homeCubit = HomeCubit();
  static final discoveryCubit = DiscoveryCubit();

  //static final listCubit = ListCubit();
  static final wishListCubit = WishListCubit();

  // static final reviewCubit = ReviewCubit();
  // static final messageCubit = MessageCubit();
  // static final submitCubit = SubmitCubit();
  // static final searchCubit = SearchCubit();
  static final productDetailCubit = ProductDetailCubit();
  static final contactUsCubit = ContactUsCubit();
  static final allListingsCubit = AllListingsCubit();
  static final allRequestsCubit = AllRequestsCubit();
  static final sellerRequestCubit = SellerRequestCubit();
  static final sellerCubit = SellerCubit();
  static final customerCubit = CustomerCubit();
  static final createProductCubit = CreateProductCubit();
  static final ownerCubit = OwnerCubit();
  static final customerCardCubit = CustomerCardCubit();
  static final sellerRequestsViewCubit = SellerRequestsViewCubit();
  static final ownerOrdersCubit = OwnerOrdersCubit();
  static final ownerShelvesCubit = OwnerShelvesCubit();
  static final ownerProductsCubit = OwnerProductsCubit();
  static final ownerSellerCubit = OwnerSellerCubit();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationCubit>(
      create: (context) => applicationCubit,
    ),
    BlocProvider<UserCubit>(
      create: (context) => userCubit,
    ),
    BlocProvider<ProductDetailCubit>(
      create: (context) => productDetailCubit,
    ),
    BlocProvider<LanguageCubit>(
      create: (context) => languageCubit,
    ),
    BlocProvider<ThemeCubit>(
      create: (context) => themeCubit,
    ),
    BlocProvider<AuthenticationCubit>(
      create: (context) => authenticateCubit,
    ),
    BlocProvider<AccountCubit>(
      create: (context) => accountCubit,
    ),
    BlocProvider<LoginCubit>(
      create: (context) => loginCubit,
    ),
    BlocProvider<SignUpCubit>(
      create: (context) => signupCubit,
    ),
    BlocProvider<ForgotPasswordCubit>(
      create: (context) => forgotPasswordCubit,
    ),
    BlocProvider<EditProfileCubit>(
      create: (context) => editProfileCubit,
    ),
    // BlocProvider<ProfileCubit>(
    //   create: (context) => profileCubit,
    // ),
    BlocProvider<ChangePasswordCubit>(
      create: (context) => changePasswordCubit,
    ),
    BlocProvider<HomeCubit>(
      create: (context) => homeCubit,
    ),
    BlocProvider<ListCubit>(
      create: (context) => ListCubit(context.read()),
    ),
    // BlocProvider<HomeCubit>(
    //   create: (context) => homeCubit,
    // ),
    BlocProvider<WishListCubit>(
      create: (context) => wishListCubit,
    ),
    BlocProvider<DiscoveryCubit>(
      create: (context) => discoveryCubit,
    ),
    // BlocProvider<ReviewCubit>(
    //   create: (context) => reviewCubit,
    // ),
    // BlocProvider<MessageCubit>(
    //   create: (context) => messageCubit,
    // ),
    BlocProvider<AddListingCubit>(
      create: (context) => AddListingCubit(context.read()),
    ),
    BlocProvider<ContactUsCubit>(
      create: (context) => contactUsCubit,
    ),
    BlocProvider<SellerRequestCubit>(
      create: (context) => sellerRequestCubit,
    ),
    BlocProvider<SellerCubit>(
      create: (context) => sellerCubit,
    ),
    BlocProvider<CustomerCubit>(
      create: (context) => customerCubit,
    ),
    BlocProvider<CreateProductCubit>(
      create: (context) => createProductCubit,
    ),
    BlocProvider<OwnerCubit>(
      create: (context) => ownerCubit,
    ),
    BlocProvider<CustomerCardCubit>(
      create: (context) => customerCardCubit,
    ),
    BlocProvider<SellerRequestsViewCubit>(
      create: (context) => sellerRequestsViewCubit,
    ),
    BlocProvider<OwnerOrdersCubit>(
      create: (context) => ownerOrdersCubit,
    ),
    BlocProvider<OwnerProductsCubit>(
      create: (context) => ownerProductsCubit,
    ),
    BlocProvider<OwnerShelvesCubit>(
      create: (context) => ownerShelvesCubit,
    ),
    BlocProvider<OwnerSellerCubit>(
      create: (context) => ownerSellerCubit,
    ),
    // BlocProvider<SearchCubit>(
    //   create: (context) => searchCubit,
    // ),
  ];

  static void dispose() {
    // applicationCubit.close();
    // userCubit.close();
    languageCubit.close();
    themeCubit.close();
    // homeCubit.close();
    // wishListCubit.close();
    // authenticateCubit.close();
    // accountCubit.close();
    // loginCubit.close();
    // reviewCubit.close();
    // messageCubit.close();
    // submitCubit.close();
    // searchCubit.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
