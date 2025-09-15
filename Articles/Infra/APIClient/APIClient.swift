//
//  APIClient.swift
//  Articles
//
//  Created by org on 2025/09/07.
//

import Dependencies
import Foundation

struct ArticlesListAPIResponse {
  var articles: [ArticleAPIResponse]
  var nextPage: Int?
}

struct ArticleAPIResponse: Identifiable, Sendable, Equatable {
  var id: Int
  var title: String
  var body: String
  var backgroundColor: String
  var tags: [String]
}

enum GetArticleDetailError: Error {
  case notFound
}

struct APIClient: Sendable {
  init() {}
  
  var getArticlesWithPage: @Sendable (Int?) async throws -> ArticlesListAPIResponse = { page in
    await SecondsTimer().wait(seconds: 1)
    let page = page ?? 0
    let pageSplited = ArticleAPIResponse.sampleList.split(subSize: 10)
    guard pageSplited.count >= page else { return .init(articles: [], nextPage: nil) }
    let nextPage = page + 1 < pageSplited.count ? page + 1 : nil
    return .init(articles: pageSplited[page], nextPage: nextPage)
  }
  
  var getArticleWithId: @Sendable (Int) async throws -> ArticleAPIResponse = { id in
    await SecondsTimer().wait(seconds: 1)
    guard let article = ArticleAPIResponse.sampleList.first(where: { $0.id == id }) else { throw GetArticleDetailError.notFound }
    return article
  }
}

extension APIClient: DependencyKey {
  static let liveValue = APIClient()
  
  static var testValue: APIClient { liveValue }
}

extension DependencyValues {
  var apiClient: APIClient {
    get { self[APIClient.self] }
    set { self[APIClient.self] = newValue }
  }
}

private extension ArticleAPIResponse {
  static var sampleList: [ArticleAPIResponse] {
    [
      ArticleAPIResponse(
        id: 1,
        title: "再生可能エネルギーで画期的な進展を達成",
        body: """
        科学者たちが前例のない効率を持つ新しい太陽電池技術を開発。
        この進歩によりエネルギー供給の持続可能性が大きく向上する。
        専門家は今後10年で実用化が進むと予測している。
        """,
        backgroundColor: "#FFAA00",
        tags: ["環境", "科学"]
      ),
      ArticleAPIResponse(
        id: 2,
        title: "市議会、新しい公共公園の設置を承認",
        body: """
        新しい緑地は都市生活の向上とアウトドア活動の促進を目指す。
        地元住民からの要望を受けて計画が進められた。
        公園内には遊歩道や子ども向けの遊具も設置される予定だ。
        """,
        backgroundColor: "#00BFFF",
        tags: ["地域社会", "環境"]
      ),
      ArticleAPIResponse(
        id: 3,
        title: "テックスタートアップが革新的なアプリを発表",
        body: """
        このアプリは人々の日常タスク管理の方法を変えることを約束。
        AI技術を活用し、ユーザーの習慣に合わせた提案を行う。
        既にベータ版で多くのユーザーから高評価を得ている。
        """,
        backgroundColor: "#A020F0",
        tags: ["テクノロジー", "ビジネス"]
      ),
      ArticleAPIResponse(
        id: 4,
        title: "歴史的建造物が修復工事へ",
        body: """
        ダウンタウンの建築遺産を保存するための資金が確保された。
        修復は来月から開始され、数年かけて完了する見込みだ。
        地元の歴史愛好家たちもプロジェクトに期待を寄せている。
        """,
        backgroundColor: "#32CD32",
        tags: ["文化・芸術", "地域社会"]
      ),
      ArticleAPIResponse(
        id: 5,
        title: "地元の学校が全国科学コンペで優勝",
        body: """
        生徒たちが革新的な環境プロジェクトで審査員を感動させた。
        チームワークと創造性が評価され、賞金も獲得した。
        今後は国際大会への出場も視野に入れている。
        """,
        backgroundColor: "#FF6347",
        tags: ["教育", "科学"]
      ),
      ArticleAPIResponse(
        id: 6,
        title: "新しい料理トレンドが街を席巻",
        body: """
        伝統的な味と現代的な技術を融合したフュージョン料理が人気に。
        多くのレストランが独自のメニューを開発し話題を呼んでいる。
        食文化の多様性がさらに広がることが期待されている。
        """,
        backgroundColor: "#FFD700",
        tags: ["ライフスタイル", "文化・芸術"]
      ),
      ArticleAPIResponse(
        id: 7,
        title: "スポーツチームがチャンピオンシップタイトルを獲得",
        body: """
        アンダードッグチームが決勝で驚異的な勝利を祝う。
        選手たちの努力と戦術が成功の鍵となった。
        ファンは街中で歓喜の声をあげている。
        """,
        backgroundColor: "#40E0D0",
        tags: ["スポーツ", "地域社会"]
      ),
      ArticleAPIResponse(
        id: 8,
        title: "アート展が新進気鋭の才能を紹介",
        body: """
        ギャラリーで地元の若手アーティストの作品が展示される。
        展示は来月末まで開催され、多くの来場者が見込まれている。
        芸術コミュニティの活性化に寄与すると期待されている。
        """,
        backgroundColor: "#8A2BE2",
        tags: ["文化・芸術"]
      ),
      ArticleAPIResponse(
        id: 9,
        title: "交通インフラの改善で通勤が快適に",
        body: """
        新しい地下鉄路線が移動時間を大幅に短縮すると期待されている。
        利便性向上により地域経済の活性化も見込まれている。
        住民からは安全性の向上も歓迎されている。
        """,
        backgroundColor: "#DC143C",
        tags: ["地域社会", "ビジネス"]
      ),
      ArticleAPIResponse(
        id: 10,
        title: "医療イニシアチブが地方地域を対象に",
        body: """
        移動クリニックがサービスの行き届かない地域に必須の医療を提供。
        地域住民の健康改善に大きく貢献すると期待されている。
        今後は診療内容の拡充も検討されている。
        """,
        backgroundColor: "#228B22",
        tags: ["ヘルスケア", "地域社会"]
      ),
      ArticleAPIResponse(
        id: 11,
        title: "地元企業がリサイクルプログラムを開始",
        body: """
        持続可能な社会を目指し、企業が新たな取り組みを発表。
        市民も参加しやすい回収ポイントを設置している。
        環境負荷の軽減に向けた意識向上が期待されている。
        """,
        backgroundColor: "#FF69B4",
        tags: ["環境", "ビジネス"]
      ),
      ArticleAPIResponse(
        id: 12,
        title: "宇宙望遠鏡が新たな惑星を発見",
        body: """
        科学者たちが地球に似た環境を持つ惑星を観測。
        生命存在の可能性について研究が進められている。
        今後の観測計画に注目が集まっている。
        """,
        backgroundColor: "#6495ED",
        tags: ["科学", "テクノロジー"]
      ),
      ArticleAPIResponse(
        id: 13,
        title: "伝統祭りが盛大に開催される",
        body: """
        地域住民が文化遺産を祝うイベントに参加。
        多彩なパフォーマンスや屋台が訪れた人々を楽しませた。
        来年もさらに盛大な開催が計画されている。
        """,
        backgroundColor: "#FFA500",
        tags: ["文化・芸術", "地域社会"]
      ),
      ArticleAPIResponse(
        id: 14,
        title: "AI技術が農業分野に革新をもたらす",
        body: """
        スマート農業による収穫量の大幅増加が期待されている。
        センサーとデータ解析で作物の健康状態を最適化。
        農家の労働負担も軽減される見込みだ。
        """,
        backgroundColor: "#00FF7F",
        tags: ["テクノロジー", "環境", "ビジネス"]
      ),
      ArticleAPIResponse(
        id: 15,
        title: "新作映画が国際映画祭で受賞",
        body: """
        監督とキャストがレッドカーペットで祝福を受ける。
        映画は社会問題を鋭く描き、多くの共感を呼んだ。
        国内外での公開が待ち望まれている。
        """,
        backgroundColor: "#9932CC",
        tags: ["文化・芸術", "ライフスタイル"]
      ),
      ArticleAPIResponse(
        id: 16,
        title: "オンライン教育プラットフォームが拡大",
        body: """
        多様なコースが世界中の学習者に提供される。
        インタラクティブな教材で学習効果が高まっている。
        今後はAIを活用した個別指導も導入予定だ。
        """,
        backgroundColor: "#3CB371",
        tags: ["教育", "テクノロジー"]
      ),
      ArticleAPIResponse(
        id: 17,
        title: "新型電気自動車が発表される",
        body: """
        環境負荷の少ない次世代モビリティが話題に。
        高性能バッテリーと先進的なデザインが特徴だ。
        市場投入は来年春を予定している。
        """,
        backgroundColor: "#FF4500",
        tags: ["テクノロジー", "環境"]
      ),
      ArticleAPIResponse(
        id: 18,
        title: "動物保護団体が里親募集キャンペーン",
        body: """
        多くの動物たちが新しい家族を待っている。
        イベントでは飼育方法の講習会も開催された。
        地域の関心が高まり、多数の応募が寄せられている。
        """,
        backgroundColor: "#1E90FF",
        tags: ["地域社会", "ライフスタイル"]
      ),
      ArticleAPIResponse(
        id: 19,
        title: "地元アスリートが国際大会で活躍",
        body: """
        金メダルを獲得し、地域に誇りをもたらした。
        日々の努力とチームの支援が結果につながった。
        今後の競技生活にも期待が高まっている。
        """,
        backgroundColor: "#FFD700",
        tags: ["スポーツ", "地域社会"]
      ),
      ArticleAPIResponse(
        id: 20,
        title: "新しい図書館がオープン",
        body: """
        市民の知的好奇心を刺激する最新設備が整う。
        デジタル資料や多目的スペースも充実している。
        地域の学習拠点として活用が期待されている。
        """,
        backgroundColor: "#20B2AA",
        tags: ["教育", "地域社会"]
      ),
      ArticleAPIResponse(
        id: 21,
        title: "環境保護プロジェクトが始動",
        body: """
        地域の自然環境を守るための新たな取り組みが開始。
        住民参加型の清掃活動や植樹イベントも計画中だ。
        持続可能な地域づくりに向けて注目されている。
        """,
        backgroundColor: "#FF8C00",
        tags: ["環境", "地域社会"]
      ),
      ArticleAPIResponse(
        id: 22,
        title: "最新の健康研究が発表される",
        body: """
        食生活と長寿に関する新たな知見が明らかに。
        バランスの取れた栄養摂取が重要と強調されている。
        研究成果は今後の健康指導に活用される予定だ。
        """,
        backgroundColor: "#00CED1",
        tags: ["ヘルスケア", "科学"]
      ),
      ArticleAPIResponse(
        id: 23,
        title: "若手起業家が革新的なビジネスを展開",
        body: """
        地域経済に新たな風を吹き込むスタートアップが登場。
        テクノロジーを駆使したサービスで注目を集めている。
        投資家からの関心も高まり、成長が期待されている。
        """,
        backgroundColor: "#C71585",
        tags: ["ビジネス", "テクノロジー"]
      ),
      ArticleAPIResponse(
        id: 24,
        title: "デジタルアートの人気が急上昇",
        body: """
        NFTやオンラインギャラリーがアーティストを支援。
        新しい収益モデルとして注目を浴びている。
        若手クリエイターの活躍も加速している。
        """,
        backgroundColor: "#FFA07A",
        tags: ["文化・芸術", "ビジネス"]
      ),
      ArticleAPIResponse(
        id: 25,
        title: "歴史的な発見が考古学者によって報告",
        body: """
        古代文明の遺物が発掘され、研究が進む。
        発見は地域の歴史理解を深める重要な手がかりとなった。
        今後の調査にも期待が寄せられている。
        """,
        backgroundColor: "#00FA9A",
        tags: ["文化・芸術", "科学"]
      ),
      ArticleAPIResponse(
        id: 26,
        title: "新たな交通手段が都市に導入",
        body: """
        電動スクーターやシェアバイクが市民の移動をサポート。
        環境に優しい移動手段として注目されている。
        利用者の安全対策も強化されている。
        """,
        backgroundColor: "#B22222",
        tags: ["環境", "ライフスタイル"]
      ),
      ArticleAPIResponse(
        id: 27,
        title: "子ども向け科学ワークショップが開催",
        body: """
        未来の科学者を育てる体験型イベントが人気。
        実験や観察を通じて科学への興味を引き出す。
        参加者からは高い満足度の声が上がっている。
        """,
        backgroundColor: "#4682B4",
        tags: ["教育", "科学"]
      ),
      ArticleAPIResponse(
        id: 28,
        title: "地域音楽フェスティバルが盛況",
        body: """
        多様なジャンルのアーティストがステージを盛り上げる。
        地元の若手バンドも多数出演し注目を集めた。
        来年の開催も期待されている。
        """,
        backgroundColor: "#DAA520",
        tags: ["文化・芸術", "地域社会"]
      ),
      ArticleAPIResponse(
        id: 29,
        title: "新しいスマートホームデバイスが登場",
        body: """
        生活を便利にする最新IoT技術が注目を集める。
        音声操作や自動化機能が充実している。
        消費者のライフスタイルを大きく変える可能性がある。
        """,
        backgroundColor: "#00FF00",
        tags: ["テクノロジー", "ライフスタイル"]
      ),
      ArticleAPIResponse(
        id: 30,
        title: "国際交流イベントで多文化を体験",
        body: """
        参加者が異文化理解を深めるワークショップを実施。
        伝統料理や踊りの紹介も行われ、盛況となった。
        地域の国際化推進に寄与するイベントと評価されている。
        """,
        backgroundColor: "#4169E1",
        tags: ["文化・芸術", "地域社会"]
      )
    ]
  }
}

extension Array {
  func split(subSize: Int) -> [[Element]] {
    stride(from: 0, to: count, by: subSize).map {
      Array(self[$0..<Swift.min($0 + subSize, count)])
    }
  }
}
