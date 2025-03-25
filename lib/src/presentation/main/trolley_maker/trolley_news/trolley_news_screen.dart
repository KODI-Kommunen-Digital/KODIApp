import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/data/model/model_trolley_news.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/trolley_news/cubit/trolley_news_cubit.dart';
import 'package:heidi/src/presentation/main/trolley_maker/trolley_news/cubit/trolley_news_state.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/presentation/widget/app_product_item.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class TrolleyNewsScreen extends StatefulWidget {
  const TrolleyNewsScreen({super.key});

  @override
  State<TrolleyNewsScreen> createState() => _TrolleyNewsScreenState();
}

class _TrolleyNewsScreenState extends State<TrolleyNewsScreen> {
  late TrolleyNewsCubit trolleyNewsCubit;

  @override
  void initState() {
    super.initState();
    trolleyNewsCubit = TrolleyNewsCubit(context.read<TrolleyMakerRepository>());
    trolleyNewsCubit.onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => trolleyNewsCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Translate.of(context).translate('category_news')),
          centerTitle: true,
        ),
        body: BlocBuilder<TrolleyNewsCubit, TrolleyNewsState>(
          builder: (context, state) => state.maybeWhen(
            loading: () => const TrolleyNewsLoading(),
            loaded: (news) => TrolleyNewsLoaded(news: news ?? []),
            error: (msg) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(msg)));
              return Center(
                  child: AppButton(Translate.of(context).translate('retry'),
                      onPressed: () {
                context.read<TrolleyNewsCubit>().onLoad();
              }));
            },
            orElse: () => const TrolleyNewsLoading(),
          ),
        ),
      ),
    );
  }
}

class TrolleyNewsLoaded extends StatefulWidget {
  final List<TrolleyNews> news;

  const TrolleyNewsLoaded({super.key, required this.news});

  @override
  State<TrolleyNewsLoaded> createState() => _TrolleyNewsLoadedState();
}

class _TrolleyNewsLoadedState extends State<TrolleyNewsLoaded> {
  final ScrollController _scrollController = ScrollController();
  OverlayEntry? _loader;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.news.isNotEmpty)
        ? CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final item = widget.news[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 5),
                      child: _buildItem(item),
                    );
                  },
                  childCount: widget.news.length,
                ),
              ),
            ],
          )
        : Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.sentiment_satisfied),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    Translate.of(context).translate('list_is_empty'),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          );
  }

  void showOverlayLoader() {
    _loader = OverlayEntry(
      builder: (_) => const Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );

    Overlay.of(context).insert(_loader!);
  }

  void hideOverlayLoader() {
    _loader?.remove();
    _loader = null;
  }

  void _onItem(TrolleyNews item) async {
    showOverlayLoader();
    final response =
        await context.read<TrolleyNewsCubit>().getTrolleyNewsDetails(item.id);
    hideOverlayLoader();
    response.fold(
        (responseModel) => {
              if (responseModel != null)
                Navigator.pushNamed(context, Routes.productDetail,
                    arguments: ProductModel.fromTrolleyNews(responseModel))
            }, (error) {
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
      }
    });
  }

  Widget _buildItem(TrolleyNews item) {
    final memoryCacheManager = DefaultCacheManager();
    return InkWell(
      onTap: () {
        _onItem(item);
      },
      child: Stack(
        children: [
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: (item.featuredImage != null)
                      ? item.featuredImage!
                      : "${Application.picturesURL}'admin/News.jpeg'",
                  cacheManager: memoryCacheManager,
                  placeholder: (context, url) {
                    return AppPlaceholder(
                      child: Container(
                        width: 120,
                        height: 140,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 120,
                      height: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return CachedNetworkImage(
                      imageUrl: "${Application.picturesURL}admin/News.jpeg",
                      cacheManager: memoryCacheManager,
                      placeholder: (context, url) {
                        return AppPlaceholder(
                          child: Container(
                            width: 120,
                            height: 140,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: 120,
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return AppPlaceholder(
                          child: Container(
                            width: 120,
                            height: 140,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: const Icon(Icons.error),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    HtmlWidget(context
                        .read<TrolleyNewsCubit>()
                        .trimHtml(item.content, maxChars: 85)),
                    /*if (item.link != null) const SizedBox(height: 8),
                    if (item.link != null)
                      Text(
                        'Quelle: ${item.link!}',
                        maxLines: 2,
                        style:
                            Theme.of(context).textTheme.bodySmall!.copyWith(),
                      ),*/
                    const SizedBox(height: 8),
                    const Row(
                      children: <Widget>[
                        SizedBox(width: 4),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TrolleyNewsLoading extends StatelessWidget {
  const TrolleyNewsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
