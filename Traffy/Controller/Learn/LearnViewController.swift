//
//  LearnViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 03/12/2021.
//

import UIKit
import Firebase

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
    }
    
    @IBAction func trueAnswerButtonPressed(_ sender: UIButton) {
        displayRandomQuestion()
    }
    
    @IBAction func falseAnswerButtonPressed(_ sender: UIButton) {
        displayRandomQuestion()
    }
    
    @IBAction func aAnswerButtonPressed(_ sender: UIButton) {
        displayRandomQuestion()
    }
    
    @IBAction func bAnswerButtonPressed(_ sender: UIButton) {
        displayRandomQuestion()
    }
    
    @IBAction func cAnswerButtonPressed(_ sender: UIButton) {
        displayRandomQuestion()
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
        
        if randomQuestion.image == "" {
            self.questionImage.image = UIImage(named: "imagePlaceholder")
        }
        else {
            let storageRef = Storage.storage().reference()
            storageRef.child("questionImages/\(randomQuestion.image)").downloadURL { url, error in
                if let error = error {
                    print("DEBUG: Error getting question image url: \(error.localizedDescription)")
                }
                else {
                    self.questionImage.load(url: url)
                }
            }
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
    
}
