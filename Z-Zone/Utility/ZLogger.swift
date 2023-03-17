//
//  ZLogger.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/17/23.
//

import Foundation

import Foundation
import os

enum LogLevel: String {
    case info
    case warn
    case error
}

enum LogCategory: String {
    case temp
}

class ZLogger {
    static let shared = ZLogger()
    
    func log(level: LogLevel, message: String, category: LogCategory) {
        print("\(level.rawValue): \(message)")
        guard let identifier = Bundle.main.bundleIdentifier, level == .error else {
            return
        }
        let logger = Logger(subsystem: identifier, category: category.rawValue)
        logger.log("\(message)")
    }
    
    func logError(message: String, category: LogCategory) {
        log(level: .error, message: message, category: category)
    }
}
