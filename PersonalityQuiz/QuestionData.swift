//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Derek Fitzer on 2/24/21.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answer: [Answer]
    
    enum ResponseType {
        case single, multiple, ranged
    }
}

struct Answer {
    var text: String
    var type: AnimalType
    

    
    }

enum AnimalType: Character {
    case dog = "🐶", cat = "😸", rabbit = "🐰", turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "You are a dog"
        case .cat:
            return "You are a cat"
        case .rabbit:
            return "You are a rabbit"
        case .turtle:
            return "You are a turtle"
        }
    }
}
    


