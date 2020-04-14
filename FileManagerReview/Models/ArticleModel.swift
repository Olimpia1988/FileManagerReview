import Foundation

struct Article: Codable {
  var title: String
  var images: [ArticleImages]?
  var body: String
  
  static func getArticles(from jsonData: Data) -> [Article] {
    do {
      let articles = try JSONDecoder().decode([Article].self, from: jsonData)
      return articles
    } catch {
      dump(error)
      return []
    }
  }
}

struct ArticleImages: Codable {
  var topImage: Bool
  var url: String
  var width: Int
  var height: Int
  
  private enum CodingKeys : String, CodingKey {
    case topImage = "top_image"
    case url, width, height
  }
}
