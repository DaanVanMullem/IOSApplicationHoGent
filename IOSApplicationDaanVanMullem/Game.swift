//
//  Game.swift
//  FirstProjectTest2
//
//  Created by user208206 on 12/27/21.
//

import Foundation

struct Game: Codable {
    var currency: String
    var currentLowestPrice: Double
    var developer: String
    var id: String
    var name: String
    var releaseDate: String
    var stores: [Store]
    var type: String
}
