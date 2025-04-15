//
//  ListDataAppApp.swift
//  ListDataApp
//
//  Created by mac on 14/4/25.
//

import SwiftUI

@main
struct ListDataAppApp: App {
    var body: some Scene {
        WindowGroup {
            ClaimsListRouter.createModule()
        }
    }
}
