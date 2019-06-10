//
//  UserDefaultsManager.swift
//  RecipeAppFix
//
//  Created by John Parker on 6/5/19.
//  Copyright © 2019 John Parker. All rights reserved.
//

import UIKit

class UserDefaultsManager: NSObject {
    static let userDefaults = UserDefaults.standard
    
    class func synchronize(){
        let myData = NSKeyedArchiver.archivedData(withRootObject: RecipeManager.recipes)
        userDefaults.set(myData, forKey: "recipearray")
        //UserDefaults.standard.synchronize()
    }
    
    class func initializeDefaults() {
        if let recipesRaw = UserDefaults.standard.data(forKey: "recipearray"){
            if let recipes = NSKeyedUnarchiver.unarchiveObject(with: recipesRaw) as? [Recipe]{
                RecipeManager.recipes = recipes
            }
        }
    }
}
