//
//  AddPhotoView.swift
//  UChat
//
//  Created by Egor Mihalevich on 2.09.21.
//

import UIKit

class AddPhotoView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(circleImageView)
        addSubview(plusButton)
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    var circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.tintColor = UIColor(named: "projectColor")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let plusImage = #imageLiteral(resourceName: "plus")
        button.setImage(plusImage, for: .normal)
        button.tintColor = UIColor(named: "projectColor")
        return button
    }()

    // MARK: Private

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            circleImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            circleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            circleImageView.widthAnchor.constraint(equalToConstant: 100),
            circleImageView.heightAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            plusButton.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: 16),
            plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        self.bottomAnchor.constraint(equalTo: circleImageView.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        circleImageView.layer.masksToBounds = true
        circleImageView.layer.cornerRadius = circleImageView.frame.width / 2
    }
}
