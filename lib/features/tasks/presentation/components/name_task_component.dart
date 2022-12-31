import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/features/tasks/presentation/providers/name_task_provider.dart';
import 'package:neurocheck/features/tasks/presentation/components/task_name_text_fields.dart';

import '../../../../core/presentation/styles/sizes.dart';

class NameTaskComponent extends HookConsumerWidget {
  const NameTaskComponent( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {

    final nameController = useTextEditingController(text: '');

    final nameProvider = ref.read(nameTaskProvider.notifier);

    final nameTaskFormKey = useMemoized(() => GlobalKey<FormState>());



    return Form(
      key: nameTaskFormKey,
      child: Column(
        children: [
          NameTaskTextFieldsSection(
            nameController: nameController,
            onFieldSubmitted: (value) {
              //log(value + 'component');
              //log('hey');
              if (nameTaskFormKey.currentState!.validate()) {
                useEffect(() {
                  nameController.text = value;
                },);
                nameController.text= value;
                //  nameProvider.controllerName();
                nameProvider.setNameTask(value);
              }
            },
          ),
        ],
      ),
    );
  }
}