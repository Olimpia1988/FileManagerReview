import UIKit

class SavedArticlesViewController: UIViewController {
  
  @IBOutlet weak var savedArticleTV: UITableView!
  
  var favorites = [Article]() {
    didSet {
      savedArticleTV.reloadData()
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
  override func viewWillAppear(_ animated: Bool) {
  }

  func configTableView() {
    savedArticleTV.delegate = self
    savedArticleTV.dataSource = self
  }
   
}

extension SavedArticlesViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let currentArticle = favorites[indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedArticle", for: indexPath) as? SavedArticleCell else { return UITableViewCell() }
    cell.body.text = currentArticle.body
    cell.title.text = currentArticle.title
    return cell 
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 450
  }
  
}
