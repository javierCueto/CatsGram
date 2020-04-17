//
//  UploadViewController.swift
//  CatsGram
//
//  Created by José Javier Cueto Mejía on 15/04/20.
//  Copyright © 2020 Pozolx. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButttonClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if let safeError = error {
                    self.makeAlert(titleInput: "Error", messageInput: safeError.localizedDescription)
                    
                }else {
                    imageReference.downloadURL { (url, error) in
                        if let safeError = error {
                            print(safeError.localizedDescription)
                        }else{
                            let imageUrl = url?.absoluteString
                            
                            let firesoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentText.text!, "date" : "date", "like" : 0] as [String : Any]
                            
                            firestoreReference = firesoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if  let safeError =  error  {
                                    self.makeAlert(titleInput: "Error", messageInput: safeError.localizedDescription)
                                }else{
                                    self.makeAlert(titleInput: "Succes", messageInput: "All data are saved")
                                }
                            })
                            
                            
                        }
                    }
                }
                
            }
        }
        
    }
    
    
    
    func makeAlert(titleInput: String, messageInput: String){
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
           let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
           alert.addAction(okButton)
           self.present(alert, animated: true, completion: nil)
          // indicatorActivity.isHidden = true
       }
    
}
