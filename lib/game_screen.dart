/*import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<String> allCards;
  late List<String> cards;
  late List<bool> matched;
  late List<GlobalKey<FlipCardState>> cardKeys;
  List<int> selectedIndiceCards = [];

  @override
  void initState() {
    super.initState();
    print("INITSTATE DEMARRE");
    allCards = [
      "assets/cards/abdo_allah_albrroti.jpg",
      "assets/cards/abdelkrim_elkhatabi.jpg",
      "assets/cards/yahya_sinouar.jpg",
    ];
    allCards.shuffle();
    List<String> selectedCards = allCards.take(3).toList();
    cards = [...selectedCards, ...selectedCards];
    cards.shuffle();
    matched = List.filled(cards.length, false);
    cardKeys = List.generate(cards.length, (_) => GlobalKey<FlipCardState>());
    print("cardKeys.length = ${cardKeys.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("know&Match")),
      backgroundColor: Colors.grey,
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return FlipCard(
            key: cardKeys[index],
            flipOnTouch: !matched[index],
            direction: FlipDirection.HORIZONTAL,
            onFlip: () => handleFlip(index),
            back: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(cards[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            front: Image.asset('assets/logo.jpg'),
          );
        },
      ),
    );
  }

  Future<void> handleFlip(int index) async {
    selectedIndiceCards.add(index);
    if (selectedIndiceCards.length == 2) {
      int first = selectedIndiceCards[0];
      int second = selectedIndiceCards[1];
      if (cards[first] == cards[second]) {
        matched[first] = true;
        matched[second] = true;
      } else {
        await Future.delayed(Duration(seconds: 1));
        cardKeys[first].currentState?.toggleCard();
        cardKeys[second].currentState?.toggleCard();
      }
      selectedIndiceCards.clear();
      setState(() {});
    }
    if (matched.every((m) => m)) {
      await Future.delayed(
        Duration(milliseconds: 300),
      ); // Petite pause avant la popup
      _showCongratulationsDialog();
    }
  }
  void _showCongratulationsDialog(){
 showDialog(
    context: context,
    barrierDismissible: false, // Oblige à cliquer un bouton
    builder: (context) {
      return AlertDialog(
        title: Text("🎉 Félicitations !"),
        content: Text("Vous avez trouvé toutes les paires.\nVoulez-vous passer au niveau suivant ?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Ferme le dialogue
             GameScreen();      // Passe au niveau suivant
            },
            child: Text("Continuer"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Ferme le dialogue
            },
            child: Text("Quitter"),
          ),
        ],
      );
    },
  );
}
}
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

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
  int currentPersonIndex = 0;
  Timer? _timer;
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
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {
       currentPersonIndex = (currentPersonIndex + 1) % personsInfo.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void prepareCards() {
    int pairs = 1 + widget.level;
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
          Expanded(flex: 3,
            child:  GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              ((widget.level + 1) % 4 == 0 || (widget.level + 1) == 2)
              ? widget.level + 1
              : (widget.level + 1) % 5 == 0
              ? 5
              : 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return FlipCard(
            key: cardKeys[index],
            flipOnTouch: !matched[index],
            direction: FlipDirection.HORIZONTAL,
            onFlip: () => handleFlip(index),
            back: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(cards[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            front: Image.asset('assets/logo.jpg'),
          );
        },
      ),),
      Expanded(flex: 1,
        child: buildPersonInfo())
        ],
      )
     
    );
  }

  Future<void> handleFlip(int index) async {
    selectedIndiceCards.add(index);
    if (selectedIndiceCards.length == 2) {
      int first = selectedIndiceCards[0];
      int second = selectedIndiceCards[1];
      if (cards[first] == cards[second]) {
        matched[first] = true;
        matched[second] = true;
      } else {
        await Future.delayed(Duration(seconds: 1));
        cardKeys[first].currentState?.toggleCard();
        cardKeys[second].currentState?.toggleCard();
      }
      selectedIndiceCards.clear();
      setState(() {});
    }
    if (!matched.contains(false)) {
      await Future.delayed(
        Duration(milliseconds: 300),
      ); // Petite pause avant la popup
      _showCongratulationsDialog();
    }
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Oblige à cliquer un bouton
      builder: (context) {
        return AlertDialog(
          title: Text("🎉 Félicitations !"),
          content: Text(
            "Vous avez trouvé toutes les paires.\nVoulez-vous passer au niveau suivant ?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                //Navigator.pop(context); // Ferme le dialogue
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(level: widget.level + 1),
                  ),
                ); // Passe au niveau suivant
              },
              child: Text("Continuer"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Ferme le dialogue
              },
              child: Text("Quitter"),
            ),
          ],
        );
      },
    );
  }

  Widget buildPersonInfo() {
    final person = personsInfo[currentPersonIndex];
    return Container(
      width: 200,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.shade400)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(person['image']!, height: 100),
          ),
          const SizedBox(height: 10),
          Text(
            person['name']!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 6),
          Text(
            person['info']!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
