import 'package:bhabhi_thulla/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class FriendRoomScreen extends StatelessWidget {
  const FriendRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: Get.height / 2 + 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: _joinCard()),

          const SizedBox(width: 20),

          Flexible(child: _createCard()),
        ],
      ),
    );
  }

  ///================ JOIN ROOM =================

  Widget _joinCard() {
    return Container(
      width: Get.width * 0.3,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .55),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.purpleAccent, width: 3),
      ),
      child: Column(
        children: [
          SizedBox(height: 12),
          const Text(
            "JOIN ROOM",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 25),

          const Text(
            "Enter Room Code To Join",
            style: TextStyle(color: Colors.purpleAccent, fontSize: 10),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              decoration: InputDecoration(
                hintText: "ROOM CODE",
                hintStyle: const TextStyle(color: Colors.purple),
                filled: true,
                fillColor: Colors.black54,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.purpleAccent,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.purpleAccent,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          CustomButton(
            horizontalPadding: 35,
            buttonHeight: 40,
            color: Colors.purple,
            text: "JOIN",
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  ///================ CREATE =================

  Widget _createCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .55),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.green, width: 3),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            "CREATE ROOM",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 5),

          _sectionTitle("SELECT PLAYERS"),

          const SizedBox(height: 10),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _chip("3", true),
              _chip("4", false),
              _chip("5", false),
              _chip("6", false),
              _chip("7", false),
            ],
          ),

          const SizedBox(height: 10),

          _sectionTitle("ROOM TYPE"),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(child: _chip("PUBLIC", true)),
                const SizedBox(width: 10),
                Expanded(child: _chip("PRIVATE", false)),
              ],
            ),
          ),
          const SizedBox(height: 15),
          CustomButton(text: "CREATE", color: Colors.green, onPressed: () {  }, horizontalPadding: 35,
            buttonHeight: 40,),
        ],
      ),
    );
  }

  Widget _sectionTitle(String txt) {
    return Text(
      txt,
      style: const TextStyle(
        color: Colors.greenAccent,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _chip(String text, bool selected) {
    return Container(
      width: 50,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: selected
            ? const LinearGradient(
                colors: [Color(0xffFFD84D), Color(0xffD68C00)],
              )
            : LinearGradient(
                colors: [Colors.grey.shade700, Colors.grey.shade900],
              ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
