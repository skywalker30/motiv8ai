//
//  HeadCell.swift
//  motiv8ai
//
//  Created by Roman Sukner on 12/04/2021.
//

import Foundation


import Foundation
import UIKit

class HeadCell: UITableViewCell {
    
    
    var onStartClick: (()->Void)?
    var onStopClick: (()->Void)?
    var onClearClick: (()->Void)?
    
    

    @IBAction func btnStart(_ sender: Any) {
        
           
            
        if self.onStartClick != nil {
            
            self.onStartClick!()
            
        }
        
    }
    
    
    
    @IBAction func btnStop(_ sender: Any) {
        
        if self.onStopClick != nil {
            
            self.onStopClick!()
            
        }
    }
    
    
    @IBAction func btnClear(_ sender: Any) {
        
        if self.onClearClick != nil {
            
            self.onClearClick!()
            
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


