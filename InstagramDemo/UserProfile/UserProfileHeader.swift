//
//  UserProfileHeader.swift
//  InstagramDemo
//
//  Created by Arif  on 10/1/23.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class UserProfileHeader: UICollectionViewCell {

    let profileImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        addSubview(profileImageView)

        profileImageView.anchor(top: topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80/2
        profileImageView.clipsToBounds = true
    }

    var user: User? {
        didSet {
            setupProfileImage()
        }
    }

    fileprivate func setupProfileImage() {
        print("Did set\(user?.username)")
        guard let profileImageUrl = user?.profileImageUrl else { return }
        guard let url = URL(string: profileImageUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch profile image: ", err)
                return
            }

            // check for response status of 200
            guard let data = data else { return }
            let image = UIImage(data: data)
            // need to get back on the main thread
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }.resume()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
