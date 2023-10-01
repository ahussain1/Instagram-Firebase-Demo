//
//  UserProfileController.swift
//  InstagramDemo
//
//  Created by Arif  on 9/30/23.
//

import UIKit
import FirebaseAuth
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        navigationItem.title = Auth.auth().currentUser?.uid

        fetchUser()
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        // this gives you a header and footer view
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        header.user = self.user

        // not correct
        header.addSubview(UIImageView())

        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.height, height: 200)
    }



    var user: User?
    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snaphot, err  in
            guard let dictionary = snaphot.value as? [String: Any] else { return }
            self.user = User(dictionary: dictionary)
            self.navigationItem.title = self.user?.username
            self.collectionView?.reloadData()

            if let err = err {
                print(err)
            }

        }
    }
}

struct User {
    let username: String
    let profileImageUrl: String

    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
