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
    
    var questions = [Question]()
    var currentQuestionIndex = 0
    var lastFetchedQuestionIndex = 0
    var tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        fetchQuestions(limitTo: 10) {
            self.displayRandomQuestion()
            self.unlockButtons()
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
        
        lockButtons()
    }
    
    @IBAction func trueAnswerButtonPressed(_ sender: UIButton) {
        lockButtons()
        if questions[currentQuestionIndex].correctAnswer == "T" {
            animate(button: sender, to: UIColor(named: "green"))
            increaseLevelOfMastery()
        }
        else {
            animate(button: sender, to: UIColor(named: "red"))
            showGoodAnwer()
            decreaseLevelOfMastery()
        }
    }
    
    @IBAction func falseAnswerButtonPressed(_ sender: UIButton) {
        lockButtons()
        if questions[currentQuestionIndex].correctAnswer == "N" {
            animate(button: sender, to: UIColor(named: "green"))
            increaseLevelOfMastery()
        }
        else {
            animate(button: sender, to: UIColor(named: "red"))
            showGoodAnwer()
            decreaseLevelOfMastery()
        }
    }
    
    @IBAction func aAnswerButtonPressed(_ sender: UIButton) {
        lockButtons()
        if questions[currentQuestionIndex].correctAnswer == "A" {
            animate(button: sender, to: UIColor(named: "green"))
            increaseLevelOfMastery()
        }
        else {
            animate(button: sender, to: UIColor(named: "red"))
            showGoodAnwer()
            decreaseLevelOfMastery()
        }
    }
    
    @IBAction func bAnswerButtonPressed(_ sender: UIButton) {
        lockButtons()
        if questions[currentQuestionIndex].correctAnswer == "B" {
            animate(button: sender, to: UIColor(named: "green"))
            increaseLevelOfMastery()
        }
        else {
            animate(button: sender, to: UIColor(named: "red"))
            showGoodAnwer()
            decreaseLevelOfMastery()
        }
    }
    
    @IBAction func cAnswerButtonPressed(_ sender: UIButton) {
        lockButtons()
        if questions[currentQuestionIndex].correctAnswer == "C" {
            animate(button: sender, to: UIColor(named: "green"))
            increaseLevelOfMastery()
        }
        else {
            animate(button: sender, to: UIColor(named: "red"))
            showGoodAnwer()
            decreaseLevelOfMastery()
        }
    }
    
    func showGoodAnwer() {
        switch self.questions[currentQuestionIndex].correctAnswer {
        case "T":
            self.animate(button: trueAnswerButton, to: UIColor(named: "green"), delay: 0.5)
        case "N":
            self.animate(button: falseAnswerButton, to: UIColor(named: "green"), delay: 0.5)
        case "A":
            self.animate(button: aAnswerButton, to: UIColor(named: "green"), delay: 0.5)
        case "B":
            self.animate(button: bAnswerButton, to: UIColor(named: "green"), delay: 0.5)
        case "C":
            self.animate(button: cAnswerButton, to: UIColor(named: "green"), delay: 0.5)
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
    }
    
    func unlockButtons() {
        trueAnswerButton.isUserInteractionEnabled = true
        falseAnswerButton.isUserInteractionEnabled = true
        
        aAnswerButton.isUserInteractionEnabled = true
        bAnswerButton.isUserInteractionEnabled = true
        cAnswerButton.isUserInteractionEnabled = true
    }
    
    @objc func resetButtons(_ sender: UITapGestureRecognizer? = nil) {
        unlockButtons()
        
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
        currentQuestionIndex = Int.random(in: 0 ..< questions.count)
        let currentQuestion = questions[currentQuestionIndex]
        
        levelOfMasteryImage.image = UIImage(named: String(currentQuestion.masteryLevel ?? 0))
        
        if currentQuestion.image == "" {
            self.questionImage.image = UIImage(named: "imagePlaceholder")
        }
        else {
            self.questionImage.load(url: URL(string: currentQuestion.image))
        }
        
        questionLabel.text = currentQuestion.question
        
        if currentQuestion.isAbcQuestion {
            showAbcAnswerButtons()
            aAnswerButton.setTitle(currentQuestion.answerA, for: .normal)
            bAnswerButton.setTitle(currentQuestion.answerB, for: .normal)
            cAnswerButton.setTitle(currentQuestion.answerC, for: .normal)
        }
        else {
            showTrueFalseAnswerButtons()
        }
    }
    
    func fetchQuestions(limitTo limit: Int, completion: (() -> Void)?) {
        fetchMasteredQuestionsIDs { masteredQuestionsIDs in
            var questionsToFetchIDs = [Int]()
            
            for index in (self.lastFetchedQuestionIndex + 1) ... K.numberOfQuestions {
                if !masteredQuestionsIDs.contains(index) {
                    questionsToFetchIDs.append(index)
                    self.lastFetchedQuestionIndex = index
                    if questionsToFetchIDs.count == limit {
                        break
                    }
                }
            }
            
            K.Collections.questions.whereField("id", in: questionsToFetchIDs).getDocuments { snapshot, error in
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
                self.checkMasteryLevels(forQuestionIDs: questionsToFetchIDs, completion: completion)
            }
        }
    }
    
    func fetchMasteredQuestionsIDs(completion: @escaping ([Int]) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("DEBUG: Error getting current user id.")
            return
        }
        
        var masteredQuestionsIDs = [Int]()
        
        K.Collections.users.document(currentUserID).collection("answeredQuestions").whereField("masteryLevel", isGreaterThanOrEqualTo: 5).getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching user answered questions: \(error.localizedDescription)")
                return
            }
            
            if let documents = snapshot?.documents {
                for document in documents {
                    do {
                        if let masteredQuestion = try document.data(as: AnsweredQuestion.self) {
                            masteredQuestionsIDs.append(masteredQuestion.id)
                        }
                    }
                    catch let error {
                        print("DEBUG: Error converting document to AnsweredQuestion type: \(error.localizedDescription)")
                        return
                    }
                }
            }
            completion(masteredQuestionsIDs)
        }
    }
    
    func checkMasteryLevels(forQuestionIDs questionIDs: [Int], completion: (() -> Void)?) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("DEBUG: Error getting current user id.")
            return
        }
        
        K.Collections.users.document(currentUserID).collection("answeredQuestions").whereField("id", in: questionIDs).getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching answered question: \(error.localizedDescription)")
                return
            }
            if let documents = snapshot?.documents {
                for document in documents {
                    do {
                        if let answeredQuestion = try document.data(as: AnsweredQuestion.self) {
                            if let index = self.questions.firstIndex(where: {$0.id == answeredQuestion.id}) {
                                self.questions[index].masteryLevel = answeredQuestion.masteryLevel
                            }
                        }
                    }
                    catch let error {
                        print("DEBUG: Error converting document to AnsweredQuestion type: \(error.localizedDescription)")
                        return
                    }
                }
            }
            completion?()
        }
    }
    
    func animate(button: UIButton, to color: UIColor?, delay: Double = 0) {
        UIView.animate(withDuration: 0.5, delay: delay) {
            button.backgroundColor = color
        }
    }
    
    func changeMasteryLevel(forQuestionID questionID: Int, by value: Int, completion: (() -> Void)? = nil) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("DEBUG: Error getting current user id.")
            return
        }
        
        K.Collections.users.document(currentUserID).collection("answeredQuestions").document(String(questionID)).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching answered question: \(error.localizedDescription)")
                return
            }
            if snapshot?.exists == true {
                K.Collections.users.document(currentUserID).collection("answeredQuestions").document(String(questionID)).getDocument { snapshot, error in
                    do {
                        if let answeredQuestion = try snapshot?.data(as: AnsweredQuestion.self) {
                            if (value < 0) && (answeredQuestion.masteryLevel == 0) {
                                return
                            }
                            else {
                                K.Collections.users.document(currentUserID).collection("answeredQuestions").document(String(questionID)).updateData(["masteryLevel" : FieldValue.increment(Int64(value))]) { error in
                                    if let error = error {
                                        print("DEBUG: Error changing mastery level value: \(error.localizedDescription)")
                                        return
                                    }
                                    completion?()
                                }
                            }
                        }
                    }
                    catch let error {
                        print("DEBUG: Error converting document to AnsweredQuestion type: \(error.localizedDescription)")
                        return
                    }
                }
            }
            else {
                let answeredQuestion = AnsweredQuestion(id: questionID, masteryLevel: (value > 0) ? value : 0)
                do {
                    try K.Collections.users.document(currentUserID).collection("answeredQuestions").document(String(questionID)).setData(from: answeredQuestion)
                    completion?()
                }
                catch let error {
                    print("DEBUG: Error uploading answered question data: \(error.localizedDescription)")
                    return
                }
            }
        }
    }
    
    func increaseLevelOfMastery() {
        questions[currentQuestionIndex].masteryLevel = (questions[currentQuestionIndex].masteryLevel ?? 0) + 1
        changeMasteryLevel(forQuestionID: questions[currentQuestionIndex].id, by: 1) {
            if self.questions[self.currentQuestionIndex].masteryLevel == 5 {
                self.questions.remove(at: self.currentQuestionIndex)
                self.fetchQuestions(limitTo: 1, completion: nil)
                self.incrementUserMasteredQuestionsNumber()
            }
            self.tapGesture.isEnabled = true
        }
        
        animateLevelOfMasteryImage()
    }
    
    func decreaseLevelOfMastery() {
        if questions[currentQuestionIndex].masteryLevel != 0 && questions[currentQuestionIndex].masteryLevel != nil {
            questions[currentQuestionIndex].masteryLevel = (questions[currentQuestionIndex].masteryLevel ?? 0) - 1
            changeMasteryLevel(forQuestionID: questions[currentQuestionIndex].id, by: -1) {
                self.tapGesture.isEnabled = true
            }
            animateLevelOfMasteryImage()
        }
        else {
            tapGesture.isEnabled = true
        }
    }
    
    func animateLevelOfMasteryImage() {
        UIView.transition(with: levelOfMasteryImage, duration: 0.5, options: .transitionCrossDissolve) {
            if let masteryLevel = self.questions[self.currentQuestionIndex].masteryLevel {
                self.levelOfMasteryImage.image = UIImage(named: String(masteryLevel))
            }
        }
    }
    
    func incrementUserMasteredQuestionsNumber() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("DEBUG: Error getting current user id.")
            return
        }
        
        K.Collections.users.document(currentUserID).updateData(["masteredQuestionsNumber" : FieldValue.increment(Int64(1))]) { error in
            if let error = error {
                print("DEBUG: Error updating user mastered questions number: \(error.localizedDescription)")
                return
            }
        }
    }
    
}
