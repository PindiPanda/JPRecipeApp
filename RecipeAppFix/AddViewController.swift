import UIKit

class AddViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var titleText: UITextField!
    @IBOutlet var recipeContent: UITextView!
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var txtConst: NSLayoutConstraint!
    var initTxtConst: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //titleText.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        recipeContent.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        addButton.isEnabled = false
        
        initTxtConst = txtConst.constant
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.textTitleDidChange), name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.recipeContentDidChange), name: UITextView.textDidChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    @objc func keyboardWillShow(aNotification:NSNotification) {
        if let keyboardFrame: NSValue = aNotification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let botSafeArea = view.safeAreaInsets.bottom
            let keyboardHeight = keyboardFrame.cgRectValue.height
            txtConst.constant =  initTxtConst + keyboardHeight - (botSafeArea + 10 + 75)
        }
    }
    
    @objc func keyboardWillBeHidden(aNotification:NSNotification) {
        txtConst.constant = initTxtConst
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
            self.navigationController?.popViewController(animated: true)
        }
    }
}
