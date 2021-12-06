//
//  LearnViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 03/12/2021.
//

import UIKit
import Firebase
import SwiftUI

class LearnViewController: UIViewController {
    
    @IBOutlet weak var levelOfMasteryImage: UIImageView!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var trueAnswerButton: UIButton!
    @IBOutlet weak var falseAnswerButton: UIButton!
    
    @IBOutlet weak var aAnswerButton: UIButton!
    @IBOutlet weak var bAnswerButton: UIButton!
    @IBOutlet weak var cAnswerButton: UIButton!
    
    @IBOutlet weak var trueFalseButtonsView: UIStackView!
    @IBOutlet weak var abcButtonsView: UIStackView!
    
    var masteredQuestionsIDs = [Int]()
    var questions = [Question]()
    var currentQuestion: Question?
    var tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        fetchQuestions {
            self.displayRandomQuestion()
        }
    }
    
    func prepareView() {
        questionImage.layer.cornerRadius = 10
        
        trueAnswerButton.layer.cornerRadius = 15
        falseAnswerButton.layer.cornerRadius = 15
        
        aAnswerButton.layer.cornerRadius = 15
        bAnswerButton.layer.cornerRadius = 15
        cAnswerButton.layer.cornerRadius = 15
        
        aAnswerButton.titleLabel?.textAlignment = .center
        bAnswerButton.titleLabel?.textAlignment = .center
        cAnswerButton.titleLabel?.textAlignment = .center
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.resetButtons(_:)))
        view.addGestureRecognizer(tapGesture)
        tapGesture.isEnabled = false
    }
    
    @IBAction func trueAnswerButtonPressed(_ sender: UIButton) {
        lockButtons()
        if currentQuestion?.correctAnswer == "T" {
            animate(button: sender, to: UIColor(named: "green"))
        }
        else {
            animate(button: sender, to: UIColor(named: "red"))
            showGoodAnwer()
        }
    }
    
    @IBAction func falseAnswerButtonPressed(_ sender: UIButton) {
        lockButtons()
        if currentQuestion?.correctAnswer == "N" {
            animate(button: sender, to: UIColor(named: "green"))
        }
        else {
            animate(button: sender, to: UIColor(named: "red"))
            showGoodAnwer()
        }
    }
    
    @IBAction func aAnswerButtonPressed(_ sender: UIButton) {
        lockButtons()
        if currentQuestion?.correctAnswer == "A" {
            animate(button: sender, to: UIColor(named: "green"))
        }
        else {
            animate(button: sender, to: UIColor(named: "red"))
            showGoodAnwer()
        }
    }
    
    @IBAction func bAnswerButtonPressed(_ sender: UIButton) {
        lockButtons()
        if currentQuestion?.correctAnswer == "B" {
            animate(button: sender, to: UIColor(named: "green"))
        }
        else {
            animate(button: sender, to: UIColor(named: "red"))
            showGoodAnwer()
        }
    }
    
    @IBAction func cAnswerButtonPressed(_ sender: UIButton) {
        lockButtons()
        if currentQuestion?.correctAnswer == "C" {
            animate(button: sender, to: UIColor(named: "green"))
        }
        else {
            animate(button: sender, to: UIColor(named: "red"))
            showGoodAnwer()
        }
    }
    
    func showGoodAnwer() {
        switch self.currentQuestion?.correctAnswer {
        case "T":
            self.animate(button: trueAnswerButton, to: UIColor(named: "green"))
        case "N":
            self.animate(button: falseAnswerButton, to: UIColor(named: "green"))
        case "A":
            self.animate(button: aAnswerButton, to: UIColor(named: "green"))
        case "B":
            self.animate(button: bAnswerButton, to: UIColor(named: "green"))
        case "C":
            self.animate(button: cAnswerButton, to: UIColor(named: "green"))
        default:
            break
        }
    }
    
    func lockButtons() {
        trueAnswerButton.isUserInteractionEnabled = false
        falseAnswerButton.isUserInteractionEnabled = false
        
        aAnswerButton.isUserInteractionEnabled = false
        bAnswerButton.isUserInteractionEnabled = false
        cAnswerButton.isUserInteractionEnabled = false
        
        tapGesture.isEnabled = true
    }
    
    @objc func resetButtons(_ sender: UITapGestureRecognizer? = nil) {
        trueAnswerButton.isUserInteractionEnabled = true
        falseAnswerButton.isUserInteractionEnabled = true
        
        aAnswerButton.isUserInteractionEnabled = true
        bAnswerButton.isUserInteractionEnabled = true
        cAnswerButton.isUserInteractionEnabled = true
        
        trueAnswerButton.backgroundColor = UIColor.white
        falseAnswerButton.backgroundColor = UIColor.white
        
        aAnswerButton.backgroundColor = UIColor.white
        bAnswerButton.backgroundColor = UIColor.white
        cAnswerButton.backgroundColor = UIColor.white
        
        displayRandomQuestion()
        
        tapGesture.isEnabled = false
    }

    func showTrueFalseAnswerButtons() {
        trueFalseButtonsView.isHidden = false
        abcButtonsView.isHidden = true
    }
    
    func showAbcAnswerButtons() {
        trueFalseButtonsView.isHidden = true
        abcButtonsView.isHidden = false
    }
    
    func displayRandomQuestion() {
        guard let randomQuestion = questions.randomElement() else { return }
        currentQuestion = randomQuestion
        
        if randomQuestion.image == "" {
            self.questionImage.image = UIImage(named: "imagePlaceholder")
        }
        else {
            self.questionImage.load(url: URL(string: randomQuestion.image))
        }
        
        questionLabel.text = randomQuestion.question
        
        if randomQuestion.isAbcQuestion {
            showAbcAnswerButtons()
            aAnswerButton.setTitle(randomQuestion.answerA, for: .normal)
            bAnswerButton.setTitle(randomQuestion.answerB, for: .normal)
            cAnswerButton.setTitle(randomQuestion.answerC, for: .normal)
        }
        else {
            showTrueFalseAnswerButtons()
        }
    }
    
    func fetchQuestions(completion: @escaping () -> Void) {
        fetchMasteredQuestionsIDs {
            var query: Query
            
            if self.masteredQuestionsIDs.isEmpty {
                query = K.Collections.questions.order(by: "id", descending: false).limit(to: 15)
            }
            else {
                query = K.Collections.questions.whereField("id", notIn: self.masteredQuestionsIDs).order(by: "id", descending: false).limit(to: 15)
            }
            
            query.getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Error fetching questions: \(error.localizedDescription)")
                    return
                }
                
                if let documents = snapshot?.documents {
                    for document in documents {
                        do {
                            if let question = try document.data(as: Question.self) {
                                self.questions.append(question)
                            }
                        }
                        catch let error {
                            print("DEBUG: Error converting document to Question type: \(error.localizedDescription)")
                            return
                        }
                    }
                }
                completion()
            }
        }
    }
    
    func fetchMasteredQuestionsIDs(completion: @escaping () -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("DEBUG: Error getting current user id.")
            return
        }
        
        K.Collections.users.document(currentUserID).collection("answeredQuestions").whereField("masteryLevel", isGreaterThanOrEqualTo: 5).getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching user answered questions: \(error.localizedDescription)")
                return
            }
            
            if let documents = snapshot?.documents {
                for document in documents {
                    do {
                        if let masteredQuestionID = try document.data(as: AnsweredQuestion.self) {
                            self.masteredQuestionsIDs.append(masteredQuestionID.id)
                        }
                    }
                    catch let error {
                        print("DEBUG: Error converting document to AnsweredQuestion type: \(error.localizedDescription)")
                        return
                    }
                }
            }
            completion()
        }
    }
    
    func animate(button: UIButton, to color: UIColor?) {
        UIView.animate(withDuration: 0.5) {
            button.backgroundColor = color
        }
    }
    
}
