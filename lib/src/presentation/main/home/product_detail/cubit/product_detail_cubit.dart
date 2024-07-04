import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_favorite.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/home/product_detail/cubit/cubit.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(const ProductDetailLoading());
  ProductModel? product;
  List<FavoriteModel> favoritesList = [];
  bool isFavorite = false;
  UserModel? userDetail;

  void onLoad(ProductModel item) async {
    final int userId = await UserRepository.getLoggedUserId();
    bool isLoggedIn = userId != 0;
    bool darkModeEnabled = await isDarkMode();

    if (item.cityId != null) {
      final result = await ListRepository.loadProduct(item.cityId, item.id);

      if (result != null) {
        product = result;
        userDetail = await getUserDetails(item.userId, item.cityId);
        if (userId != 0) {
          try {
            favoritesList = await UserRepository.loadFavorites(userId);
            if (product != null) {
              for (final fList in favoritesList) {
                if (fList.listingsId == product?.id) {
                  product?.favorite = true;
                  isFavorite = product!.favorite;
                }
              }
            }
            emit(ProductDetailLoaded(product!, favoritesList, userDetail,
                isLoggedIn, darkModeEnabled));
          } catch (e, stackTrace) {
            emit(ProductDetailLoaded(
                product!, null, userDetail, isLoggedIn, darkModeEnabled));
            await Sentry.captureException(e, stackTrace: stackTrace);
          }
        } else {
          emit(ProductDetailLoaded(
              product!, null, userDetail, isLoggedIn, darkModeEnabled));
        }
      }
    } else {
      isFavorite = true;
      emit(ProductDetailLoaded(
          item, null, userDetail, isLoggedIn, darkModeEnabled));
    }
  }

  Future<bool> isDarkMode() async {
    final prefBox = await Preferences.openBox();
    String darkMode = await prefBox.getKeyValue(Preferences.darkOption, 'on');
    return (darkMode == 'on');
  }

  bool getFavoriteIconValue() => isFavorite;

  void setFavoriteIconValue() {
    isFavorite = !isFavorite;
  }

  Map<int, int> parseMap(Map<dynamic, dynamic> originalMap) {
    final resultMap = <int, int>{};
    for (final key in originalMap.keys) {
      if (key is int && originalMap[key] is int) {
        resultMap[key] = originalMap[key] as int;
      } else {
        logError("Couldn't fetch votes");
      }
    }
    return resultMap;
  }

  Future<int> getLoggedInUserId() async {
    return await UserRepository.getLoggedUserId();
  }

  Future<UserModel?> getUserDetails(userId, cityId) async {
    UserModel? userDetailResponse =
        await UserRepository.getUserDetails(userId, cityId);
    return userDetailResponse;
  }

  Future<void> onAddFavorite(ProductModel product) async {
    final prefs = await Preferences.openBox();
    final int? userId = prefs.getKeyValue(Preferences.userId, '');
    await ListRepository.addWishList(userId, product);
    await AppBloc.wishListCubit.onLoad();
  }

  Future<void> onDeleteFavorite(ProductModel? product) async {
    final prefs = await Preferences.openBox();
    final int? userId = prefs.getKeyValue(Preferences.userId, '');

    if (product != null) {
      final favoritesList = await UserRepository.loadFavorites(userId);

      for (final fList in favoritesList) {
        if (fList.listingsId == product.id) {
          await ListRepository.removeWishList(userId, fList.favoriteId);
        }
      }
      await AppBloc.wishListCubit.onLoad();
    }
  }

  Future<ResultApiModel> saveVote(
      int cityId, int listingId, int optionId) async {
    final prefs = await Preferences.openBox();
    final Map<dynamic, dynamic> votes = prefs.getKeyValue('pollVotes', {});
    final int? previousOptionId = votes[listingId];

    // Remove previous vote if there was one
    if (previousOptionId != null && previousOptionId != optionId) {
      final removeVoteParams = {
        'optionId': previousOptionId,
        'vote': -1,
      };
      await ListRepository.saveVote(cityId, removeVoteParams, listingId);
    }

    dynamic addVoteParams;

    if (previousOptionId != null && previousOptionId == optionId) {
      addVoteParams = {
        'optionId': optionId,
        'vote': -1,
      };
    } else {
      // Add new vote
      addVoteParams = {
        'optionId': optionId,
        'vote': 1,
      };
    }

    final response =
        await ListRepository.saveVote(cityId, addVoteParams, listingId);

    if (response.success) {
      if (previousOptionId != null && previousOptionId == optionId) {
        votes.removeWhere((key, value) => key == listingId);
      } else {
        votes[listingId] = optionId;
      }
      await prefs.setKeyValue('pollVotes', votes);
    }

    return response;
  }
}
