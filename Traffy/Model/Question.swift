//
//  Question.swift
//  Traffy
//
//  Created by Robert Pelka on 04/12/2021.
//

import Foundation

struct Question: Codable {
    let id: Int
    let question: String
    let image: String
    let isAbcQuestion: Bool
    let answerA: String
    let answerB: String
    let answerC: String
    let correctAnswer: String
    
    var masteryLevel: Int?
}
