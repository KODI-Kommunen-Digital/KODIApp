import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/events/cubit/events_cubit.dart';
import 'package:heidi/src/presentation/main/events/cubit/events_state.dart';
import 'package:heidi/src/presentation/main/events/events_search.dart';
import 'package:heidi/src/presentation/main/home/widget/home_sliver_app_bar.dart';
import 'package:heidi/src/presentation/widget/app_product_item.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class EventsScreen extends StatefulWidget {
  final dynamic arguments;

  const EventsScreen({super.key, this.arguments});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final _scrollController = ScrollController();
  bool isLoading = false;
  bool isSearching = false;
  int pageNo = 1;
  MultiFilter? selectedFilter;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    context.read<EventsCubit>().onLoad(false, pageNo);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoading = true;
        });
        await context.read<EventsCubit>().newEvents(++pageNo);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _onRefresh() async {
    await AppBloc.eventsCubit.onLoad(true, pageNo);
    setState(() {
      pageNo = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) => state.maybeWhen(
          loading: () => _buildLoading(),
          loaded: (events) {
            pageNo = 1;
            return _buildLoaded(events);
          },
          updated: (events) => _buildLoaded(events),
          orElse: () => ErrorWidget(Translate.of(context).translate('error')),
        ),
      ),
    );
  }

  Widget _buildLoaded(List<ProductModel> events) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      controller: _scrollController,
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: AppBarHomeSliver(
              expandedHeight: MediaQuery.of(context).size.height * 0.25,
              onSearch: null,
              isHome: false),
          pinned: false,
        ),
        SliverToBoxAdapter(
          child: Transform.translate(
            offset: const Offset(0, -45),
            child: Material(
              color: Colors.transparent,
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: EventsSearchWidget(
                      onSearch: (searchTerm) {
                        context.read<EventsCubit>().searchListing(searchTerm, pageNo);
                      },
                      searchTerm: context.read<EventsCubit>().searchTerm,
                      onDelete: () {
                        if (context.read<EventsCubit>().searchTerm != null) {
                          context.read<EventsCubit>().onLoad(false, pageNo);
                        }
                      },
                      onFilter: (multiFilter) {
                        if (multiFilter != null) {
                          context.read<EventsCubit>().onFilter(multiFilter, pageNo);
                          selectedFilter = multiFilter;
                        }
                      },
                      filter: context.read<EventsCubit>().filter!)),
            ),
          ),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: _onRefresh,
        ),
        _buildContent(events, )
      ],
    );
  }

  Widget _buildLoading() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      controller: _scrollController,
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: AppBarHomeSliver(
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            onSearch: null,
            isHome: false,
          ),
          pinned: false,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(List<ProductModel> events) {
    if (events.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.sentiment_satisfied),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  (selectedFilter != null &&
                      (selectedFilter!.hasMultipleCityFilter && selectedFilter!.selectedCities![0]!=0))
                      ? Translate.of(context)
                          .translate('no_posts_in_the_selected_district')
                      : Translate.of(context).translate('currently_no_events_available'),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index < events.length) {
            final item = events[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _buildItem(events[index]),
            );
          } else {
            (isLoading)
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Container();
          }
          return null;
        },
        childCount: events.length + 1,
      ),
    );
  }

  Widget _buildItem(ProductModel? item) {
    if (item != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AppProductItem(
          isRefreshLoader: true,
          cityName: context.read<EventsCubit>().locations[item.cityId],
          onPressed: () {
            Navigator.pushNamed(context, Routes.productDetail, arguments: item);
          },
          item: item,
          type: ProductViewType.list,
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const AppProductItem(
        isRefreshLoader: true,
        type: ProductViewType.list,
      ),
    );
  }
}
