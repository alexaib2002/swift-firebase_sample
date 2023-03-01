//
//  ViewController.swift
//  FirebaseForm
//
//  Created by Usuario invitado on 1/3/23.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {

    
    @IBOutlet weak var expNoField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    
    private let db = Firestore.firestore();
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onAlmacenarButtonPressed(_ sender: Any) {
        db.collection("users")
            .document(expNoField.text!)
            .setData([
                "user":nameField.text ?? "",
                "email":mailField.text ?? ""])
    }
    
    @IBAction func onRecuperarButtonPressed(_ sender: Any) {
        db.collection("users")
            .document(expNoField.text!)
            .getDocument{
                (DocumentSnapshot,error) in
                if let document = DocumentSnapshot, error == nil {
                    self.nameField.text = document.get("user") as? String
                    self.mailField.text = document.get("email") as? String
                }
            }
    }
    @IBAction func onEliminarButtonPressed(_ sender: Any) {
        db.collection("users")
            .document(expNoField.text!).delete()
        expNoField.text = ""
        nameField.text = ""
        mailField.text = ""
    }
}

