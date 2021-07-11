//
//  Validation.swift
//  Steamy
//
//  Created by Mikhail Sumawan on 6/30/21.
//

//import Foundation
//
//struct Validation {
//
//    func validateInput(_ input: String?) throws -> String {
//        guard !first_name.isEmpty,
//              !last_name.isEmpty,
//              !email.isEmpty,
//              !password.isEmpty,
//              !confirm_password.isEmpty
//        else {
//            throw ValidationError.emptyValue
//        }
//    }
//
//    func validateName(_ name: String?) throws -> String {
//        let firstNameCharacters = CharacterSet.decimalDigits
//        let firstNameRange = first_name.rangeOfCharacter(from: firstNameCharacters)
//        if firstNameRange != nil {
//            throw ValidationError.nameWithInteger
//        }
//
//        let lastNameCharacters = CharacterSet.decimalDigits
//        let lastNameRange = last_name.rangeOfCharacter(from: lastNameCharacters)
//        if lastNameRange != nil {
//            throw ValidationError.nameWithInteger
//        }
//    }
//
//    func validatePassword(_ password: String?) throws -> String {
//        if password != confirm_password {
//            throw ValidationError.passwordNotMatch
//        } else if password.count < 6 {
//            throw ValidationError.passwordTooShort
//        } else if password.count >= 20 {
//            throw ValidationError.passwordTooLong
//        }
//    }
//}
//
//enum ValidationError: LocalizedError {
//    case emptyValue
//    case nameWithInteger
//    case passwordNotMatch
//    case passwordTooShort
//    case passwordTooLong
//
//    var errorDescription: String? {
//        switch self {
//        case .emptyValue:
//            return "Complete all the fields."
//        case .nameWithInteger:
//            return "Name cannot contain integer."
//        case .passwordNotMatch:
//            return "Password not match."
//        case .passwordTooShort:
//            return "Password too short."
//        case .passwordTooLong:
//            return "Password too long."
//        }
//    }
//}
