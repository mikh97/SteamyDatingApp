//
//  SteamyTests.swift
//  SteamyTests
//
//  Created by Mikhail Sumawan on 7/12/21.
//

import XCTest
@testable import Steamy

class SteamyTests: XCTestCase {
    
    //The unit test setup for login and signup view
    var loginCredentials: LoginView!
    var signUpCredentials: SignUpView!
    
    override func setUp() {
        super.setUp()
        loginCredentials = LoginView()
        signUpCredentials = SignUpView()
    }
    
    override func tearDown() {
        loginCredentials = nil
        signUpCredentials = nil
    }
    
    //Create test cases for the login credentials to make sure the method works
    func test_is_valid_login_credentials() throws {
//        loginCredentials.email = "kimw2bin@gmail.com"
//        let isValidEmail = loginCredentials.$email
//        XCTAssertTrue(isValidEmail, "email is not valid")
        
    }
        
    func testSignUpNameInput(){
        
    }
    
    func testSingUpPasswordInput() {
        
    }
    
}
