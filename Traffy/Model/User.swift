//
//  User.swift
//  Traffy
//
//  Created by Robert Pelka on 29/11/2021.
//

import Foundation

struct User: Codable {
    var id: String
    var profileImageURL: String
    var username: String
    var masteredQuestionsNumber: Int = 0
    var discoveredSignsNumber: Int = 0
    
    var isFollowed: Bool?
}
