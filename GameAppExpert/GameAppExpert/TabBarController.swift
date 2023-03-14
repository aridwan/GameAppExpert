//
//  TabBarViewController.swift
//  dicoding
//
//  Created by Mochammad Arief Ridwan on 07/02/23.
//

import UIKit
import Home
import Favorite
import About

public class TabBarController: UITabBarController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().backgroundColor = UIColor.black
        self.tabBar.isTranslucent = false
        tabBar.tintColor = .white
        setupVCs()
    }

  func setupVCs() {
    guard let gamesImage = UIImage(systemName: "gamecontroller.fill"), let favoritesImage = UIImage(systemName: "star.fill"), let profileImage = UIImage(systemName: "person.fill") else {return}
    
    guard let homeBundle = Bundle(identifier: "com.dicoding.academy.Home") else {return}
    guard let aboutBundle = Bundle(identifier: "com.dicoding.academy.About") else {return}
    guard let favoritesBundle = Bundle(identifier: "com.dicoding.academy.Favorite") else {return}
    
    let homeVC = HomeViewController(nibName: "HomeViewController", bundle: homeBundle)
    let favoritesVC = FavoriteViewController(nibName: "FavoriteViewController", bundle: favoritesBundle)
    let aboutVC = AboutViewController(nibName: "AboutViewController", bundle: aboutBundle)
    
    let homeUseCase = Injection.init().provideHome()
    let presenter = HomePresenter.init(homeUseCase: homeUseCase)
//    let favoritesPresenter = HomePresenter.init(homeUseCase: homeUseCase)
    
//    favoritesVC.presenter = favoritesPresenter
    homeVC.presenter = presenter
        viewControllers = [
            createNavController(for: homeVC, title: NSLocalizedString("Games", comment: ""), image: gamesImage),
            createNavController(for: favoritesVC, title: NSLocalizedString("Favorites", comment: ""), image: favoritesImage),
            createNavController(for: aboutVC, title: NSLocalizedString("About", comment: ""), image: profileImage)
        ]
    }
  
  fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
  
}
