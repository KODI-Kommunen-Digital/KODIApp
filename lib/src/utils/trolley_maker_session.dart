import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/cards/cubit/trolley_maker_cards_cubit.dart';

class TrolleyMakerSession {
  /// Removes the stored Trolley Maker session (token, card name, card list)
  /// and resets the app-wide cards state. Used for logout and token expiry.
  static Future<void> clear(BuildContext context) async {
    final repository = context.read<TrolleyMakerRepository>();
    final cardsCubit = context.read<TrolleyMakerCardsCubit>();
    await repository.logout();
    cardsCubit.reset();
  }
}
