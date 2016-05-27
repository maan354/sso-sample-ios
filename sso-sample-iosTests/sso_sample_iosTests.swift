//
//  sso_sample_iosTests.swift
//  sso-sample-iosTests
//
//  Created by Mathew Spolin on 5/4/16.
//  Copyright © 2016 AppDirect. All rights reserved.
//

import XCTest
@testable import sso_sample_ios

class sso_sample_iosTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatObjectCanBeCreatedFromUrl() {
        let didParseUrl = expectationWithDescription("testThatObjectCanBeCreatedFromUrl")
        
        let testUrl = "http://172.20.5.68:8080/?redirect=sso-sample://return/user={\"password\"%3A\"*********\"%2C\"userName\"%3A\"kaligan%40gmail.com\"%2C\"authorities\"%3A[{\"authority\"%3A\"ROLE_USER\"}]}"
        
        if let userObject = UserObject.objectFromUrl(testUrl) {
            
            XCTAssertEqual(userObject.info["userName"] as? String, "kaligan@gmail.com")
            XCTAssertEqual(userObject.info["password"] as? String, "*********")
            XCTAssertNotNil(userObject.info["authorities"] as? [[String:AnyObject]])
            
            if let authorities = userObject.info["authorities"] as? [[String:AnyObject]] {
                if authorities.count > 0 {
                    XCTAssertEqual(authorities[0]["authority"] as? String, "ROLE_USER")
                    didParseUrl.fulfill()
                }
            }
        }
        
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
}
