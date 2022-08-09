import 'package:flutter/foundation.dart';
import 'package:reduxexample/enums.dart';

@immutable
abstract class Action {
  const Action();
}

// For filters
@immutable
class ChangeFilterTypeAction extends Action {
  final ItemFilter filter;

  const ChangeFilterTypeAction(this.filter);
}

// For items
@immutable
abstract class ItemAction extends Action {
  final String item;

  const ItemAction(this.item);
}

@immutable
class AddItemAction extends ItemAction {
  const AddItemAction(String item) : super(item);
}

@immutable
class RemoveItemAction extends ItemAction {
  const RemoveItemAction(String item) : super(item);
}
