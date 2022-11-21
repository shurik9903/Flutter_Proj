import 'package:flutter/material.dart';
import 'package:flutter_proj/modules/DescriptionFetch.dart';
import 'package:flutter_proj/widgets/Create.dart';
import 'package:provider/provider.dart';

import '../data/DataTitle.dart';
import '../data/JSONData.dart';
import '../theme/AppThemeDefault.dart';
import 'SidePanel.dart';

class ListDescript extends StatefulWidget {
  const ListDescript({super.key});

  @override
  State<ListDescript> createState() => _ListDescriptState();
}

class _ListDescriptState extends State<ListDescript> {
  List<ViewDescript> view = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      () async {
        await getDescriptFetch(context.read<DataTitle>().id).then((value) {
          if (value is List<DataDescript>) {
            context.read<DataTitle>().descript = value;
          }
        }).catchError((error) {
          print(error);
        });
      }();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      view = context.watch<DataTitle>().descript.map((data) {
        return ViewDescript(dataDescript: data);
      }).toList();
    });

    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Wrap(
                runSpacing: 10,
                children: [
                  ...view,
                ],
              ),
            ),
          ],
        ));
  }
}

class ViewDescript extends StatefulWidget {
  DataDescript dataDescript;

  ViewDescript({super.key, required this.dataDescript});

  @override
  State<ViewDescript> createState() => _ViewDescriptState();
}

class _ViewDescriptState extends State<ViewDescript> {
  late DataDescript dataDescript;

  @override
  Widget build(BuildContext context) {
    setState(() {
      dataDescript = widget.dataDescript;
    });

    return GestureDetector(
      onTap: () {
        context.read<SelectView>().view = DescriptCreate(
          name: dataDescript.name,
          otherName: dataDescript.otherName,
          images: dataDescript.images,
          pickerColor: dataDescript.color,
          text: dataDescript.text,
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: appTheme(context).mColor1.withOpacity(0.4),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            dataDescript.images?[0] ?? Container(),
            Text(
                style: TextStyle(color: dataDescript.color),
                dataDescript.name ?? ""),
          ],
        ),
      ),
    );
  }
}
