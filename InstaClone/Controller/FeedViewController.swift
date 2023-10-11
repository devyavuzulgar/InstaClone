//
//  FeedViewController.swift
//  InstaClone
//
//  Created by Yavuz Ulgar on 30.01.2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userEmailArray = [String]()
    var postNoteArray = [String]()
    var likesArray = [Int]()
    var imageUrlStringArray = [String]()
    var documenArray = [String]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
    }
    
    func getDataFromFirestore() {
        
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.postNoteArray.removeAll(keepingCapacity: false)
                    self.imageUrlStringArray.removeAll(keepingCapacity: false)
                    self.likesArray.removeAll(keepingCapacity: false)
                    self.documenArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        
                        let documenId = document.documentID
                        self.documenArray.append(documenId)
                        
                        if let postedBy = document.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        
                        if let postNote = document.get("postNote") as? String {
                            self.postNoteArray.append(postNote)
                        }
                        
                        if let likes = document.get("likes") as? Int {
                            self.likesArray.append(likes)
                        }
                        
                        if let imageUrl = document.get("ImageUrl") as? String {
                            self.imageUrlStringArray.append(imageUrl)
                        }
                    }
                    
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userMailLabel.text = userEmailArray[indexPath.row]
        cell.likeLabel.text = String(likesArray[indexPath.row])
        cell.noteLabel.text = postNoteArray[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: self.imageUrlStringArray[indexPath.row]))
        cell.documenIdLabel.text = documenArray[indexPath.row]
        return cell
    }
}
