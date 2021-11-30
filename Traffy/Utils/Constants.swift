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
    }
}
