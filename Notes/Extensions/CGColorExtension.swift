//
//  CGColorExtension.swift
//  Notes
//
//  Created by User on 29/04/24.
//

import Foundation

//  CGColorExtension.swift
import Foundation
import UIKit

public extension CGColor {
    var UIColor : UIKit.UIColor {
        return UIKit.UIColor(cgColor: self)
    }
}
