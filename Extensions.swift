//
//  Extensions.swift
//  
//
//  Created by Dhruv Govani on 27/06/20.
//
//  Copyright (c) 2020 Dhruv Govani
//
//  MIT License : https://github.com/DhruvGovani/SwiftExtensions/blob/master/LICENSE
//  GIT : https://github.com/DhruvGovani/SwiftExtensions

import Foundation
import UIKit


extension UIView{
    ///Round the edges of all views defined in parameter
    ///Usage : UIView().RoundEdgesOf(Views: [Label,TextField,Button,SubView])
    func RoundEdgesOf(Views : [UIView]){
        
        for i in Views{
            i.clipsToBounds = true
            i.layer.cornerRadius = i.frame.height / 2
        }
        
    }
}
