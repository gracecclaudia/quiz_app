import '../models/question.dart';

final List<Question> dummyQuestions = [
  // kriptografi
  Question(
      category: "Kriptografi",
      difficulty: "Mudah",
      text: "Apa tujuan utama dari fungsi Hash dalam kriptografi?",
      options: ["Kerahasiaan", "Integritas Data", "Ketersediaan", "Kecepatan"],
      correctOptionIndex: 1,
      explanation: "Fungsi Hash menghasilkan nilai unik (digest) untuk memastikan data tidak mengalami perubahan atau modifikasi (menjaga integritas data)."
  ),
  Question(
      category: "Kriptografi",
      difficulty: "Mudah",
      text: "Algoritma asimetris yang menggunakan sepasang kunci (Public & Private Key) adalah...",
      options: ["AES", "DES", "RSA", "Caesar Cipher"],
      correctOptionIndex: 2,
      explanation: "RSA adalah algoritma kriptografi asimetris yang memanfaatkan sepasang kunci: Public Key untuk enkripsi dan Private Key untuk dekripsi."
  ),
  Question(
      category: "Kriptografi",
      difficulty: "Sedang",
      text: "Algoritma kriptografi simetris yang menggunakan metode 'stream cipher' adalah...",
      options: ["RC4", "AES-256", "RSA", "MD5"],
      correctOptionIndex: 0,
      explanation: "RC4 adalah algoritma simetris tipe stream cipher yang mengenkripsi data secara byte per byte atau bit per bit secara berurutan."
  ),
  Question(
      category: "Kriptografi",
      difficulty: "Sulit",
      text: "Protokol standar yang sering digunakan untuk mengamankan dan mengenkripsi komunikasi Email adalah...",
      options: ["HTTP", "S/MIME", "FTP", "SNMP"],
      correctOptionIndex: 1,
      explanation: "S/MIME (Secure/Multipurpose Internet Mail Extensions) memfasilitasi enkripsi dan tanda tangan digital pada pesan email."
  ),
  Question(
      category: "Kriptografi",
      difficulty: "Sedang",
      text: "Proses mengubah ciphertext kembali menjadi plaintext yang dapat dibaca disebut...",
      options: ["Enkripsi", "Hashing", "Dekripsi", "Steganografi"],
      correctOptionIndex: 2,
      explanation: "Dekripsi adalah proses mengembalikan teks terenkripsi (ciphertext) menjadi teks asli (plaintext) menggunakan kunci dekripsi yang sesuai."
  ),

  // grafkom
  Question(
      category: "Grafika Komputer",
      difficulty: "Mudah",
      text: "Warna dasar yang digunakan dalam sistem tampilan monitor adalah...",
      options: ["CMYK", "RGB", "HSV", "Grayscale"],
      correctOptionIndex: 1,
      explanation: "Monitor menggunakan model warna aditif RGB (Red, Green, Blue) yang dipancarkan melalui cahaya piksel layar."
  ),
  Question(
      category: "Grafika Komputer",
      difficulty: "Sedang",
      text: "Proses mengubah representasi matematis objek 3D menjadi gambar 2D di layar disebut...",
      options: ["Modeling", "Rendering", "Rigging", "Texturing"],
      correctOptionIndex: 1,
      explanation: "Rendering adalah tahap akhir dalam pipeline grafis di mana model 3D diproses beserta pencahayaan dan tekstur menjadi gambar 2D."
  ),
  Question(
      category: "Grafika Komputer",
      difficulty: "Sulit",
      text: "Library berbasis C++ yang sering digunakan untuk merender grafik dan membuat jendela tampilan OpenGL secara sederhana adalah...",
      options: ["Pandas", "React", "FreeGLUT", "TensorFlow"],
      correctOptionIndex: 2,
      explanation: "FreeGLUT adalah pustaka utilitas sumber terbuka yang mempermudah pembuatan jendela dan penanganan input pada program OpenGL."
  ),
  Question(
      category: "Grafika Komputer",
      difficulty: "Sedang",
      text: "Transformasi matriks yang digunakan untuk menggeser posisi suatu objek disebut...",
      options: ["Rotasi", "Skala", "Translasi", "Shear"],
      correctOptionIndex: 2,
      explanation: "Translasi adalah transformasi geometri yang memindahkan/menggeser setiap titik pada objek dengan jarak dan arah yang sama."
  ),
  Question(
      category: "Grafika Komputer",
      difficulty: "Sulit",
      text: "Dalam FreeGLUT, fungsi callback apa yang sering digunakan untuk mendeteksi input tombol keyboard khusus (seperti arah panah)?",
      options: ["glutKeyboardFunc", "glutSpecialFunc", "glutMouseFunc", "glutDisplayFunc"],
      correctOptionIndex: 1,
      explanation: "glutSpecialFunc digunakan secara khusus untuk menangani input dari tombol non-ASCII, seperti tombol fungsi (F1-F12) dan tombol arah panah."
  ),

  // pemob
  Question(
      category: "Pemrograman Mobile",
      difficulty: "Mudah",
      text: "Framework UI buatan Google untuk membuat aplikasi mobile secara cross-platform adalah...",
      options: ["React Native", "Kotlin", "Flutter", "Swift"],
      correctOptionIndex: 2,
      explanation: "Flutter adalah UI toolkit dari Google untuk membangun aplikasi multi-platform yang dikompilasi secara native dari satu basis kode."
  ),
  Question(
      category: "Pemrograman Mobile",
      difficulty: "Mudah",
      text: "Bahasa pemrograman utama yang digunakan dalam pengembangan aplikasi Flutter adalah...",
      options: ["Java", "Dart", "C++", "Python"],
      correctOptionIndex: 1,
      explanation: "Flutter sepenuhnya menggunakan bahasa pemrograman Dart, yang juga dikembangkan oleh Google, karena mendukung kompilasi JIT dan AOT."
  ),
  Question(
      category: "Pemrograman Mobile",
      difficulty: "Sedang",
      text: "Widget di Flutter yang tampilannya bersifat statis dan tidak berubah setelah di-render adalah...",
      options: ["StatefulWidget", "StatelessWidget", "Scaffold", "Container"],
      correctOptionIndex: 1,
      explanation: "StatelessWidget bersifat immutable (tidak dapat diubah) dan tidak memiliki state internal yang perlu dipantau ulang setelah dibangun."
  ),
  Question(
      category: "Pemrograman Mobile",
      difficulty: "Sulit",
      text: "Package mana yang sangat direkomendasikan untuk mengelola State Management agar data tidak hilang saat layar dirotasi?",
      options: ["http", "shared_preferences", "provider", "url_launcher"],
      correctOptionIndex: 2,
      explanation: "Provider adalah package state management terpopuler di Flutter yang bekerja dengan memisahkan UI dan logika bisnis di luar tree widget utama."
  ),
  Question(
      category: "Pemrograman Mobile",
      difficulty: "Sedang",
      text: "Dalam Firebase, layanan apa yang sering digunakan untuk sistem login pengguna?",
      options: ["Firestore", "Realtime Database", "Firebase Authentication", "Cloud Storage"],
      correctOptionIndex: 2,
      explanation: "Firebase Authentication menyediakan layanan backend, SDK yang mudah digunakan, dan UI untuk mengautentikasi pengguna ke aplikasi Anda."
  ),

  // hci
  Question(
      category: "Human Computer Interaction",
      difficulty: "Mudah",
      text: "Tingkat kemudahan sebuah aplikasi untuk digunakan oleh pengguna disebut...",
      options: ["Reliability", "Usability", "Scalability", "Security"],
      correctOptionIndex: 1,
      explanation: "Usability (Ketergunaan) adalah atribut kualitas yang menilai seberapa mudah user interface digunakan oleh target pengguna."
  ),
  Question(
      category: "Human Computer Interaction",
      difficulty: "Mudah",
      text: "Software desain antarmuka (UI/UX) kolaboratif yang populer dan sering digunakan untuk membuat mockup adalah...",
      options: ["Notepad", "Figma", "Android Studio", "VS Code"],
      correctOptionIndex: 1,
      explanation: "Figma adalah aplikasi desain antarmuka berbasis vektor dan prototyping yang memungkinkan kolaborasi tim secara real-time via browser."
  ),
  Question(
      category: "Human Computer Interaction",
      difficulty: "Sedang",
      text: "Desain purwarupa (prototype) yang memiliki detail tinggi dan sangat mirip dengan produk asli disebut...",
      options: ["Low-Fidelity", "High-Fidelity", "Wireframe", "Sketch"],
      correctOptionIndex: 1,
      explanation: "High-Fidelity prototype memiliki tingkat interaktivitas dan visual (warna, font, aset) yang hampir identik dengan produk akhir."
  ),
  Question(
      category: "Human Computer Interaction",
      difficulty: "Sulit",
      text: "Evaluasi Heuristik (Heuristic Evaluation) pada desain antarmuka idealnya dilakukan oleh...",
      options: ["Pengguna Awam", "Pakar/Ahli UX", "Developer Backend", "Investor"],
      correctOptionIndex: 1,
      explanation: "Evaluasi Heuristik adalah metode inspeksi usability di mana pakar (ahli) mengevaluasi UI berdasarkan prinsip-prinsip (heuristik) yang telah diakui."
  ),
  Question(
      category: "Human Computer Interaction",
      difficulty: "Sedang",
      text: "Prinsip desain yang memastikan aplikasi dapat digunakan dengan baik oleh pengguna dengan keterbatasan/disabilitas adalah...",
      options: ["Aesthetic", "Accessibility", "Visibility", "Consistency"],
      correctOptionIndex: 1,
      explanation: "Accessibility (Aksesibilitas) berfokus pada perancangan produk agar dapat digunakan oleh semua orang, termasuk mereka yang memiliki keterbatasan visual, pendengaran, atau motorik."
  ),

  // kpt
  Question(
      category: "Komputasi Paralel dan Terdistribusi",
      difficulty: "Mudah",
      text: "Menjalankan beberapa tugas komputasi secara bersamaan di saat yang sama disebut...",
      options: ["Sequential Processing", "Parallel Processing", "Batch Processing", "Time Sharing"],
      correctOptionIndex: 1,
      explanation: "Parallel Processing memecah tugas besar menjadi bagian-bagian kecil yang dieksekusi secara serentak pada beberapa prosesor."
  ),
  Question(
      category: "Komputasi Paralel dan Terdistribusi",
      difficulty: "Mudah",
      text: "Kondisi dimana dua proses atau lebih saling menunggu resource satu sama lain tanpa akhir disebut...",
      options: ["Starvation", "Race Condition", "Deadlock", "Interrupt"],
      correctOptionIndex: 2,
      explanation: "Deadlock terjadi ketika sekumpulan proses diblokir secara permanen karena masing-masing menahan resource dan menunggu resource lain yang sedang ditahan oleh proses lain dalam kumpulan tersebut."
  ),
  Question(
      category: "Komputasi Paralel dan Terdistribusi",
      difficulty: "Sedang",
      text: "Kepanjangan dari RPC dalam sistem terdistribusi adalah...",
      options: ["Remote Procedure Call", "Random Process Control", "Rapid Protocol Connection", "Remote Protocol Config"],
      correctOptionIndex: 0,
      explanation: "Remote Procedure Call (RPC) adalah protokol yang memungkinkan suatu program komputer meminta layanan/menjalankan fungsi dari program di komputer lain dalam jaringan tanpa harus memahami detail jaringannya."
  ),
  Question(
      category: "Komputasi Paralel dan Terdistribusi",
      difficulty: "Sulit",
      text: "Model pemrograman paralel yang sering digunakan pada cluster komputer terdistribusi adalah...",
      options: ["OpenMP", "MPI (Message Passing Interface)", "Pthreads", "CUDA"],
      correctOptionIndex: 1,
      explanation: "MPI adalah standar spesifikasi API komunikasi message-passing yang dirancang untuk fungsi komputasi paralel tingkat tinggi pada arsitektur terdistribusi."
  ),
  Question(
      category: "Komputasi Paralel dan Terdistribusi",
      difficulty: "Sedang",
      text: "Sistem arsitektur yang memisahkan komputer penyedia layanan dan komputer pengguna disebut...",
      options: ["Peer-to-Peer", "Client-Server", "Monolithic", "Standalone"],
      correctOptionIndex: 1,
      explanation: "Arsitektur Client-Server membagi beban kerja antara penyedia sumber daya/layanan (Server) dan peminta layanan (Client)."
  ),

  // metopen
  Question(
      category: "Metodologi Penelitian",
      difficulty: "Mudah",
      text: "Penelitian yang datanya berupa angka dan dianalisis menggunakan ilmu statistik disebut penelitian...",
      options: ["Kualitatif", "Kuantitatif", "Deskriptif", "Studi Kasus"],
      correctOptionIndex: 1,
      explanation: "Penelitian Kuantitatif berfokus pada pengumpulan dan analisis data numerik (angka) untuk menguji hipotesis statistik."
  ),
  Question(
      category: "Metodologi Penelitian",
      difficulty: "Mudah",
      text: "Dugaan sementara atau jawaban sementara terhadap masalah penelitian disebut...",
      options: ["Teori", "Asumsi", "Hipotesis", "Kesimpulan"],
      correctOptionIndex: 2,
      explanation: "Hipotesis adalah pernyataan prediktif atau dugaan rasional yang harus diuji kebenarannya melalui pengumpulan data eksperimen atau observasi."
  ),
  Question(
      category: "Metodologi Penelitian",
      difficulty: "Sedang",
      text: "Variabel yang dipengaruhi atau yang menjadi akibat dari variabel bebas disebut...",
      options: ["Variabel Dependen", "Variabel Independen", "Variabel Kontrol", "Variabel Pengganggu"],
      correctOptionIndex: 0,
      explanation: "Variabel Dependen (terikat) adalah variabel yang nilainya berubah sebagai respons atau efek dari manipulasi Variabel Independen (bebas)."
  ),
  Question(
      category: "Metodologi Penelitian",
      difficulty: "Sedang",
      text: "Proses mengumpulkan dan menelaah jurnal/buku terkait topik penelitian disebut...",
      options: ["Pengumpulan Data", "Tinjauan Pustaka", "Analisis Data", "Observasi"],
      correctOptionIndex: 1,
      explanation: "Tinjauan Pustaka (Literature Review) adalah evaluasi kritis terhadap literatur akademik yang relevan untuk membangun dasar teori penelitian."
  ),
  Question(
      category: "Metodologi Penelitian",
      difficulty: "Sulit",
      text: "Teknik pengumpulan data yang paling tepat untuk penelitian kualitatif guna menggali informasi mendalam adalah...",
      options: ["Kuesioner/Survei", "Eksperimen Lab", "Wawancara Mendalam", "Polling"],
      correctOptionIndex: 2,
      explanation: "Wawancara Mendalam (In-depth Interview) memungkinkan peneliti kualitatif menggali perspektif, pengalaman, dan pandangan responden secara komprehensif dan terbuka."
  ),

  // cloud computing
  Question(
      category: "Cloud Computing",
      difficulty: "Mudah",
      text: "Layanan cloud yang menyediakan infrastruktur seperti server virtual dan storage disebut...",
      options: ["SaaS", "IaaS", "PaaS", "FaaS"],
      correctOptionIndex: 1,
      explanation: "IaaS (Infrastructure as a Service) menyewakan sumber daya komputasi dasar seperti server, jaringan, dan penyimpanan di cloud (cth: AWS EC2)."
  ),
  Question(
      category: "Cloud Computing",
      difficulty: "Mudah",
      text: "Google Drive, Gmail, dan Dropbox adalah contoh layanan cloud tipe...",
      options: ["SaaS", "IaaS", "PaaS", "BaaS"],
      correctOptionIndex: 0,
      explanation: "SaaS (Software as a Service) memberikan akses aplikasi perangkat lunak langsung ke pengguna akhir via internet tanpa perlu instalasi lokal."
  ),
  Question(
      category: "Cloud Computing",
      difficulty: "Sedang",
      text: "Teknologi dasar yang memungkinkan satu server fisik dibagi menjadi beberapa server logika disebut...",
      options: ["Kontainerisasi", "Enkripsi", "Virtualisasi", "Hashing"],
      correctOptionIndex: 2,
      explanation: "Virtualisasi menggunakan hypervisor untuk memisahkan sumber daya perangkat keras fisik menjadi beberapa mesin virtual (VM) yang independen."
  ),
  Question(
      category: "Cloud Computing",
      difficulty: "Sedang",
      text: "Kemampuan cloud untuk menambah atau mengurangi resource secara otomatis sesuai beban kerja disebut...",
      options: ["Reliability", "Elasticity (Elastisitas)", "Latency", "Redundancy"],
      correctOptionIndex: 1,
      explanation: "Elastisitas (Elasticity) memastikan sistem dapat melakukan auto-scaling (scale up/scale down) resource seketika saat terjadi lonjakan atau penurunan trafik."
  ),
  Question(
      category: "Cloud Computing",
      difficulty: "Sulit",
      text: "Layanan cloud yang menyediakan platform lengkap (OS, database, web server) bagi developer untuk mendeploy aplikasi tanpa mengurus infrastruktur disebut...",
      options: ["IaaS", "PaaS", "SaaS", "DaaS"],
      correctOptionIndex: 1,
      explanation: "PaaS (Platform as a Service) memberi developer lingkungan siap pakai untuk membangun, menguji, dan mendeploy aplikasi (cth: Heroku, Google App Engine)."
  ),
];