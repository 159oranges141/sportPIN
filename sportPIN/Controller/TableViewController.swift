import UIKit

class TableViewController: UITableViewController {
    
    var sports:[Sports] = []
    
    lazy var dataSource = configureDataSource()
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initilized the data source
        Sports.generateData(sourceArray: &sports)
        
        //Create the snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Sports>()
        snapshot.appendSections([.all])
        snapshot.appendItems(sports, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sports.count
    }
    
    // MARK: - UITableView Diffable Data Source
    
    func configureDataSource() -> DiffableDataSource {
        let cellIdentifier = "datacell"
        
        let dataSource = DiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, sports in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
                
                cell.nameLabel.text = sports.name
                cell.thumbnailImageView?.image = UIImage(named: sports.image)
                cell.typeLabel.text = sports.type
                cell.accessoryType = sports.isFavorite ? .checkmark : .none
                return cell
            }
        )
        return dataSource
    }
    
    // MARK: - Leading Swipe Actions
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Unmark as favorite action
        let favoriteAction = UIContextualAction(style: .destructive, title: "") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
            //update source array
            self.sports[indexPath.row].isFavorite = self.sports[indexPath.row].isFavorite ? false : false
            
            //update data source of the tableview
            var snapshot = NSDiffableDataSourceSnapshot<Section, Sports>()
            snapshot.appendSections([.all])
            snapshot.appendItems(self.sports, toSection: .all)
            self.dataSource.apply(snapshot, animatingDifferences: false)
            
            //update cell
            cell.accessoryType = self.sports[indexPath.row].isFavorite ? .checkmark : .none
            
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        // Change the action's color and icon
        favoriteAction.backgroundColor = UIColor.systemYellow
        favoriteAction.image = UIImage(systemName: self.sports[indexPath.row].isFavorite ? "heart.slash.fill" : "heart.slash.fill")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favoriteAction])
        
        return swipeConfiguration
    }
    
    // MARK: - Trailing Swipe Actions
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Mark as favorite action
        let favoriteAction = UIContextualAction(style: .destructive, title: "") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
            //update source array
            self.sports[indexPath.row].isFavorite = self.sports[indexPath.row].isFavorite ? true : true
            
            //update data source of the tableview
            var snapshot = NSDiffableDataSourceSnapshot<Section, Sports>()
            snapshot.appendSections([.all])
            snapshot.appendItems(self.sports, toSection: .all)
            self.dataSource.apply(snapshot, animatingDifferences: false)
            
            //update cell
            cell.accessoryType = self.sports[indexPath.row].isFavorite ? .checkmark : .none
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        // Change the action's color and icon
        favoriteAction.backgroundColor = UIColor.systemYellow
        favoriteAction.image = UIImage(systemName: self.sports[indexPath.row].isFavorite ? "heart.fill" : "heart.fill")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favoriteAction])
        
        return swipeConfiguration
    }
    
    // MARK: - For Segue`s Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailViewController
                destinationController.sportImageName = sports[indexPath.row].photo
            }
        }
    }
    
    
}
