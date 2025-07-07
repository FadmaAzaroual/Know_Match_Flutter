import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:know_match/home_screen.dart';

class GameScreen extends StatefulWidget {
  final int level;
  const GameScreen({super.key, this.level = 1});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  /* final List<Map<String,String>personsInfo=[
    {"image":"assets/cards/محمد_عابد_الجابري.png",
     "name":"محمد عابد الجابري",
     "info":"""محمد عابد الجابري كان رجلاً مغربياً يحب التفكير والفهم، وكان يسأل دائمًا: "لماذا نفكر بهذه الطريقة؟ وهل يمكن أن نفكر أفضل؟"
كان يقرأ كتب القدماء، ويحاول أن يشرحها بطريقة جديدة وسهلة، حتى يفهمها الناس اليوم.
لم يكن يخاف من طرح الأسئلة، وكان يرى أن العقل مثل العضلات، كلما استخدمناه أكثر، أصبح أقوى.
كان يريد أن نحب تراثنا، لكن نفهمه بعقلنا، لا فقط نقلده.
ترك لنا كتبًا كثيرة مثل كنوز، نفتحها فنجد أفكارًا تضيءلناالطريق."""
    },
    {"image":"assets/cards/عسو_اوبسلام.png",
      "name":"عسو_اوبسلام.png",
      "info":"""عسو أبسلام هو رمز البطولة والشجاعة في تاريخ المغرب، رجل جبلٍ قوي القلب وعظيم الإرادة.
قاد مقاومة بطولية ضد الاستعمار الفرنسي، مجسّدًا روح الحرية التي لا تقهر.
لم يكن يحمل سوى إيمانه العميق بحق شعبه في العيش بكرامة، فتحدى جيوشاً بأكملها بعزيمته الحديدية.
حكمته وشجاعته جمعتهما في قائد يُلهم الأجيال ويُذكره الجميع بفخر واعتزاز.
ظل اسمه نورًا يشع في صفحات التاريخ، يروي قصة رجل رفض الاستسلام مهما كانت الصعاب."""},


  ];*/
  late int pairs;
  final List<Map<String, String>> personsInfo = [
    {
      "image": "assets/cards/محمد_عابد_الجابري.png",
      "name": "محمد عابد الجابري",
      "info":
          """محمد عابد الجابري كان مفكرًا وفيلسوفًا مغربيًا، اشتهر بنقده للعقل العربي ومحاولته لفهم التراث بطريقة عقلانية.
كان يرى أن فهم الماضي ضروري لبناء مستقبل أفضل، ودعا إلى تجديد الفكر العربي بأسلوب حديث.
أشهر أعماله هي سلسلة "نقد العقل العربي"، التي أثرت كثيرًا في الفكر العربي المعاصر.""",
    },
    {
      "image": "assets/cards/عسو_اوبسلام.png",
      "name": "عسو أوبسلام",
      "info":
          """عسو أوبسلام كان من أبرز قادة المقاومة المسلحة في جبال الأطلس ضد الاستعمار الفرنسي.
قاد معركة بوكافر سنة 1933 بشجاعة كبيرة، حيث قاوم مع قريته الجيش الفرنسي لأسابيع طويلة.
يُعتبر رمزًا للفخر الوطني والتضحية من أجل حرية الوطن.""",
    },
    {
      "image": "assets/cards/رشيد_اليازمي.png",
      "name": "رشيد اليزمي",
      "info":
          """رشيد اليزمي هو عالم مغربي في الكيمياء والفيزياء، ساهم في تطوير بطاريات الليثيوم التي نستعملها اليوم في الهواتف.
حصل على عدة جوائز دولية لابتكاراته، ويُعتبر من أبرز العلماء المغاربة في الخارج.
عمل في مؤسسات علمية كبرى مثل ناسا وجامعات فرنسية وأمريكية.""",
    },
    {
      "image": "assets/cards/خناثة_بنت_بكار.png",
      "name": "خناثة بنت بكار",
      "info":
          """خناثة بنت بكار كانت امرأة أمازيغية ذكية وقوية في زمن السلطان المولى إسماعيل.
كانت مستشارة سياسية بارزة ومثلت صوتًا للمرأة في زمن كانت فيه السلطة حكراً على الرجال.
ساهمت في إدارة شؤون الدولة، وتُعد من أوائل النساء القياديات في تاريخ المغرب.""",
    },
    {
      "image": "assets/cards/كمال_الودغيري.png",
      "name": "كمال الودغيري",
      "info": """كمال الودغيري هو مهندس وعالم فضاء مغربي يعمل في وكالة ناسا.
شارك في العديد من المشاريع الفضائية الناجحة، منها المسبارات إلى المريخ والقمر.
يمثل قدوة للشباب المغاربة في مجال العلوم والتكنولوجيا.""",
    },
    {
      "image": "assets/cards/منصف_السلاوي.png",
      "name": "منصف السلاوي",
      "info": """منصف السلاوي هو عالم مغربي في علم المناعة وطب اللقاحات.
لعب دورًا قياديًا في تطوير لقاحات فيروس كورونا خلال جائحة كوفيد-19 في الولايات المتحدة.
نال احترامًا عالميًا لخبرته وأبحاثه في مجال البيوتكنولوجيا.""",
    },
    {
      "image": "assets/cards/جهاد_الترباني.jpg",
      "name": "جهاد الترباني",
      "info":
          """جهاد الترباني هو كاتب فلسطيني مشهور، يُعرف بكتاباته التاريخية بأسلوب قصصي ممتع.
من أشهر أعماله "100 من عظماء أمة الإسلام غيروا مجرى التاريخ".
يهدف إلى تعريف الشباب بتاريخهم الإسلامي بطريقة جذابة ومبسطة.""",
    },
    {
      "image": "assets/cards/عبد_الكريم_الخطابي.jpg",
      "name": "عبد الكريم الخطابي",
      "info":
          """عبد الكريم الخطابي قائد مغربي قاد المقاومة في الريف ضد الاحتلال الإسباني في العشرينيات.
أسس جمهورية الريف وحقق انتصارات عسكرية هزت أوروبا.
يُعد من رموز المقاومة التحررية في العالم الإسلامي.""",
    },
    {
      "image": "assets/cards/يحيى_السنوار.jpg",
      "name": "يحيى السنوار",
      "info": """يحيى السنوار هو سياسي فلسطيني وقيادي بارز في حركة حماس.
سُجن سنوات طويلة في سجون الاحتلال وأُفرج عنه في صفقة تبادل أسرى.
يُعتبر شخصية مؤثرة في الشأن الفلسطيني والمقاومة ضد الاحتلال.""",
    },
    {
      "image": "assets/cards/عبد_الرحمان_السميط.jpg",
      "name": "عبد الرحمان السميط",
      "info":
          """عبد الرحمان السميط كان طبيبًا وداعية كويتيًا، كرّس حياته للأعمال الخيرية في إفريقيا.
أسس جمعية العون المباشر وأسلم على يديه آلاف الناس.
نُظر إليه كرمز للإنسانية والعمل الإنساني في العالم الإسلامي.""",
    },
    {
      "image": "assets/cards/عبد_الله_البرغوثي.jpg",
      "name": "عبد الله البرغوثي",
      "info":
          """عبد الله البرغوثي هو مهندس فلسطيني ومهندس متفجرات في كتائب القسام.
شارك في عمليات مقاومة ضد الاحتلال الإسرائيلي، ويُعد من رموز الجناح العسكري للمقاومة.
حُكم عليه بعدة مؤبدات في سجون الاحتلال.""",
    },
  ];

  late List<String> allCards = [
    "assets/cards/محمد_عابد_الجابري.png",
    "assets/cards/عسو_اوبسلام.png",
    "assets/cards/رشيد_اليازمي.png",
    "assets/cards/خناثة_بنت_بكار.png",
    "assets/cards/كمال_الودغيري.png",
    "assets/cards/منصف_السلاوي.png",
    "assets/cards/جهاد_الترباني.jpg",
    "assets/cards/عبد_الكريم_الخطابي.jpg",
    "assets/cards/يحيى_السنوار.jpg",
    "assets/cards/عبد_الرحمان_السميط.jpg",
    "assets/cards/عبد_الله_البرغوثي.jpg",
  ];
  late List<String> cards;
  late List<bool> matched;
  late List<GlobalKey<FlipCardState>> cardKeys;
  List<int> selectedIndiceCards = [];
  @override
  void initState() {
    super.initState();
    allCards.shuffle();
    prepareCards();
  }

  void prepareCards() {
    switch (widget.level) {
      case 1:
        pairs = 2;
        break;
      case 2:
        pairs = 3;
        break;
      case 3:
        pairs = 6;
        break;
      case 4:
        pairs = 10;
        break;
      default:
        pairs = 12;
    }
    List<String> selectedCards = allCards.take(pairs).toList();
    cards = [...selectedCards, ...selectedCards];
    cards.shuffle();
    matched = List.filled(cards.length, false);
    cardKeys = List.generate(cards.length, (_) => GlobalKey<FlipCardState>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Niveau ${widget.level}")),
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getOptimalCrossAxisCount(cards.length),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onCardTap(index),
                  child: FlipCard(
                    key: cardKeys[index],
                    flipOnTouch: false,
                    front: Image.asset('assets/logo.jpg'), // dos
                    back: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(cards[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCongratulationsDialog() {
    final imageMatched = cards.first;
    final person = personsInfo.firstWhere(
      (p) => p["image"] == imageMatched,
      orElse: () => {
        'image': "assests/logo.jpg",
        'name': "inconu",
        'info': "no information",
      },
    );
    showDialog(
      context: context,
      barrierDismissible: false, // Oblige à cliquer un bouton
      builder: (context) {
        return AlertDialog(
          title: Text("""🎉 أحسنت
وراء كل صورة حكاية تستحق أن تروى 📖
 !"""),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(person['image']!, height: 100),
              const SizedBox(height: 8),
              Text(
                person['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 100,
                child: SingleChildScrollView(
                  child: Text(
                    person['info']!,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(level: widget.level + 1),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text("Continuer"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                ); // Ferme le dialogue
              },
              child: Text("Quitter"),
            ),
          ],
        );
      },
    );
  }

  int getOptimalCrossAxisCount(int itemCount) {
    if (itemCount <= 4) return 2;
    if (itemCount <= 6) return 3;
    if (itemCount <= 12) return 3;
    if (itemCount <= 16) return 4;
    if (itemCount <= 20) return 4;
    return 5; // Pour les niveaux supérieurs
  }

  Future<void> _onCardTap(int index) async {
    // Si deja des cartes ouvertes, on ne fait rien
    if (selectedIndiceCards.length >= 2) return;
    cardKeys[index].currentState?.toggleCard();
    await Future.delayed(Duration(milliseconds: 300));
    // Puis traite la logique de paire
    await handleMatch(index);
  }

  Future<void> handleMatch(int index) async {
    selectedIndiceCards.add(index);
    if (selectedIndiceCards.length == 2) {
      int first = selectedIndiceCards[0];
      int second = selectedIndiceCards[1];
      if (cards[first] == cards[second]) {
        matched[first] = true;
        matched[second] = true;
        setState(() {});
      } else {
        // Pas une paire on attend 500 ms que l’utilisateur voie les deux faces
        await Future.delayed(Duration(milliseconds: 500));
        // On referme les deux cartes ensemble
        cardKeys[first].currentState?.toggleCard();
        cardKeys[second].currentState?.toggleCard();
        // Attend la fin d’animation
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {});
      }
      selectedIndiceCards.clear();
      // Si fin de jeu
      if (!matched.contains(false)) {
        await Future.delayed(Duration(milliseconds: 300));
        _showCongratulationsDialog();
      }
    }
  }
}
