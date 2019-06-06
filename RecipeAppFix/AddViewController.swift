import UIKit

class AddViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var titleText: UITextField!
    @IBOutlet var recipeContent: UITextView!
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //titleText.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        recipeContent.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        addButton.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.textTitleDidChange), name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.recipeContentDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (recipeContent.text == "Instructions"){
            recipeContent.text = ""
        }
    }
    
    @objc func textTitleDidChange(){
        handleAddButtonState()
    }
    
    @objc func recipeContentDidChange(){
        handleAddButtonState()
    }
    
    @IBAction func doneButton_click(_ sender: Any) {
        titleText.resignFirstResponder()
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
        if(titleText.text != "" || recipeContent.text != ""){
            doneButton.isEnabled = true
        }
    }
    
    @IBAction func addButton_click(_ sender: Any) {
        activityIndicator.startAnimating()
        
        RecipeManager.AddRecipe(title: titleText.text!, content: recipeContent.text!)
        
        let time = DispatchTime.now() + DispatchTimeInterval.milliseconds(500)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.activityIndicator.stopAnimating()
        }
        UserDefaultsManager.synchronize()
        self.navigationController?.popViewController(animated: true)
    }
}
