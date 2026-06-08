//
//  CustomerPulseTests.swift
//  CustomerPulseTests
//
//  Created by emilien on 10/11/2021.
//

import XCTest
@testable import CustomerPulse

class CustomerPulseTests: XCTestCase {

    // MARK: - Helpers

    /// Builds a CSWebView wired with spy closures that increment counters.
    private func makeWebView(
        dismissTimer: Int = 0
    ) -> (view: CSWebView, counts: Counts) {
        let counts = Counts()
        let webView = CSWebView(
            surveyURL: "https://example.com/survey",
            appId: "APP_ID",
            isDismissible: true,
            dismissTimer: dismissTimer,
            options: [:],
            completedCallback: { counts.completed += 1 },
            errorCallback: { counts.error += 1 },
            dismissedCallback: { counts.dismissed += 1 }
        )
        return (webView, counts)
    }

    /// Mutable invocation counters for the spy closures.
    private final class Counts {
        var completed = 0
        var error = 0
        var dismissed = 0
    }

    // MARK: - Routing tests (handle seam)

    func testErrorEvent_firesErrorCallbackOnce() {
        let (webView, counts) = makeWebView()

        webView.handle("so-widget-error")

        XCTAssertEqual(counts.error, 1)
        XCTAssertEqual(counts.completed, 0)
        XCTAssertEqual(counts.dismissed, 0)
    }

    func testClosedEvent_firesDismissedCallbackOnce() {
        let (webView, counts) = makeWebView()

        webView.handle("so-widget-closed")

        XCTAssertEqual(counts.dismissed, 1)
        XCTAssertEqual(counts.completed, 0)
        XCTAssertEqual(counts.error, 0)
    }

    func testUnknownEvent_firesNothingAndDoesNotCrash() {
        let (webView, counts) = makeWebView()

        webView.handle("garbage-event")
        webView.handle("open")
        webView.handle("")

        XCTAssertEqual(counts.completed, 0)
        XCTAssertEqual(counts.error, 0)
        XCTAssertEqual(counts.dismissed, 0)
    }

    func testCompletedEvent_firesCompletedCallback() {
        let (webView, counts) = makeWebView(dismissTimer: 0)

        // Completion dismisses (a no-op for a non-presented controller) then fires
        // the completed callback asynchronously on the main queue.
        let expectation = expectation(description: "completedCallback fires")
        let originalCallback = webView.completedCallback
        webView.completedCallback = {
            originalCallback?()
            expectation.fulfill()
        }

        webView.handle("so-widget-completed")

        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(counts.completed, 1)
        XCTAssertEqual(counts.error, 0)
        XCTAssertEqual(counts.dismissed, 0)
    }

    func testErrorEvent_doesNotInvokeCompletionOrDismiss() {
        let (webView, counts) = makeWebView()

        webView.handle("so-widget-error")
        webView.handle("so-widget-closed")

        // Each event routes to exactly its own callback, exactly once.
        XCTAssertEqual(counts.error, 1)
        XCTAssertEqual(counts.dismissed, 1)
        XCTAssertEqual(counts.completed, 0)
    }

    // MARK: - Backward-compatibility: optional delegate methods

    /// A delegate implementing ONLY the original `csUserCompletedSurvey()` must
    /// still conform to `CustomerPulseDelegate` (the new methods are optional via
    /// the protocol extension default implementations).
    private final class LegacyDelegate: CustomerPulseDelegate {
        var completedCalled = false
        func csUserCompletedSurvey() {
            completedCalled = true
        }
    }

    func testLegacyDelegate_conformsAndDefaultsAreCallable() {
        let delegate: CustomerPulseDelegate = LegacyDelegate()

        // The optional methods are callable on the protocol type thanks to the
        // extension defaults — this must compile and not crash.
        delegate.csUserCompletedSurvey()
        delegate.csUserSurveyError()
        delegate.csUserDismissedSurvey()

        XCTAssertTrue((delegate as? LegacyDelegate)?.completedCalled == true)
    }
}
