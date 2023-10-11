//
//  FeedCell.swift
//  InstaClone
//
//  Created by Yavuz Ulgar on 30.01.2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class FeedCell: UITableViewCell {

    @IBOutlet weak var userMailLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var documenIdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButton(_ sender: Any) {
        let fireStoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
            fireStoreDatabase.collection("Posts").document(documenIdLabel.text!).setData(likeStore, merge: true)
        }
        
        
        
    }
}
