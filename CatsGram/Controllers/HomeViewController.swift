//
//  HomeViewController.swift
//  CatsGram
//
//  Created by José Javier Cueto Mejía on 14/04/20.
//  Copyright © 2020 Pozolx. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var postsTable = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()

    }
    


}




extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellHome
        cell.commentText.text = postsTable[indexPath.row].postComment
        cell.userNameEmail.text = postsTable[indexPath.row].postedBy
        cell.userImageView.image = UIImage(named: "noImageUploaded")
        cell.likeLabel.text = String(postsTable[indexPath.row].like)
        return cell
    }
    
    func getDataFromFirestore(){
        let firestoreDataBase = Firestore.firestore()
        
        /*
        let setting = firestoreDataBase.settings
        setting.areTimestampsInSnapshotsEnabled = true*/
        
        firestoreDataBase.collection("Posts").addSnapshotListener { (snapshot, error) in
            if let safeSnapshot = snapshot {
         
                if safeSnapshot.documents.count > 0 {
                           print("here")
                    for document in  safeSnapshot.documents {
                        let post = Post(
                                        id: document.documentID, date: nil,
                                        imageUrl: document.get("imageUrl") as! String,
                                        like: document.get("like") as! Int,
                                        postedBy: document.get("postedBy") as! String,
                                        postComment: document.get("postComment") as? String)
                        
                        self.postsTable.append(post)
                        
                    }
                    self.tableView.reloadData()
                }
            }else{
                print("\(error?.localizedDescription ?? "Error")")
            }
        }
        
    }
    
    
}


extension HomeViewController: UITableViewDelegate{
    
}

