//
//  Keys.swift
//  faeBeta
//
//  Created by blesssecret on 5/18/16.
//  Copyright © 2016 fae. All rights reserved.
//

import Foundation
import UIKit

var userToken : String!
var userTokenEncode : String!
var session_id : NSNumber!
var user_id : NSNumber!
var is_Login : Int = 0
var userEmail : String!
var userPassword : String!
let GoogleMapKey = "AIzaSyC7Wxy8L4VFaTdzC7vbD43ozVO_yUw4DTk"

var username : String?

var userStatus : Int?
var userStatusMessage : String?

var userFirstname : String?
var userLastname : String?
var userBirthday : String? // yyyy-MM-dd
var userGender : Int? // 0 means male 1 means female
var userPhoneNumber : String?

var userEmailVerified : Bool = false
var userPhoneVerified : Bool = false

var arrayNameCard = [Int:UIImage]()
//var arrayNameCard : [Int: UIImage]!

func headerAuthentication()->[String : AnyObject] {
    if userTokenEncode != nil && userTokenEncode != "" {
        return ["Authorization":userTokenEncode]
    }
    if is_Login == 1 && userTokenEncode != nil {
        return ["Authorization":userTokenEncode]
    }
    let shareAPI = LocalStorageManager()
    if let encode=shareAPI.readByKey("userTokenEncode") as? String {
        userTokenEncode = encode 
        return ["Authorization":userTokenEncode]
    }
    return [:]
}
