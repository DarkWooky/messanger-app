//
//  ViewController.swift
//  ChatU
//
//  Created by Egor Mihalevich on 31.08.21.
//

import UIKit

class AuthViewController: UIViewController {
    
    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Or sign up with")
    let alreadyOnboardLabel = UILabel(text: "Already onboard?")
    
    let googleButton = UIButton(title: "Google", titleColor: .systemPurple, backgroundColor: .systemGray, isShadow: true)
    let emailButton = UIButton(title: "Email", titleColor: .systemGray6, backgroundColor: .systemPurple)
    let loginButton = UIButton(title: "Login", titleColor: .systemPurple, backgroundColor: .systemGray6, isShadow: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        assignBackground()
    }
    
    
}




















// MARK: - Canvas

import SwiftUI

struct AuthVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().preferredColorScheme(.light).edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = AuthViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) -> AuthViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: AuthVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) {
            
        }
    }
}
