import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        
        UserDefaultsManager.initializeDefaults()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //navigationController?.navigationBar.alpha = 0.5
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeManager.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! customcell
        
        if(indexPath.item % 2 == 0){
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.2)

        }else{
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        }
        
        cell.textLabel?.textColor = UIColor.white
        let recipe = RecipeManager.recipes[indexPath.item]
        cell.textLabel?.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        cell.textLabel?.font = UIFont(name:"AvenirNext-DemiBold", size: 18)
        cell.textLabel?.text = recipe.title
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        cell.selectedBackgroundView = backgroundView
        cell.recipe = recipe
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            RecipeManager.DeleteRecipe(id: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaultsManager.synchronize()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailview"){
            let cell = sender as! customcell
            let detailview = segue.destination as! DetailViewController
            detailview.preRecipe = cell.recipe
        }
    }
}

