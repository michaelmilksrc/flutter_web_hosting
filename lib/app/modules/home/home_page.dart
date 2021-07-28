import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'counter_cubit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CounterCubit _counterCubit = Modular.get();

  @override
  void dispose() {
    _counterCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: _counterCubit.decrement,
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: _counterCubit.increment,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Button Tapped:"),
            StreamBuilder(
              stream: _counterCubit.stream,
              builder: (context, count) {
                if (!count.hasData)
                  return Text(
                    "0",
                    style: Theme.of(context).textTheme.headline3,
                  );
                if (count.hasError)
                  return Center(
                    child: Text("Deu ruim"),
                  );
                return Text(
                  "${count.data}",
                  style: Theme.of(context).textTheme.headline3,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
