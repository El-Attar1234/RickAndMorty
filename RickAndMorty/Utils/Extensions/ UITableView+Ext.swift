//
//   UITableView+Ext.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 14/03/2025.
//
import UIKit

public extension UITableView {
    
    func register<T: UITableViewCell>(
        cellType: T.Type,
        bundle: Bundle? = nil
    ) {
        register(cellType, forCellReuseIdentifier: cellType.className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(
        with type: T.Type,
        for indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T  else {
            return  UITableViewCell() as! T
        }
        return cell
    }
}
