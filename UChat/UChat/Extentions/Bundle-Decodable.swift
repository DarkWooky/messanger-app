//
//  Bundle-Decodable.swift
//  UChat
//
//  Created by Egor Mihalevich on 6.09.21.
//

import Foundation
import UIKit

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) fron bundle.")
        }
        guard let loaded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to load \(file) fron bundle.")
        }
        return loaded
    }
}
