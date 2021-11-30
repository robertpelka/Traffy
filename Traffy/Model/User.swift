//
//  User.swift
//  Traffy
//
//  Created by Robert Pelka on 29/11/2021.
//

import Foundation

struct User: Codable {
    let id: String
    let profileImageURL: String
    let username: String
    var masteredQuestionsNumber: Int = 0
    var discoveredSignsNumber: Int = 0
    
    var isFollowed: Bool?
}
