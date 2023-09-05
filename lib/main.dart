import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/counter_bloc/counter_bloc.dart';
import 'package:untitled/user_bloc/user_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBloc()..add(CounterIncEvent());
    final userBloc = UserBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => counterBloc,
        ),
        BlocProvider<UserBloc>(
          create: (context) => userBloc,
        ),
      ],
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  counterBloc.add(CounterIncEvent());
                },
                icon: const Icon(Icons.plus_one)),
            IconButton(
                onPressed: () {
                  counterBloc.add(CounterDecEvent());
                },
                icon: const Icon(Icons.exposure_minus_1)),
            IconButton(
                onPressed: () {
                  userBloc.add(GetUsersEvent(counterBloc.state));
                },
                icon: const Icon(Icons.person)),
            IconButton(
                onPressed: () {
                  userBloc.add(GetJobsEvent(counterBloc.state));
                },
                icon: const Icon(Icons.work)),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<CounterBloc, int>(
                  bloc: counterBloc,
                  builder: (context, state) {
                    return Text(
                      '$state',
                      style: const TextStyle(fontSize: 33),
                    );
                  },
                ),
                BlocBuilder<UserBloc, UserState>(
                  bloc: userBloc,
                  builder: (context, state) {

                    final users = state.users;
                    final jobs = state.jobs;

                    return Column(
                      children: [
                        if(state.isLoading)
                          const CircularProgressIndicator(),
                        if(users.isNotEmpty)
                          ...state.users.map((e) => const Icon(Icons.person)),
                        if(jobs.isNotEmpty)
                          ...state.jobs.map((e) => Text(e.name)),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
