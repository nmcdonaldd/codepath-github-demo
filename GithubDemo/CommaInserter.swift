//
//  CommaInserter.swift
//  GithubDemo
//
//  Created by Nick McDonald on 1/28/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class CommaInserter: NSObject {
    
    class func insertCommas(into number: Int) -> String {
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }

}
