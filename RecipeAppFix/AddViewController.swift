import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet var titleText: UITextField!
    @IBOutlet var recipeContent: UITextView!
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        recipeContent.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        addButton.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.textTitleDidChange), name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.recipeContentDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc func textTitleDidChange(){
        handleAddButtonState()
    }
    
    @objc func recipeContentDidChange(){
        if(recipeContent.text != ""){
            doneButton.isEnabled = true
        }else{
            doneButton.isEnabled = false
        }
        handleAddButtonState()
    }
    
    @IBAction func doneButton_click(_ sender: Any) {
        recipeContent.resignFirstResponder()
        doneButton.isEnabled = false
    }
    
    @IBAction func titleDoneButton_click(_ sender: Any) {
        titleText.resignFirstResponder()
    }
    
    func handleAddButtonState(){
        if(titleText.text != "" && recipeContent.text != ""){
            addButton.isEnabled = true
            addButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        } else {
            addButton.isEnabled = false
            addButton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        }
    }
    
    @IBAction func addButton_click(_ sender: Any) {
        activityIndicator.startAnimating()
        
        RecipeManager.AddRecipe(title: titleText.text!, content: recipeContent.text!)
        titleText.text = ""
        recipeContent.text = ""
        
        let time = DispatchTime.now() + DispatchTimeInterval.milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.activityIndicator.stopAnimating()
        }
        addButton.isEnabled = false
        addButton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
    }
}
