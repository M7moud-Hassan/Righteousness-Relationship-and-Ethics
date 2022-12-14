abstract class PlaylistRepository {
  Future<List<Map<String, String>>> fetchInitialPlaylist();
  Future<Map<String, String>> fetchAnotherSong();
}

class DemoPlaylist extends PlaylistRepository {
  //List<Map<String,String>> list=[];
  //int index=0;
  List<String> list=[
    'معنى لا يموتن أحدكم إلا وهو يحسن الظن بالله',
    'ما المقصود بالسجود في حديث ما من عبد يسجد لله سجدة إلا رفعه بها درجة وحط بها عنه خطيئة',
    'شرح حديث لئن يمشي أحدكم في حاجة أخيه خير له من أن يعتكف في مسجدي هذا',
    'معنى حديث ما من مسلم يرد عن عرض أخيه',
    'معنى النمص',
    'شرح حديث نعمتان مغبون فيمها',
    'إذا سن الإنسان سنة سيئة ثم تاب هل يلحقه إثم من عمل بها؟',
    'شرح حديثكلكم تدخلون الجنة إلا من أبى',
    'معنى حديث إنما الصبر عند الصدمة الأولى',
    'شرح حديث فكم أجعل لك من صلاتي',
    'شرح حديث إذا مات ابن آدم انقطع عمله إلا من ثلاث...',
    'معنى الصدقة الجارية والعلم الذي ينتفع به للميت',
    'حديث لا تسرفوا بالماء ولو كنتم على نهر جار',
    'معنى قول الرسول ليس منا من فعل كذا',
    'النهى عن إتباع النظر عند انقضاض الكوكب',
    'شرح حديثأنصر أخاك ظالماً أو مظلوماً ',
    'شرح حديث الدنيا ملعونة ملعون من فيها إلا',
    'شرح حديث لا يدخل الجنة نمام',
    'ما معنى الحديث إذا مات ابن آدم انقطع عمله إلا من ثلاث.... الخ الحديث ؟',
    'معنى حديث أيما امرأة خرجت بزينتها لعنتها الملائكة حتى ترجع',
    'ما معنى الحديث من ظلم قيد شبرٍ طوقه من سبع أرضين؟',
    'شرح قول النبي صلى الله عليه وسلم لا جلب ولا جنب',
    'شرح حديث الدين النصيحة',
    'معنى حديث لا يدخل بيتك إلا مؤمن، ولا يأكل طعامك إلا تقي',
    'شرح حديث أيما جسم نبت من الحرام فالنار أولى به',
    'معنى جنان البيوت',
    'شرح حديثآية المنافق ثلاث...',
    'شرح حديث إن الله تجاوز عن أمتي ما حدثت به أنفسها ما لم تعمل أو تتكلم',
    'معنى حديث من ستر مسلما ستره الله...',
    'معنى حديث من خاف أدلج',
    'شرح حديثنعمتان مغبون..',
    'شرح حديثمن جر ثوبه خيلاء',
    'شرح حديث. احفظ الله يحفظك',
    'معنى حديث يا ابن آدم لو بلغت ذنوبك عنان السماء ثم استغفرتني غفرت لك ولا أبالي',
    'شرح حديث لا هجرة بعد الفتح',
    'معنى حديث إذا مات ابن آدم انقطع عمله إلا من ثلاث... وحكم وصول ثواب القراءة للميت',
    'شرح حديث خلقت المرأة من ضلع أعوج',
    'ما معنى من سن سنة حسنة',
    'ما معنى قول الرسول إن الرجل ليتكلم بالكلمة...الحديث'
  ];
  @override
  Future<List<Map<String, String>>> fetchInitialPlaylist() async {
    return List.generate(39,(index) => _nextSong(index));
  }

  @override
  Future<Map<String, String>> fetchAnotherSong() async {
    return _nextSong(_songIndex);
  }


  var _songIndex = 0;
  Map<String, String> _nextSong(index) {
    _songIndex = (_songIndex % 39) + 1;
    return {
      'id': index.toString(),
      'title':list[index],
      'album': 'البروالصلة والآداب',
      'url':
      Uri.parse('asset:///assets/play/item${index+1}.mp3').toString(),
    };
  }
}
