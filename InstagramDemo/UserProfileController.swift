//
//  UserProfileController.swift
//  InstagramDemo
//
//  Created by Arif  on 9/30/23.
//

import UIKit
import FirebaseAuth
import Firebase

class UserProfileController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        navigationItem.title = Auth.auth().currentUser?.uid

        fetchUser()
    }

    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snaphot, err  in

            guard let dictionary = snaphot.value as? [String: Any] else { return }

            let username = dictionary["username"] as? String
            self.navigationItem.title = username

            if let err = err {
                print(err)
            }

        }
    }
}
