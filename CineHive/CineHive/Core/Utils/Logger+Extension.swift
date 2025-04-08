//
//  Logger+Extension.swift
//  CineHive
//
//  Created by 이종민 on 2/28/25.
//

import OSLog

extension Logger {
    private static func timestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter.string(from: Date())
    }
    
    
    static let networking = Logger(subsystem: "kr.co.Cine-Hive.CineHive", category: "Networking")
    static let ui = Logger(subsystem: "kr.co.Cine-Hive.CineHive", category: "UI")
    static let auth = Logger(subsystem: "kr.co.Cine-Hive.CineHive", category: "Authentication")
    static let state = Logger(subsystem: "kr.co.Cine-Hive.CineHive", category: "StateManagement")
    
    // 타임스탬프 함께 출력하는 로그
    // 카테고리 : error, warning, failure, info, debug, fault
    static func log(_ level: OSLogType, category: Logger, message: String,
                    file: String = #fileID, function: String = #function, line: Int = #line) {
        let logMessage = "[\(timestamp())] [\(file):\(line)] \(function) \(message)"
        category.log(level: level, "\(logMessage)")
    }
    
    // 디버깅용 메시지 (DEBUG 모드에서만 로그 출력)
    static func debug(_ message: String) {
        #if DEBUG
        Logger(subsystem: "kr.co.Cine-Hive.CineHive", category: "Debug").debug("\(message)")
        #endif
    }
}
