//
//  Extensions.swift
//  ToDoListApp
//
//  Created by Нурик  Генджалиев   on 26.03.2025.
//

import Foundation
extension Int {
    func toUUID() -> UUID {
            var uuidBytes = [UInt8](repeating: 0, count: 16)
            withUnsafeBytes(of: self) { intBytes in
                uuidBytes.replaceSubrange(0..<MemoryLayout<Int>.size, with: intBytes)
            }
            return UUID(uuid: (uuidBytes[0], uuidBytes[1], uuidBytes[2], uuidBytes[3],
                         uuidBytes[4], uuidBytes[5], uuidBytes[6], uuidBytes[7],
                         uuidBytes[8], uuidBytes[9], uuidBytes[10], uuidBytes[11],
                         uuidBytes[12], uuidBytes[13], uuidBytes[14], uuidBytes[15]))
        }
}

