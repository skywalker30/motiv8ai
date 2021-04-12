//
//  ProductCell.swift
//  motiv8ai
//
//  Created by Roman Sukner on 12/04/2021.
//

import Foundation
import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet var mark: UIView?
    @IBOutlet var name: UILabel?
    @IBOutlet var weight: UILabel?
    
    var item: ProductViewModelItemProto? {
        didSet {

            guard let item = item as? ProductViewModelItem else {
                return
            }
            
            let color = UIColor(hexString:item.color!)
            
            mark?.backgroundColor = color
            name?.text = item.name
            weight?.text = item.weight
        }
    }

    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    
    override func layoutSubviews () {
        super.layoutSubviews()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

