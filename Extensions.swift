//
//  Extensions.swift
//  
//
//  Created by Dhruv Govani on 27/06/20.
//

import Foundation
import UIKit

///Round the edges of all views defined in parameter
///Usage : UIView().RoundEdgesOf(Views: [Label,TextField,Button,SubView])
extension UIView{
    func RoundEdgesOf(Views : [UIView]){
        
        for i in Views{
            i.clipsToBounds = true
            i.layer.cornerRadius = i.frame.height / 2
        }
        
    }
}
