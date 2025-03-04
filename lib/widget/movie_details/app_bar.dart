import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/class/app_colors.dart';

import '../../bloc/fav_Bar/add_fav.dart' show AddFavBar;
import '../../bloc/fav_Bar/check_fav.dart';
import '../../bloc/states/fav states/check_fav_state.dart';

class AppBarDetails extends StatelessWidget {
  final int movieId;
  final String title;
  final int year;
  final num rating;
  final String imageURL;

  const AppBarDetails({
    super.key,
    required this.movieId,
    required this.title,
    required this.year,
    required this.rating,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    final addFavBloc = BlocProvider.of<AddFavBar>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.text,
            size: 30,
          ),
        ),
        BlocBuilder<CheckFavBar, CheckFavStates>(
          builder: (context, state) {
            bool isFav = state is CheckFavSuccessState;
            return IconButton(
              onPressed: () async {
                if (isFav) {
                  await addFavBloc.removeFav(movieId);
                } else {
                  await addFavBloc.addFav(
                      movieId, title, rating, imageURL, year);
                }
                context.read<CheckFavBar>().checkFav(movieId);
              },
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? AppColors.buttonRed : AppColors.text,
                size: 30,
              ),
            );
          },
        ),
      ],
    );
  }
}
