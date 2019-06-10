import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var preRecipe: Recipe?
    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var recipeContent: UITextView!
    @IBOutlet var textViewHC: NSLayoutConstraint!
    @IBOutlet var bgImageView: UIImageView!
    
    @IBAction func importImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true){
        }
    }
    
    @objc(imagePickerController:didFinishPickingMediaWithInfo:) func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            let imageData:NSData = image.pngData()! as NSData
            self.bgImageView.image = UIImage(data: imageData as Data)
            preRecipe?.addImageData(newImageData: imageData)
            UserDefaultsManager.synchronize()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        recipeContent.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        if let imageData = preRecipe?.bkImageData{
            self.bgImageView.image = UIImage(data: imageData as Data)
        }
        self.recipeTitle.text = preRecipe?.title
        self.recipeContent.isScrollEnabled = false
        self.recipeContent.text = preRecipe?.content
        textViewHC.constant = self.recipeContent.contentSize.height
    }
    override func viewDidAppear(_ animated: Bool) {
        self.recipeContent.isScrollEnabled = true
        if self.recipeContent.contentSize.height <= self.recipeContent.frame.height + 1 {
            self.recipeContent.isScrollEnabled = false
        }
    }
}
