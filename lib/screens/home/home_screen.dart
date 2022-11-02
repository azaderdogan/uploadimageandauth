import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/repositories/network_repository.dart';

import '../../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeBloc = HomeBloc(RepositoryProvider.of<NetworkRepository>(context));
    _homeBloc.add(HomeLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeBloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: 200,
                child: TextButton(
                    onPressed: () {
                      _homeBloc.add(HomeUploadPhotoEvent());
                    },
                    child: Text('Upload Image')),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeInitial) {
                    return Center(
                      child: Text('Home'),
                    );
                  } else if (state is HomeLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomeLoaded) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.images.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                            leading: Image.network(state.images[index]),
                            title: Text('Sil'),
                            trailing: IconButton(
                                onPressed: () {
                                  _homeBloc.add(HomeDeletePhotoEvent(
                                      state.images[index]));
                                },
                                icon: Icon(Icons.delete)),
                          ));
                        },
                      ),
                    );
                  } else if (state is HomeError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Center(
                      child: Text('Unknown state'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
