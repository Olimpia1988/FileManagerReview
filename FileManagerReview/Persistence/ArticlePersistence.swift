import Foundation

struct ArticlePersistenceHelper {
  static let manager = ArticlePersistenceHelper()
 // private
  let persistenceHelper = PersistenceHelper<Article>(fileName: "article.plist")
  
  func saveArticle(article: Article) throws {
    try persistenceHelper.save(newElement: article)
  }
  
  func getArticle() throws -> [Article] {
    return try persistenceHelper.getObjects()
  }
  
  private init() {}
}
