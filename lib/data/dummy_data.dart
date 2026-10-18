import '../models/question.dart';

final List<Question> dummyQuestions = [
  Question(
    text: "Apa fungsi utama dari 'Provider' dalam pengembangan aplikasi Flutter?",
    options: [
      "Manajemen Database",
      "State Management",
      "Desain UI",
      "Routing Halaman"
    ],
    correctOptionIndex: 1,
  ),
  Question(
    text: "Dalam anime 'Frieren: Beyond Journey's End', siapa nama pahlawan yang memimpin party mengalahkan Raja Iblis?",
    options: ["Himmel", "Heiter", "Eisen", "Stark"],
    correctOptionIndex: 0,
  ),
  Question(
    text: "Library apa yang sering digunakan bersama C++ untuk merender grafik 2D dan 3D sederhana?",
    options: ["Pandas", "React", "FreeGLUT", "TensorFlow"],
    correctOptionIndex: 2,
  ),
  Question(
    text: "Manakah dari berikut ini yang dapat digunakan untuk mengatur navigasi (routing) di Flutter?",
    options: ["Navigator", "GoRouter", "Semua Benar", "Semua Salah"],
    correctOptionIndex: 2,
  ),
  Question(
    text: "Di dunia anime One Piece, apa nama pedang yang digunakan Roronoa Zoro yang sebelumnya adalah milik Kuina?",
    options: ["Sandai Kitetsu", "Wado Ichimonji", "Shusui", "Enma"],
    correctOptionIndex: 1,
  ),
];