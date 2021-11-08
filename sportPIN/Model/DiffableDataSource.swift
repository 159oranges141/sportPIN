//
//  DiffableDataSource.swift
//  sportPIN
//
//  Created by NDHU_CSIE on 2021/11/8.
//

import UIKit

enum Section {
    case all
}

class DiffableDataSource: UITableViewDiffableDataSource<Section, Sports> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
