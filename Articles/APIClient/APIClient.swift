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
        body: "科学者たちが前例のない効率を持つ新しい太陽電池技術を開発。"
      ),
      ArticleAPIResponse(
        id: 2,
        title: "市議会、新しい公共公園の設置を承認",
        body: "新しい緑地は都市生活の向上とアウトドア活動の促進を目指す。"
      ),
      ArticleAPIResponse(
        id: 3,
        title: "テックスタートアップが革新的なアプリを発表",
        body: "このアプリは人々の日常タスク管理の方法を変えることを約束。"
      ),
      ArticleAPIResponse(
        id: 4,
        title: "歴史的建造物が修復工事へ",
        body: "ダウンタウンの建築遺産を保存するための資金が確保された。"
      ),
      ArticleAPIResponse(
        id: 5,
        title: "地元の学校が全国科学コンペで優勝",
        body: "生徒たちが革新的な環境プロジェクトで審査員を感動させた。"
      ),
      ArticleAPIResponse(
        id: 6,
        title: "新しい料理トレンドが街を席巻",
        body: "伝統的な味と現代的な技術を融合したフュージョン料理が人気に。"
      ),
      ArticleAPIResponse(
        id: 7,
        title: "スポーツチームがチャンピオンシップタイトルを獲得",
        body: "アンダードッグチームが決勝で驚異的な勝利を祝う。"
      ),
      ArticleAPIResponse(
        id: 8,
        title: "アート展が新進気鋭の才能を紹介",
        body: "ギャラリーで地元の若手アーティストの作品が展示される。"
      ),
      ArticleAPIResponse(
        id: 9,
        title: "交通インフラの改善で通勤が快適に",
        body: "新しい地下鉄路線が移動時間を大幅に短縮すると期待されている。"
      ),
      ArticleAPIResponse(
        id: 10,
        title: "医療イニシアチブが地方地域を対象に",
        body: "移動クリニックがサービスの行き届かない地域に必須の医療を提供。"
      )
    ]
  }
}
