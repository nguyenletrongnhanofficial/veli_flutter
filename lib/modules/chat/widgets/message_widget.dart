/// Tạo biến gồm message<String>, time<Datetime>, position<String>(left - right)
/// Yêu cầu: nếu truyền position: 'right' thì có background màu xanh, chữ trắng,
/// bo tròn 3 góc, nếu left thì ngược lại + kèm avatar
import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  final String? message;
  final DateTime time;
  final String? position;
  const MessageWidget({
    required this.message,
    required this.time,
    required this.position,
    Key? key,
  }) : super(key: key);
  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: widget.position == 'right'
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (widget.position == 'left')
              CircleAvatar(
                backgroundImage: Image.asset(
                  'assets/images/image_avt_default.jpg',
                  height: 60,
                  width: 60,
                ).image,
                // radius: 20,
              ),
            Column(
              crossAxisAlignment: widget.position == 'left'
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  // constraints: giới hạn maxWith của container -> MediaQuery: 70% chiều rộng của màn hình
                  decoration: BoxDecoration(
                    color: widget.position == 'right'
                        ? Colors.green
                        : Colors.pink[50],
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(widget.position == 'right' ? 8.0 : 0),
                      topRight: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight:
                          Radius.circular(widget.position == 'right' ? 0 : 8.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.message}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: widget.position == 'right'
                                ? Colors.white
                                : Colors.black,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    '${widget.time.hour} : ${widget.time.minute}', // định dạng giờ:phút
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
