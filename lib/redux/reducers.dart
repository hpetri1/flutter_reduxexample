import 'package:reduxexample/enums.dart';
import 'package:reduxexample/redux/actions.dart';
import 'package:reduxexample/extensions/add_remove_tems.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

Reducer<Iterable<String>> itemsReducer = combineReducers<Iterable<String>>([
  TypedReducer<Iterable<String>, AddItemAction>(addItemReducer),
  TypedReducer<Iterable<String>, RemoveItemAction>(removeItemReducer)
]);

Iterable<String> addItemReducer(
        Iterable<String> previousItems, AddItemAction action) =>
    previousItems + action.item;

Iterable<String> removeItemReducer(
        Iterable<String> previousItems, RemoveItemAction action) =>
    previousItems - action.item;

ItemFilter itemFilterReducer(
  State oldState,
  Action action,
) {}
