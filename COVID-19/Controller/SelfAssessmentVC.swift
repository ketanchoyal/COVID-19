//
//  SelfAssessmentVC.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-16.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import UIKit

class SelfAssessmentVC: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionDescriptionLabel: UILabel!
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var yesNoStack: UIStackView!
    
    var questionCount : Int = 0
    var currentQuestion : Int = 0
    
    var yesCount: Int = 0
    var noCount: Int = 0
    
    var allQuestions : [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allQuestions = questions
        questionCount = allQuestions.count
        setQuestion()
    }
    
    func setQuestion() {
        if (currentQuestion > 0) {
            if (allQuestions[0].userAnswer) {
                yesNoStack.isHidden = true
                question.isHidden = true
                questionLabel.text = results[0].question
                questionDescriptionLabel.text = results[0].description[0]
                return
            }
        }
        
        if(currentQuestion >= questionCount) {
            yesNoStack.isHidden = true
            question.isHidden = true
            if (yesCount <= 2) {
                questionLabel.text = results[1].question
                questionDescriptionLabel.text = results[1].description[0]
            } else {
                questionLabel.text = results[0].question
                questionDescriptionLabel.text = results[0].description[0]
            }
        } else {
            questionLabel.text = allQuestions[currentQuestion].question
            var descriptionAll = ""
            for description in allQuestions[currentQuestion].description {
                descriptionAll = descriptionAll + "￮ " + description + "\n"
            }
            questionDescriptionLabel.text = descriptionAll
        }
        currentQuestion = currentQuestion + 1
    }

    @IBAction func yesButtonPressed(_ sender: Any) {
        yesCount = yesCount + 1
        allQuestions[currentQuestion - 1].setUserAnswer(userAnswer: true)
        setQuestion()
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        noCount = noCount + 1
        allQuestions[currentQuestion - 1].setUserAnswer(userAnswer: false)
        setQuestion()
    }
}
