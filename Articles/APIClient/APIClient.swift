//
//  APIClient.swift
//  Articles
//
//  Created by org on 2025/09/07.
//

import Dependencies
import Foundation

struct ArticleAPIResponse: Identifiable, Sendable, Equatable {
  var id: Int
  var title: String
  var body: String
  var backgroundColor: String
}

struct APIClient: Sendable {
  init() {}
  
  var getArticles: @Sendable () async throws -> [ArticleAPIResponse] = {
    await SecondsTimer().wait(seconds: 1)
    return ArticleAPIResponse.sampleList
  }
}

extension APIClient: DependencyKey {
  static let liveValue = APIClient()
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
        body: "科学者たちが前例のない効率を持つ新しい太陽電池技術を開発。",
        backgroundColor: "#FFAA00"
      ),
      ArticleAPIResponse(
        id: 2,
        title: "市議会、新しい公共公園の設置を承認",
        body: "新しい緑地は都市生活の向上とアウトドア活動の促進を目指す。",
        backgroundColor: "#00BFFF"
      ),
      ArticleAPIResponse(
        id: 3,
        title: "テックスタートアップが革新的なアプリを発表",
        body: "このアプリは人々の日常タスク管理の方法を変えることを約束。",
        backgroundColor: "#A020F0"
      ),
      ArticleAPIResponse(
        id: 4,
        title: "歴史的建造物が修復工事へ",
        body: "ダウンタウンの建築遺産を保存するための資金が確保された。",
        backgroundColor: "#32CD32"
      ),
      ArticleAPIResponse(
        id: 5,
        title: "地元の学校が全国科学コンペで優勝",
        body: "生徒たちが革新的な環境プロジェクトで審査員を感動させた。",
        backgroundColor: "#FF6347"
      ),
      ArticleAPIResponse(
        id: 6,
        title: "新しい料理トレンドが街を席巻",
        body: "伝統的な味と現代的な技術を融合したフュージョン料理が人気に。",
        backgroundColor: "#FFD700"
      ),
      ArticleAPIResponse(
        id: 7,
        title: "スポーツチームがチャンピオンシップタイトルを獲得",
        body: "アンダードッグチームが決勝で驚異的な勝利を祝う。",
        backgroundColor: "#40E0D0"
      ),
      ArticleAPIResponse(
        id: 8,
        title: "アート展が新進気鋭の才能を紹介",
        body: "ギャラリーで地元の若手アーティストの作品が展示される。",
        backgroundColor: "#8A2BE2"
      ),
      ArticleAPIResponse(
        id: 9,
        title: "交通インフラの改善で通勤が快適に",
        body: "新しい地下鉄路線が移動時間を大幅に短縮すると期待されている。",
        backgroundColor: "#DC143C"
      ),
      ArticleAPIResponse(
        id: 10,
        title: "医療イニシアチブが地方地域を対象に",
        body: "移動クリニックがサービスの行き届かない地域に必須の医療を提供。",
        backgroundColor: "#228B22"
      ),
      ArticleAPIResponse(
        id: 11,
        title: "地元企業がリサイクルプログラムを開始",
        body: "持続可能な社会を目指し、企業が新たな取り組みを発表。",
        backgroundColor: "#FF69B4"
      ),
      ArticleAPIResponse(
        id: 12,
        title: "宇宙望遠鏡が新たな惑星を発見",
        body: "科学者たちが地球に似た環境を持つ惑星を観測。",
        backgroundColor: "#6495ED"
      ),
      ArticleAPIResponse(
        id: 13,
        title: "伝統祭りが盛大に開催される",
        body: "地域住民が文化遺産を祝うイベントに参加。",
        backgroundColor: "#FFA500"
      ),
      ArticleAPIResponse(
        id: 14,
        title: "AI技術が農業分野に革新をもたらす",
        body: "スマート農業による収穫量の大幅増加が期待されている。",
        backgroundColor: "#00FF7F"
      ),
      ArticleAPIResponse(
        id: 15,
        title: "新作映画が国際映画祭で受賞",
        body: "監督とキャストがレッドカーペットで祝福を受ける。",
        backgroundColor: "#9932CC"
      ),
      ArticleAPIResponse(
        id: 16,
        title: "オンライン教育プラットフォームが拡大",
        body: "多様なコースが世界中の学習者に提供される。",
        backgroundColor: "#3CB371"
      ),
      ArticleAPIResponse(
        id: 17,
        title: "新型電気自動車が発表される",
        body: "環境負荷の少ない次世代モビリティが話題に。",
        backgroundColor: "#FF4500"
      ),
      ArticleAPIResponse(
        id: 18,
        title: "動物保護団体が里親募集キャンペーン",
        body: "多くの動物たちが新しい家族を待っている。",
        backgroundColor: "#1E90FF"
      ),
      ArticleAPIResponse(
        id: 19,
        title: "地元アスリートが国際大会で活躍",
        body: "金メダルを獲得し、地域に誇りをもたらした。",
        backgroundColor: "#FFD700"
      ),
      ArticleAPIResponse(
        id: 20,
        title: "新しい図書館がオープン",
        body: "市民の知的好奇心を刺激する最新設備が整う。",
        backgroundColor: "#20B2AA"
      ),
      ArticleAPIResponse(
        id: 21,
        title: "環境保護プロジェクトが始動",
        body: "地域の自然環境を守るための新たな取り組みが開始。",
        backgroundColor: "#FF8C00"
      ),
      ArticleAPIResponse(
        id: 22,
        title: "最新の健康研究が発表される",
        body: "食生活と長寿に関する新たな知見が明らかに。",
        backgroundColor: "#00CED1"
      ),
      ArticleAPIResponse(
        id: 23,
        title: "若手起業家が革新的なビジネスを展開",
        body: "地域経済に新たな風を吹き込むスタートアップが登場。",
        backgroundColor: "#C71585"
      ),
      ArticleAPIResponse(
        id: 24,
        title: "デジタルアートの人気が急上昇",
        body: "NFTやオンラインギャラリーがアーティストを支援。",
        backgroundColor: "#FFA07A"
      ),
      ArticleAPIResponse(
        id: 25,
        title: "歴史的な発見が考古学者によって報告",
        body: "古代文明の遺物が発掘され、研究が進む。",
        backgroundColor: "#00FA9A"
      ),
      ArticleAPIResponse(
        id: 26,
        title: "新たな交通手段が都市に導入",
        body: "電動スクーターやシェアバイクが市民の移動をサポート。",
        backgroundColor: "#B22222"
      ),
      ArticleAPIResponse(
        id: 27,
        title: "子ども向け科学ワークショップが開催",
        body: "未来の科学者を育てる体験型イベントが人気。",
        backgroundColor: "#4682B4"
      ),
      ArticleAPIResponse(
        id: 28,
        title: "地域音楽フェスティバルが盛況",
        body: "多様なジャンルのアーティストがステージを盛り上げる。",
        backgroundColor: "#DAA520"
      ),
      ArticleAPIResponse(
        id: 29,
        title: "新しいスマートホームデバイスが登場",
        body: "生活を便利にする最新IoT技術が注目を集める。",
        backgroundColor: "#00FF00"
      ),
      ArticleAPIResponse(
        id: 30,
        title: "国際交流イベントで多文化を体験",
        body: "参加者が異文化理解を深めるワークショップを実施。",
        backgroundColor: "#4169E1"
      )
    ]
  }
}
