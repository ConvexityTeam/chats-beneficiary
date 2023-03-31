import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/general_base_provider_model.dart';
import 'domain/general_locator.dart';

class GBaseViewModel<T extends GBaseProviderModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T provider, Widget? child)?
      builder;
  final Function(T)? providerReady;

  GBaseViewModel({this.builder, this.providerReady});

  @override
  _BaseViewModelState<T> createState() => _BaseViewModelState<T>();
}

class _BaseViewModelState<T extends GBaseProviderModel>
    extends State<GBaseViewModel<T>> {
  T provider = newLocator<T>();

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
