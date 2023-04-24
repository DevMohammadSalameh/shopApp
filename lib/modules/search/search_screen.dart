
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/search_cubit.dart';
import '../../models/search_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import 'cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var formKey = GlobalKey<FormState>();
          var searchController = TextEditingController();
          List<BoxShadow>? boxShadow = [const BoxShadow(blurRadius: 20)];
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defaultFormField(
                            controller: searchController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "type something to search for";
                              }
                              return null;
                            },
                            // onChange: (String value) {
                            //   SearchCubit.get(context).search(value);
                            // },
                            onSubmit: (String value) {
                              SearchCubit.get(context).search(value);
                            },
                            label: "search",
                            labelStyle: const TextStyle(color: primaryColor),
                            suffix: Icons.search),
                        const SizedBox(
                          height: 10,
                        ),
                        if (state is SearchLoadingState)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                        if (state is SearchSuccessState)
                          Expanded(
                            child: ListView.builder(
                                itemBuilder: (context, index) => searchItem(
                                    boxShadow,
                                    SearchCubit.get(context)
                                        .searchModel!
                                        .data!
                                        .data![index],
                                    context),
                                itemCount: SearchCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .data!.length),
                          )
                      ],
                    )),
              ));
        },
      ),
    );
  }

  Widget searchItem(List<BoxShadow>? boxShadow,SearchData model, context) {

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: boxShadow,
      ),
      height: 120,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Image(
              image: NetworkImage(
                model.image.toString(),
              ),
              height: 120,
              width: 120,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    model.price.toString(),
                    //model.price.toString(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
