//
//  SettingsViewController.swift
//  UChat
//
//  Created by Egor Mikhalevich on 4.10.21.
//

import UIKit
import FirebaseFirestore

class SettingsViewController: UIViewController {
    
    let userAvatar = UIView()
    let label = UILabel(text: "nono", font: .helvetica20(), isHidden: false)
    
    private let currentUser: MUser

    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        setupView()
    }
    
    private func setupView() {
        
        userAvatar.backgroundColor = .blue
        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        view.addSubview(userAvatar)
        
        NSLayoutConstraint.activate([
            userAvatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userAvatar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userAvatar.heightAnchor.constraint(equalToConstant: 100),
            userAvatar.widthAnchor.constraint(equalToConstant: 100)])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
}
