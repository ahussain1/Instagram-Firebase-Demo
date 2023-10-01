//
//  MainTabBarController.swift
//  InstagramDemo
//
//  Created by Arif  on 9/24/23.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()



        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout )
        let navController = UINavigationController(rootViewController: userProfileController)
        navController.tabBarItem.image = UIImage(systemName: "person")
        navController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        tabBar.tintColor = .black

        navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance;

        viewControllers = [navController, UIViewController()]
    }
}
