//
//  CategoriesViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 03/12/2021.
//

import UIKit
import Firebase
import CoreML
import Vision

enum SignType: String {
    case warning = "ostrzegawczy"
    case prohibition = "zakazu"
    case mandatory = "nakazu"
    case information = "informacyjny"
}

class CategoriesViewController: UIViewController {

    @IBOutlet weak var warningSignsButton: UIButton!
    @IBOutlet weak var prohibitionSignsButton: UIButton!
    @IBOutlet weak var mandatorySignsButton: UIButton!
    @IBOutlet weak var informationSignsButton: UIButton!
    
    @IBOutlet weak var warningSignsLabel: UILabel!
    @IBOutlet weak var prohibitionSignsLabel: UILabel!
    @IBOutlet weak var mandatorySignsLabel: UILabel!
    @IBOutlet weak var informationSignsLabel: UILabel!
    
    @IBOutlet weak var discoverSignButton: UIButton!
    
    var category: SignType = .warning
    let imagePicker = UIImagePickerController()
    var detectedSign: Sign?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.presentPicker), name: NSNotification.Name(rawValue: K.Notifications.recognizeSignButtonPressed), object: nil)
        
        prepareView()
    }
    
    func prepareView() {
        warningSignsButton.layer.cornerRadius = 15
        prohibitionSignsButton.layer.cornerRadius = 15
        mandatorySignsButton.layer.cornerRadius = 15
        informationSignsButton.layer.cornerRadius = 15
        
        discoverSignButton.layer.cornerRadius = 15
    }
    
    @IBAction func warningSignsButtonPressed(_ sender: UIButton) {
        category = .warning
        performSegue(withIdentifier: K.Segues.goToSignsView, sender: self)
    }
    
    @IBAction func prohibitionSignsButtonPressed(_ sender: UIButton) {
        category = .prohibition
        performSegue(withIdentifier: K.Segues.goToSignsView, sender: self)
    }
    
    @IBAction func mandatorySignsButtonPressed(_ sender: UIButton) {
        category = .mandatory
        performSegue(withIdentifier: K.Segues.goToSignsView, sender: self)
    }
    
    @IBAction func informationSignsButtonPressed(_ sender: UIButton) {
        category = .information
        performSegue(withIdentifier: K.Segues.goToSignsView, sender: self)
    }
    
    @IBAction func discoverSignButtonPressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func presentPicker(notification: NSNotification) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func detectSign(image: CIImage) {
        let signsClassifier: SignsClassifier = {
            do {
                let config = MLModelConfiguration()
                return try SignsClassifier(configuration: config)
            } catch let error {
                fatalError("DEBUG: Error loading CoreML model: \(error.localizedDescription)")
            }
        }()
        
        guard let model = try? VNCoreMLModel(for: signsClassifier.model) else {
            print("DEBUG: Error getting Vision CoreML model")
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            if let error = error {
                print("DEBUG: Error making CoreML request: \(error.localizedDescription)")
            }
            guard let results = request.results as? [VNClassificationObservation] else {
                print("DEBUG: Error processing an image.")
                return
            }
            if let firstResult = results.first {
                self.fetchSign(withID: firstResult.identifier)
            }
        }
        
        let requestHandler = VNImageRequestHandler(ciImage: image)
        
        do {
            try requestHandler.perform([request])
        }
        catch let error {
            print("DEBUG: Error performing a request: \(error.localizedDescription)")
            return
        }
    }
    
    func fetchSign(withID id: String) {
        K.Collections.signs.document(id).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching sign: \(error.localizedDescription)")
                return
            }
            
            do {
                let sign = try snapshot?.data(as: Sign.self)
                self.detectedSign = sign
                self.performSegue(withIdentifier: K.Segues.presentSignModally, sender: self)
            }
            catch let error {
                print("DEBUG: Error converting document to Sign type: \(error.localizedDescription)")
                return
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.goToSignsView {
            let signsVC = segue.destination as! SignsViewController
            signsVC.category = category
        }
        else if segue.identifier == K.Segues.presentSignModally {
            let singleSignVC = segue.destination as! SingleSignViewController
            guard let detectedSign = detectedSign else {
                print("DEBUG: Error unwraping detected sign.")
                return
            }
            singleSignVC.sign = detectedSign
        }
    }
    
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension CategoriesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            guard let ciImage = CIImage(image: pickedImage) else {
                print("DEBUG: Could not convert UIImage to CIImage.")
                return
            }
            detectSign(image: ciImage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
