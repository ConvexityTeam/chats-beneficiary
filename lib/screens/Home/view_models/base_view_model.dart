import 'package:CHATS/providers/base_provider_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/locator.dart';

class BaseViewModel<T extends BaseProviderModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T provider, Widget? child)?
      builder;
  final Function(T)? providerReady;

  BaseViewModel({this.builder, this.providerReady});

  @override
  _BaseViewModelState<T> createState() => _BaseViewModelState<T>();
}

class _BaseViewModelState<T extends BaseProviderModel>
    extends State<BaseViewModel<T>> {
  T provider = locator<T>();

  @override
  void initState() {
    if (widget.providerReady != null) {
      widget.providerReady!(provider);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Consumer<T>(builder: widget.builder!),
    );
  }
}
