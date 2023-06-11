import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodflutter/components/upload_product.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                border: Border.all(color: Colors.grey)),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: TextField(
              onChanged: (val) {},
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: SvgPicture.asset("assets/icon/research.svg"),
                  hintText: "Search Here"),
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (cxt) {
                  return const UploadProduct();
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Center(
                    child: Text(
                      'Upload',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
