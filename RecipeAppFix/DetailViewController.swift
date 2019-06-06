import UIKit

class DetailViewController: UIViewController {
    
    var preRecipe: Recipe?
    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var recipeContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeContent.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.title = "Recipe Details"
        self.recipeTitle.text = preRecipe?.title
        self.recipeContent.isScrollEnabled = false
        self.recipeContent.text = preRecipe?.content
    }
    override func viewDidAppear(_ animated: Bool) {
        self.recipeContent.isScrollEnabled = true
    }
}
