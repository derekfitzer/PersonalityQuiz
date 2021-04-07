//
//  QuizViewController.swift
//  PersonalityQuiz
//
//  Created by Derek Fitzer on 2/24/21.
//

import UIKit

class QuizViewController: UIViewController {
    
    var questionIndex = 0
    var answerChosen: [Answer] = []
    var quizSelected: Int = 1
    var questions: [Question] = []
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var multiStack1: UIStackView!
    @IBOutlet weak var multiStack2: UIStackView!
    @IBOutlet weak var multiStack3: UIStackView!
    @IBOutlet weak var multiStack4: UIStackView!
    
    @IBOutlet weak var questionProgressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setQuiz()
        UIUpdate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! RevealViewController
            resultsViewController.responses = answerChosen
        }
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswer = questions[questionIndex].answer
        
        switch sender {
        case singleButton1:
            answerChosen.append(currentAnswer[0])
        case singleButton2:
            answerChosen.append(currentAnswer[1])
        case singleButton3:
            answerChosen.append(currentAnswer[2])
        case singleButton4:
            answerChosen.append(currentAnswer[3])
        default:
            break
        }
      nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed(_ sender: UIButton) {
        let currendAnswers = questions[questionIndex].answer
        if multiSwitch1.isOn {
            answerChosen.append(currendAnswers[0])
        }
        if multiSwitch2.isOn {
            answerChosen.append(currendAnswers[1])
        }
        if multiSwitch3.isOn {
            answerChosen.append(currendAnswers[2])
        }
        if multiSwitch4.isOn {
            answerChosen.append(currendAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswer = questions[questionIndex].answer
        let index = Int(round(rangedSlider.value * Float(currentAnswer.count - 1)))
        answerChosen.append(currentAnswer[index])
        nextQuestion()
    }
    
    func setQuiz(){
        // updated for stretch 1
        switch quizSelected {
        case 1:
            questions = [
                Question(text: "Fav Food", type: .single, answer: [
                            Answer(text: "Steak", type: .dog),
                            Answer(text: "Fish", type: .cat),
                            Answer(text: "Carrots", type: .rabbit),
//                            Answer(text: "Corn", type: .turtle)
                ]),
                Question(text: "Fav Act", type: .multiple, answer: [
                            Answer(text: "Swim", type: .turtle),
                            Answer(text: "Sleeping", type: .cat),
//                            Answer(text: "Cuddle", type: .rabbit),
//                            Answer(text: "Eat", type: .dog)
                ]),
                Question(text: "Do you like car ride?", type: .ranged, answer: [
                            Answer(text: "Not a fan", type: .turtle),
                            Answer(text: "Nope", type: .cat),
                            Answer(text: "Who Cares", type: .rabbit),
                            Answer(text: "Love Em!", type: .dog)]),
                
            ]
        case 2:
            questions = [
                Question(text: "I feel at home", type: .single, answer: [
                            Answer(text: "In the Back Yard", type: .dog),
                            Answer(text: "Perched in a Window", type: .cat),
//                            Answer(text: "Cozy in a Hutch", type: .rabbit),
//                            Answer(text: "Tucked in my shell", type: .turtle)
                ]),
                Question(text: "What is your favorite song?", type: .multiple, answer: [
                            Answer(text: "TMNT Theme!", type: .turtle),
                            Answer(text: "Cat Scratch Fever", type: .cat),
                            Answer(text: "Run Rabbit Run", type: .rabbit),
                            Answer(text: "Hounddog", type: .dog)]),
                Question(text: "What's your speed?", type: .ranged, answer: [
                            Answer(text: "Slow as it goes", type: .turtle),
                            Answer(text: "Sleep then pounce", type: .cat),
                            Answer(text: "Very Fast!", type: .rabbit),
                            Answer(text: "Zoom Zoom", type: .dog)]),
            ]
        default:
            break
        }
        
        // random set questions
        questions.shuffle()
        for i in 0..<questions.count {
            questions[i].answer.shuffle()
        }
    }
    
    func nextQuestion(){
        questionIndex += 1
        // update hidden buttons
        singleButton2.isHidden = false
        singleButton3.isHidden = false
        singleButton4.isHidden = false
        multiStack2.isHidden = false
        multiStack3.isHidden = false
        multiStack4.isHidden = false
        
        if questionIndex < questions.count {
            UIUpdate()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    
    func UIUpdate(){
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answer
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangingStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        // stretch 3 dynamic response
        switch answers.count {
        case 2:
            singleButton1.setTitle(answers[0].text, for: .normal)
            singleButton2.setTitle(answers[1].text, for: .normal)
            singleButton3.isHidden = true
            singleButton4.isHidden = true
        case 3:
            singleButton1.setTitle(answers[0].text, for: .normal)
            singleButton2.setTitle(answers[1].text, for: .normal)
            singleButton3.setTitle(answers[2].text, for: .normal)
            singleButton4.isHidden = true
        case 4:
            singleButton1.setTitle(answers[0].text, for: .normal)
            singleButton2.setTitle(answers[1].text, for: .normal)
            singleButton3.setTitle(answers[2].text, for: .normal)
            singleButton4.setTitle(answers[3].text, for: .normal)
        default:
            break
        }
        
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        switch answers.count {
        case 2:
            multiLabel1.text = answers[0].text
            multiLabel2.text = answers[1].text
            multiStack3.isHidden = true
            multiStack4.isHidden = true
        case 3:
            multiLabel1.text = answers[0].text
            multiLabel2.text = answers[1].text
            multiLabel3.text = answers[2].text
            multiStack4.isHidden = true
        case 4:
            multiLabel1.text = answers[0].text
            multiLabel2.text = answers[1].text
            multiLabel3.text = answers[2].text
            multiLabel4.text = answers[3].text
        default:
            break
        }
        
        
    }
    
    func updateRangingStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }

}
