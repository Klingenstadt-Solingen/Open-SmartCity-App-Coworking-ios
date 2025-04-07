//
//  OSCACoworkingFormData.swift
//  OSCACoworking
//
//  Created by Ömer Kurutay on 25.04.22.
//  Reviewed by Stephan Breidenbach on 01.02.23
//

import Foundation
import OSCAEssentials

/// A data object of the coworking form.
public struct OSCACoworkingFormData: Codable {
  /// Auto generated id
  public private(set) var objectId : String?
  /// UTC date when the object was created
  public private(set) var createdAt: Date?
  /// UTC date when the object was changed
  public private(set) var updatedAt: Date?
  /// The street and house number of the sender
  public var address:    String?
  /// The city of the sender
  public var city:       String?
  /// The company of the sender
  public var company:    String?
  /// The reference to the `CoworkingFormContacts` objectId
  public var contactId:  String?
  /// The requested date of the sender
  public var date:       ParseDate?
  /// The email of the sender
  public var email:      String?
  /// The requested location of the sender
  public var message:    String?
  /// The full name of the sender
  public var name:       String?
  /// The phone number of the sender
  public var phone:      String?
  /// The postal code of the sender
  public var postalCode: String?
  
  public init(
    objectId:   String? = nil,
    createdAt:  String? = nil,
    updatedAt:  String? = nil,
    address:    String? = nil,
    city:       String? = nil,
    company:    String? = nil,
    contactId:  String?,
    date:       ParseDate?,
    email:      String?,
    message:    String?,
    name:       String?,
    phone:      String? = nil,
    postalCode: String? = nil
  ) {
    self.address    = address
    self.city       = city
    self.company    = company
    self.contactId  = contactId
    self.date       = date
    self.email      = email
    self.message    = message
    self.name       = name
    self.phone      = phone
    self.postalCode = postalCode
  }
}

extension OSCACoworkingFormData: OSCAParseClassObject {}

extension OSCACoworkingFormData {
  /// Parse class name
  public static var parseClassName : String { return "CoworkingFormData" }
}// end extension OSCACoworkingFormData
