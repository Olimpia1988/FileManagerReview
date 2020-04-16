
import UIKit

class DetailedViewController: UIViewController {
  
  var selectedArticle: Article!
  var selectedImage: UIImage?
  
  @IBOutlet weak var selectedTitle: UILabel!
  @IBOutlet weak var selectedArticleBody: UITextView!
  @IBOutlet weak var articleImage: UIImageView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUIObjects()
  }
  
  
  @IBAction func saveArticle(_ sender: Any) {

  
  }

  //MARK: - Private Properties
  private func setupUIObjects() {
    UIUtilities.setupTitleText(selectedTitle, selectedArticle.title)
    UIUtilities.setupBodyText(selectedArticleBody, selectedArticle.body)
    UIUtilities.setupImage(selectedImage, articleImage)
  }

}
