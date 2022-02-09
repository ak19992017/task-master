class ChatUsers {
  String name;
  String bio;
  String location;
  String messageText;
  String imageURL;
  String time;
  ChatUsers({
    required this.name,
    required this.bio,
    required this.location,
    required this.messageText,
    required this.imageURL,
    required this.time,
  });
}

List<ChatUsers> chatUsers = [
  ChatUsers(
    name: "Jane Russel",
    bio: "I ❤️ C/C++ | 🎯 Learning DSA | \nI learn and teach cool things.",
    location: 'London, UK',
    messageText: "Awesome Setup",
    imageURL: "assets/profiles/userImage1.png",
    time: "Now",
  ),
  ChatUsers(
    name: "Glady's Murphy",
    bio: "I ❤️ C/C++ | 🎯 Learning DSA | \nI learn and teach cool things.",
    location: 'London, UK',
    messageText: "That's Great",
    imageURL: "assets/profiles/userImage2.png",
    time: "Yesterday",
  ),
  ChatUsers(
    name: "Jorge Henry",
    bio: "I ❤️ C/C++ | 🎯 Learning DSA | \nI learn and teach cool things.",
    location: 'London, UK',
    messageText: "Hey where are you?",
    imageURL: "assets/profiles/userImage3.png",
    time: "31 Mar",
  ),
  ChatUsers(
      name: "Philip Fox",
      bio: "I ❤️ C/C++ | 🎯 Learning DSA | \nI learn and teach cool things.",
      location: 'London, UK',
      messageText: "Busy! Call me in 20 mins",
      imageURL: "assets/profiles/userImage4.png",
      time: "28 Mar"),
  ChatUsers(
    name: "Debra Hawkins",
    bio: "I ❤️ C/C++ | 🎯 Learning DSA | \nI learn and teach cool things.",
    location: 'London, UK',
    messageText: "Thankyou, It's awesome",
    imageURL: "assets/profiles/userImage5.png",
    time: "23 Mar",
  ),
  ChatUsers(
    name: "Jacob Pena",
    bio: "I ❤️ C/C++ | 🎯 Learning DSA | \nI learn and teach cool things.",
    location: 'London, UK',
    messageText: "will update you in evening",
    imageURL: "assets/profiles/userImage6.png",
    time: "17 Mar",
  ),
  ChatUsers(
    name: "Andrey Jones",
    bio: "I ❤️ C/C++ | 🎯 Learning DSA | \nI learn and teach cool things.",
    location: 'London, UK',
    messageText: "Can you please share the file?",
    imageURL: "assets/profiles/userImage7.png",
    time: "24 Feb",
  ),
  ChatUsers(
    name: "John Wick",
    bio: "I ❤️ C/C++ | 🎯 Learning DSA | \nI learn and teach cool things.",
    location: 'London, UK',
    messageText: "How are you?",
    imageURL: "assets/profiles/userImage8.png",
    time: "18 Feb",
  ),
];
