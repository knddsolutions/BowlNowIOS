//
//  CodableBundleExtension.swift
//  BowlNow
//
//  Created by Kyle Cermak on 2/19/21.
//

import Foundation

extension Bundle {
    func decode(_ file: String) -> [CenterData] {
        // 1. Locate the json file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        // 2. Create a property for the data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        // 3. Create the decoder
        let decoder = JSONDecoder()
        // 4. Create a property for the decoded data
        guard let loaded = try? decoder.decode([CenterData].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        // 5. Return the data
        return loaded
    }
}
