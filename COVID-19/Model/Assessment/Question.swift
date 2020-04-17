//
//  Question.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-16.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import Foundation

struct Question {
    let question : String
    let description : [String]
    var userAnswer : Bool
    
    init(question : String, description : [String]) {
        self.question = question
        self.description = description
        self.userAnswer = false
    }
    
    mutating func setUserAnswer(userAnswer : Bool) {
        self.userAnswer = userAnswer
    }
}

var questions = [
    Question(question: "Are you experiencing any of the following symptoms?", description: ["Severe difficulty breathing","Severe chest pain", "Feeling confused","Losing consciousness"]),
    Question(question: "Do any of the following apply to you?", description: ["I am 65 years old or older","I have a condition that affects my immune system","I have a chronic health condition","I am getting treatment that affects my immune system"]),
    Question(question: "Have you travelled outside of Canada in the last 14 days?", description: []),
    Question(question: "Has someone you are in close contact with tested positive for COVID-19?", description: []),
    Question(question: "Are you in close contact with a person who either:", description: ["Is sick with new respiratory symptoms?", "Recently travelled outside of Canada?"])
]

var results = [
    Question(question: "Call 911 or go directly to your nearest emergency department.", description: ["You may be affected"]),
    Question(question: "You should stay at home and monitor your health because you are part of an at-risk group.", description: ["You do not need to contact a doctor or Telehealth Ontario for an assessment."])
]
