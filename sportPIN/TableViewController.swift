//
//  TableViewController.swift
//  sportPIN
//
//  Created by NDHU_CSIE on 2021/11/1.
//

import UIKit

enum Section {
    case all
}

class TableViewController: UITableViewController {

    var sportNames = ["baseball", "basketball", "football", "other"]
    var sportImages = ["baseball", "basketball", "football", "other"]
    var sportType = ["ball", "ball", "ball", "other"]
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Create the snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(sportNames, toSection: .all)

        dataSource.apply(snapshot, animatingDifferences: false)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sportNames.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "datacell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = sportNames[indexPath.row]
        cell.imageView?.image = UIImage(named: sportImages[indexPath.row])

        return cell
    }*/
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String> {
        let cellIdentifier = "datacell"

        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, sportNames in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell

            cell.nameLabel.text = sportNames
            cell.thumbnailImageView?.image = UIImage(named:
                self.sportImages[indexPath.row])
                cell.typeLabel.text = self.sportType[indexPath.row]
            return cell
            }
        )

        return dataSource
    }
  
}
