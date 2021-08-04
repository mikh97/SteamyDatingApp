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
    var userAPI: UserApi!

    //for setting up a new api test each run
    override func setUp() {
        super.setUp()
        user_api = UserApi()
    }

    //to tear down at the end of a run
    override func tearDown() {
        user_api = nil
    }

    //User API is a class where all of our user's interaction with the database occurs, these functions will be tested


    //For sprint 1, unit tests for signInTest, signUpTest, and resetPassword Test

    func testSignUp() {
        email = "neevalkumar@gmail.com"
        password = "password123"
        f_name = "Neeval"
        l_name = "Kumar"

        XCTAssertNoThrow( user_api.signUp(email: email, password: password, firstName: f_name, lastName: l_name))
    }

    func testSignInTest(){
        email = "neevalkumar@gmail.com"
        password = "password123"

        XCTAssertNoThrow(user_api.signIn(email: email, password: password))
    }

    // this will make sure the email for the password will throw no errors, however if no acount exists, you still will not get an email

    func testResetPasswordTest() {
        email = "neevalkumar@gmail.com"

        XCTAssertNoThrow(user_api.resetPassword(email, password))
    }


    // for sprint 2, update user profile and

    func testUpdateUserProfile(){
        let dict: Dictionary<String, Any> = [
            "firstName": "Neeval",
            "lastName": "Kumar",
            "age": "22",
            "gender": "Male"
        ]

        XCTAssertNoThrow(user_api.saveUserProfile(dict:dict))
    }


    func testGetGallery(){

        uid = "qweqweqweqweq"

        XCTAssertNoThrow(user_api.getGallery())
    }
    
    class ContentCollectionTests: XCTestCase {
        func testQueryingItemByID() {
            var collection = ContentCollection()

            let item = Item(id: "an-item", title: "A title")
            collection.add(item)

            let retrievedItem = collection.item(withID: "an-item")
            XCTAssertEqual(retrievedItem, item)
        }
    }
    
    class CacheTests: XCTestCase {
        func testPersistentMessages() {
            let cache = Cache()
            let item = Item(id: "an-item", message: "Hey now!")

            // persistence test:
            XCTAssertNil(cache.expirationDate(for: item))

            cache.insert(item)
            XCTAssertNotNil(cache.expirationDate(for: item))
        }
    }


    //sprint 3, test matchmaking, getting users

    func testLoadCardPeople(){
        XCTAssertNoThrow(user_api.loadCardPeople())
    }


    func testGetUserInfoSingleEvent() {
        XCTAssertNoThrow(user_api.getUserInfoSingleEvent(uid: "qweqweqweqweq"))
    }



    func testSignOut() {
        XCTAssertNoThrow(user_api.signOut())
    }



}


