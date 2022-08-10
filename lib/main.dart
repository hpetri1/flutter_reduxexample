import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' as hooks;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:reduxexample/enums.dart';
import 'package:reduxexample/redux/actions.dart';
import 'package:reduxexample/redux/reducers.dart';
import 'package:reduxexample/redux/state.dart' as state;

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}

class HomePage extends hooks.HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Store(
      appStateReducer,
      initialState: const state.State(
        items: [],
        filter: ItemFilter.all,
      ),
    );
    final textController = hooks.useTextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: StoreProvider(
        store: store,
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    store
                        .dispatch(const ChangeFilterTypeAction(ItemFilter.all));
                  },
                  child: const Text('All'),
                ),
                TextButton(
                  onPressed: () {
                    store.dispatch(
                        const ChangeFilterTypeAction(ItemFilter.shortTexts));
                  },
                  child: const Text('Short items'),
                ),
                TextButton(
                  onPressed: () {
                    store.dispatch(
                        const ChangeFilterTypeAction(ItemFilter.longTexts));
                  },
                  child: const Text('Long items'),
                )
              ],
            ),
            TextField(
              controller: textController,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    final text = textController.text;
                    store.dispatch(AddItemAction(text));
                    textController.clear();
                  },
                  child: const Text('Add'),
                ),
                TextButton(
                  onPressed: () {
                    final text = textController.text;
                    store.dispatch(RemoveItemAction(text));
                    textController.clear();
                  },
                  child: const Text('Remove'),
                ),
              ],
            ),
            StoreConnector<state.State, Iterable<String>>(
              converter: (store) => store.state.filteredItems,
              builder: (context, items) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items.elementAt(index);
                      return ListTile(
                        title: Text(item),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
