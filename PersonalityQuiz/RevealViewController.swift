//
//  RevealViewController.swift
//  PersonalityQuiz
//
//  Created by Derek Fitzer on 2/24/21.
//

import UIKit

class RevealViewController: UIViewController {

    @IBOutlet weak var resultsDefinitonLabel: UILabel!
    @IBOutlet weak var resultsAnswerLabel: UILabel!
    var responses: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResults()

    }
    
    func calculatePersonalityResults(){
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseType = responses.map { $0.type }
        for response in responseType {
            let newCount: Int
            if let oldCount = frequencyOfAnswers[response] {
                newCount = oldCount + 1
            } else {
                newCount = 1
            }
            frequencyOfAnswers[response] = newCount
            let frequencyOfAnswersSorted = frequencyOfAnswers.first!.key
            let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
            
            resultsAnswerLabel.text = "you are a \(mostCommonAnswer.rawValue)!"
            resultsDefinitonLabel.text = mostCommonAnswer.definition
            
        }
        
    }


}
