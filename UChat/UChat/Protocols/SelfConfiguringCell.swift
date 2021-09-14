//
//  SelfConfiguringCell.swift
//  UChat
//
//  Created by Egor Mihalevich on 6.09.21.
//

import Foundation

// MARK: - SelfConfiguringCell

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
