import UIKit

class ViewController: UIViewController {
  
  var articles = [Article]() {
    didSet {
      DispatchQueue.main.async {
        self.articlesTableView.reloadData()
      }
    }
  }

  @IBOutlet weak var articlesTableView: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadArticles()
    setupDelegation()
  }
  
  
  //MARK: - Private functions
   private func loadArticles() {
  ArticlesAPIManager.getData {[ weak self ] (result) in
       switch result {
       case .success(let data):
         self?.articles = data
       case .failure(let error):
         print("Error loading data: \(error)")
       }
     }
   }
  
  private func setupDelegation() {
     self.articlesTableView.delegate = self
     self.articlesTableView.dataSource = self
   }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = articlesTableView.indexPathForSelectedRow,
      let detailViewController = segue.destination as? DetailedViewController else {
        fatalError("indexPath, detailVC nil")
    }
    let singleArticle = articles[indexPath.row]
    guard let cell = articlesTableView.cellForRow(at: indexPath) as? ArticleCell else { return }
    detailViewController.selectedImage = cell.articleImage.image
    detailViewController.selectedArticle = singleArticle
  }


}

//MARK: - ViewController Extention
extension ViewController : UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    articles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else { return UITableViewCell() }
    let singleArticle = articles[indexPath.row]
    cell.delegate = self
    cell.configureCell(singleArticle, indexPath) {  }
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 450
    
  }
}

extension ViewController: ArticleCellDelegate {
  func imageDataLoaded(with index: IndexPath) {
    articlesTableView.reloadData()
  }
  
 
}


