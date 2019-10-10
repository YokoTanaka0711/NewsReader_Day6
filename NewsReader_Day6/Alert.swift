//
//  Alart.swift
//  NewsReader_Day6
//
//  Created by 田中陽子 on 2019/10/08.
//  Copyright © 2019 Yoko Tanaka. All rights reserved.
//

import UIKit

extension UIViewController{
    func singleAlert(title:String,message:String?){
        let aleartVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        aleartVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(aleartVC,animated: true,completion: nil)
    }
    
    
}
