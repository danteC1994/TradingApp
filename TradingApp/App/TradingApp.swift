//
//  TradingAppApp.swift
//  TradingApp
//
//  Created by dante canizo on 07/03/2024.
//

import Networking
import SwiftUI

@main
struct AppLauncher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            TradingApp.main()
        } else {
            TestApp.main()
        }
    }
}

struct TestApp: App {

    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}

struct TradingApp: App {
    var body: some Scene {
        WindowGroup {
            BookListFactory.emptyBookListView()
        }
    }
}
