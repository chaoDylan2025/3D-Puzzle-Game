//
//  SwiftUI_3D_Puzzle_GameUITestsLaunchTests.swift
//  SwiftUI-3D-Puzzle-GameUITests
//
//  Created by Dylan Chao on 4/8/25.
//

import XCTest

final class SwiftUI_3D_Puzzle_GameUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
