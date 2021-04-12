//
//  ProductsViewModel.swift
//  motiv8ai
//
//  Created by Roman Sukner on 12/04/2021.
//


import Foundation
import UIKit

enum ProtuctViewModelItemType {
    case head
    case product
}

protocol ProductViewModelItemProto {
    var type: ProtuctViewModelItemType { get }
    var sectionTitle: String? { get }
    var rowCount: Int { get }
}


class ProductsViewModel: NSObject {
    var items = [ProductViewModelItemProto]()
    var stopClick: (()->Void)?
    var startClick: (()->Void)?
    var clearClick: (()->Void)?
    
    override init() {
        
        let headItem = HeadViewModelItem()
        items.append(headItem)
        
    }
    
    func appendItem(product:Product?) {
        
        let productItem = ProductViewModelItem(product: product!)
        items.append(productItem)
        
        
    }
    
}



extension ProductsViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item.type {
            
            case .product:
                if let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell {
                    
                    cell.item = item
                    return cell
                }
       
                
            case .head:
                return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: HeadCell.identifier) as? HeadCell {
            
            let onClearClick: () -> Void = { () in
                
                self.items.removeAll()
                
                if let clearClick = self.clearClick {
                    
                    clearClick()
                    
                }
                
            }
            
            
            cell.onStartClick = self.startClick
            cell.onStopClick = self.stopClick
            cell.onClearClick = onClearClick
                        
            return cell
        }
        
        return nil
        
    }
}


extension ProductsViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat.leastNormalMagnitude
        
        let item = items[indexPath.row]
        
        switch item.type {
            case .head:
                height = 100
            case .product:
                height = 100
      
        }
        
        return height
    }
    
   
}

class HeadViewModelItem: ProductViewModelItemProto {
    var type: ProtuctViewModelItemType {
        return .head
    }
    
    var sectionTitle: String? {
        return nil
    }
    
    var rowCount: Int {
        return 1
    }
    
    
    
    init() {
        
        
    }
}

class ProductViewModelItem: ProductViewModelItemProto {
    
    
    var type: ProtuctViewModelItemType {
        return .product
    }
    var sectionTitle: String? {
        return nil
    }
    var rowCount: Int {
        return 1
    }
    
    var color: String?
    var name: String?
    var weight: String?

 
    
    init(product: Product) {
        
        self.color = product.bagColor
        self.name = product.name
        self.weight = product.weight
    
    }
    
}

