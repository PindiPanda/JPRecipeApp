import UIKit

class Recipe: NSObject {
    var title: String?
    var content: String?
    
    init (title: String, content: String){
        self.title = title
        self.content = content
    }
    override init (){
        super.init()
    }
}
