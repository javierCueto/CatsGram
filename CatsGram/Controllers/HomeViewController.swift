//
//  HomeViewController.swift
//  CatsGram
//
//  Created by José Javier Cueto Mejía on 14/04/20.
//  Copyright © 2020 Pozolx. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var postsTable = [Post]()
    private let celId = "CatTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: celId, bundle: nil), forCellReuseIdentifier: celId)
        getDataFromFirestore()
        
    }
    
    
    
}




extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: celId, for: indexPath)
        if let cell = cell as? CatTableViewCell{
            cell.userNameEmail.text = postsTable[indexPath.row].postedBy
            cell.tableImageView.sd_setImage(with: URL(string: postsTable[indexPath.row].imageUrl), completed: nil)
            
            
            cell.commentLabel.text = postsTable[indexPath.row].postComment
            
            
            cell.likeLabel.text = String(postsTable[indexPath.row].like)
        }
        
        return cell
    }
    
    func getDataFromFirestore(){
        let firestoreDataBase = Firestore.firestore()

        firestoreDataBase.collection("Posts").addSnapshotListener { (snapshot, error) in
            if let safeSnapshot = snapshot {
                
                if safeSnapshot.documents.count > 0 {
                    print("here2")
                    self.postsTable.removeAll(keepingCapacity: false)
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

