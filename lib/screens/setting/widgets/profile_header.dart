import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatefulWidget {
  final String coverImage;
  final String avatar;
  final String? title;
  final String? subtitle;
  final List<Widget>? actions;
  const ProfileHeader({Key? key, required this.coverImage, required this.avatar, this.title, this.subtitle, this.actions}) : super(key: key);

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(widget.coverImage), fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (widget.actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: widget.actions!,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: widget.avatar,
                radius: 40,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                widget.title!,
                style: Theme.of(context).textTheme.title,
              ),
              if (widget.subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  widget.subtitle!,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}


class Avatar extends StatelessWidget {
  final String image;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? radius;
  final double? borderWidth;

  const Avatar(
      {Key? key,
         required this.image,
        this.borderColor = Colors.grey,
        this.backgroundColor,
        this.radius = 30,
        this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius! + borderWidth!,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius! - borderWidth!,
          backgroundImage: NetworkImage(image),
        ),
      ),
    );
  }
}

