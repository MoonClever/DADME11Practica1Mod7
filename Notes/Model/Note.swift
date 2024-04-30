//
//  Note.swift
//  Notes
//
//  Created by User on 29/04/24.
//

import Foundation

struct Note : Codable{
    var title : String
    var content: String
    var size: Float
    var color: [CGFloat]
}
