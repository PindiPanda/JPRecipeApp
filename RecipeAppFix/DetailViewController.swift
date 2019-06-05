import UIKit

class DetailViewController: UIViewController {
    
    var preRecipe: Recipe?
    @IBOutlet var recipeContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeContent.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.title = preRecipe?.title!
        self.recipeContent.text = preRecipe?.content
    }
}
