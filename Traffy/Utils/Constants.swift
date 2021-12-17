//
//  Constants.swift
//  Traffy
//
//  Created by Robert Pelka on 29/11/2021.
//

import Foundation
import Firebase

struct K {
    struct Collections {
        static let users = Firestore.firestore().collection("users")
        static let questions = Firestore.firestore().collection("questions")
        static let signs = Firestore.firestore().collection("signs")
    }
    
    struct Identifiers {
        static let userCell = "userCell"
        static let friendCell = "friendCell"
        static let signCell = "signCell"
    }
    
    struct Colors {
        static let red = "redColor"
        static let green = "greenColor"
    }
    
    struct Segues {
        static let goToSignsView = "goToSignsView"
        static let goToSingleSignView = "goToSingleSignView"
        static let presentSignModally = "presentSignModally"
    }
    
    struct Notifications {
        static let recognizeSignButtonPressed = "recognizeSignButtonPressed"
    }
    
    static let numberOfQuestions = 2276
    static let numberOfSigns = 70
}
