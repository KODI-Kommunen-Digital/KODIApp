import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_container_card.dart';
import 'package:heidi/src/data/model/model_container_transaction.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'customer_card_state.dart';

class CustomerCardCubit extends Cubit<CustomerCardState> {
  CustomerCardCubit() : super(const CustomerCardState.loading());
  int? selectedCard;

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const CustomerCardState.loading());
    }
    selectedCard = null;

    final UserModel? user = await UserRepository.loadUser();
    if (user != null) {
      final List<ContainerCardModel>? userCards =
          await ContainerRepository.getCustomerCards(user.id);
      emit(CustomerCardState.loaded(userCards ?? [], null));
    } else {
      emit(const CustomerCardState.error());
    }
  }

  Future<void> loadTransactions(int cardId) async {
    emit(const CustomerCardState.loading());
    final UserModel? user = await UserRepository.loadUser();
    if (user != null) {
      final List<ContainerCardModel>? userCards =
          await ContainerRepository.getCustomerCards(user.id);

      final List<ContainerTransactionModel>? userTransactions =
          await ContainerRepository.getCustomerTransactions(user.id, cardId, 1);

      emit(CustomerCardState.loaded(userCards ?? [], userTransactions ?? []));
    } else {
      emit(const CustomerCardState.error());
    }
  }

  Future<List<ContainerTransactionModel>> loadMoreTransactions(
      int cardId, int pageNo) async {
    final UserModel? user = await UserRepository.loadUser();
    List<ContainerTransactionModel>? transactions;
    if (user != null) {
      transactions =
          await ContainerRepository.getCustomerTransactions(
              user.id, cardId, pageNo);
    }
    return transactions ?? [];
  }

/*Future<List<OrderModel>> newOrders(int pageNo) async {
    final UserModel? user = await UserRepository.loadUser();
    if (user != null) {
      final List<OrderModel>? userOrders =
      await ContainerRepository.getCustomerCardOrders(user.id, pageNo);
      return userOrders ?? [];
    }
    return [];
  }*/
}
