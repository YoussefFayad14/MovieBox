import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviebox/features/home/logic/home_state.dart';
import 'package:moviebox/features/home/widget/error_view.dart';
import 'package:moviebox/features/home/widget/searchbar.dart';
import '../../../data/repository/movie_repository.dart';
import '../logic/home_cubit.dart';
import '../widget/categorytabs.dart';
import '../widget/home_drawer.dart';
import '../widget/movie_grid.dart';
import '../widget/trending_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _homeCubit;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit(MovieRepository());
    _homeCubit.fetchTrendingMovies();
  }

  void _onCategoryChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (index == 0) {
      _homeCubit.fetchTvSeries();
    } else if (index == 1) {
      _homeCubit.fetchMovies();
    } else if (index == 2) {
      _homeCubit.fetchUpcoming();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _homeCubit,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Text(
            "MovieBox",
            style: GoogleFonts.anton(
              fontSize: 28,
              color: Colors.amber,
              letterSpacing: 1.5,
            ),
          ),
          centerTitle: true,
        ),
        drawer: HomeDrawer(),
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: BlocListener<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.error,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.amber),
                  );
                } else if (state is HomeSuccess) {
                  final trendingMovies = state.trendingMovies;
                  final categoryMovies = state.categoryMovies;
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          SearchBarWidget(),
                          SizedBox(height: 20),
                          TrendingCarousel(movies: trendingMovies),
                          SizedBox(height: 20),
                          CategoryTabs(
                            selectedIndex: selectedIndex,
                            onTabChanged: _onCategoryChanged,
                          ),
                          SizedBox(height: 20),
                        ]),
                      ),
                      MovieGrid(movies: categoryMovies),
                      SliverToBoxAdapter(
                        child: SizedBox(height: 40),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: ErrorView(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
