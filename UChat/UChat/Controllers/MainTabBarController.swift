//
//  MainTabBarController.swift
//  UChat
//
//  Created by Egor Mihalevich on 3.09.21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listViewController = ListViewController()
        let peopleViewController = PeopleViewController()
        
        tabBar.tintColor = .systemPurple
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let convImage = UIImage(systemName: "bubble.left.and.bubble.right.fill", withConfiguration: boldConfig)
        let peopleImage = UIImage(systemName: "person.2.fill", withConfiguration: boldConfig)
        
        viewControllers = [
            generateNavigationController(rootViewController: listViewController, title: "Conversations", image: convImage!),
            generateNavigationController(rootViewController: peopleViewController, title: "People", image: peopleImage!)
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
