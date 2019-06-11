import UIKit

class ScrollViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var preRecipe: Recipe?
    var imagePicker: UIImagePickerController!
    
    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var sqImageView: UIImageView!
    @IBOutlet var recipeContent: UITextView!
    
    
    @IBAction func importImage(_ sender: Any) {
        self.present(imagePicker, animated: true){
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            let imageData:NSData = image.jpegData(compressionQuality: 0.25)! as NSData
            self.sqImageView.image = UIImage(data: imageData as Data)
            preRecipe?.addImageData(newImageData: imageData)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary

        recipeContent.backgroundColor = UIColor.black.withAlphaComponent(0)
        
        if let imageData = preRecipe?.bkImageData{
            self.sqImageView.image = UIImage(data: imageData as Data)
        }
        
        self.recipeTitle.text = preRecipe?.title
        self.recipeContent.isScrollEnabled = false
        self.recipeContent.text = preRecipe?.content
    }
}
