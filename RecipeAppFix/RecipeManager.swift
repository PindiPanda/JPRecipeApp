import UIKit

class RecipeManager: NSObject {
    static var recipes = [Recipe]()
    
    class func AddRecipe(title: String, content: String){
        let r = Recipe(title: title, content: content)
        recipes.append(r)
    }
    
    class func DeleteRecipe(id: Int){
        recipes.remove(at: id)
    }
    class func GetRecipe(id: Int) -> Recipe {
        if(recipes.count > 0){
            return recipes[id]
        }
        return Recipe()
    }
}
