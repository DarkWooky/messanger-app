//
//  MainTabBarController.swift
//  UChat
//
//  Created by Egor Mihalevich on 3.09.21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let currentUser: MUser
    
    init(currentUser: MUser = MUser(username: "Default",
                                    email: "Default",
                                    avatarStringURL: "Default",
                                    description: "Default",
                                    sex: "Default",
                                    id: "Default")) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listViewController = ListViewController(currentUser: currentUser)
        let peopleViewController = PeopleViewController(currentUser: currentUser)
        
        tabBar.tintColor = .systemPurple
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let convImage = UIImage(systemName: "bubble.left.and.bubble.right.fill", withConfiguration: boldConfig)
        let peopleImage = UIImage(systemName: "person.2.fill", withConfiguration: boldConfig)
        
        viewControllers = [
            generateNavigationController(rootViewController: peopleViewController, title: "People", image: peopleImage!),
            generateNavigationController(rootViewController: listViewController, title: "Conversations", image: convImage!)
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
