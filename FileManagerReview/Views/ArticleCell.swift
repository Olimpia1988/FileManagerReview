import UIKit

protocol ArticleCellDelegate: class {
  func imageDataLoaded(with index: IndexPath)
}
class ArticleCell: UITableViewCell {
  
  weak var delegate: ArticleCellDelegate?


  @IBOutlet weak var title: UILabel!
  
  @IBOutlet weak var articleBody: UITextView!
  @IBOutlet weak var articleImage: UIImageView!
  
  
  public func configureCell(_ NYTimesArticle: Article, _ indexPath: IndexPath, completionHandler: @escaping()-> Void) {
    let titleText = NYTimesArticle.title
    let oneParagraph = NYTimesArticle.body.components(separatedBy: "\n")
    let paragraphBody = oneParagraph[0]
    imageSetUp(NYTimesArticle) { [weak self] in
      self?.delegate?.imageDataLoaded(with: indexPath)
    }
    UIUtilities.setupTitleText(title, titleText)
    UIUtilities.setupArticleSumary(articleBody, "• \(paragraphBody)")
    
    
  }
  
  
  
  public func imageSetUp( _ NYTimesArticle: Article, completionHandler: @escaping()-> Void) {
     if let unwrapImage = NYTimesArticle.images {
       let filteredImage = unwrapImage.filter{$0.topImage}
       
       if let image = ImageGetterManager.getImageFromCache(with: filteredImage.first!.url) {
         self.articleImage.image = image
       } else {
         ImageGetterManager.getImage(urlStr: filteredImage.first!.url) { (result) in
           switch result {
           case .failure:
             print(AppError.notAnImage)
           case .success(let imageData):
             self.articleImage.image = imageData
             completionHandler()
           }
         }
       }
     }
   }
  
}
