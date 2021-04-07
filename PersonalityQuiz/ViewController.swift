//
//  ViewController.swift
//  PersonalityQuiz
//
//  Created by Derek Fitzer on 2/24/21.
//

import UIKit

class ViewController: UIViewController {
    
    var quizPicked = 1

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destNav = segue.destination as? UINavigationController else { return }
        guard let questionVc = destNav.topViewController as? QuizViewController else { return }
        questionVc.quizSelected = quizPicked
//        let vc = segue.destination as! QuizViewController
//        vc.quizSelected = quizPicked
    }
    
    @IBAction func unwindToQuizIntro(segue: UIStoryboardSegue){
    }

    @IBAction func takeQuiz(_ sender: UIButton) {
        let buttonId = String(sender.title(for: .normal) ?? "Design Quiz" )
        
        switch buttonId {
        case "Design Quiz":
            quizPicked = 1
            performSegue(withIdentifier: "GoQuiz", sender: nil)
        case "Code Quiz":
            quizPicked = 2
            performSegue(withIdentifier: "GoQuiz", sender: nil)
        default:
            break
        }
    }
}

