//
//  OSCACoworkingFormContact.swift
//  OSCACoworking
//
//  Created by Ömer Kurutay on 25.04.22.
//

import OSCAEssentials
import Foundation

/// ```json
/// {
///    "description": "Coworking Space inside the Gründer und Technologiezentrum",
///    "email": "",
///    "location": {
///      "id: "CoworkingLocationId",
///      "address": {
///        "name": "coworkit",
///        "streetAddress": "Grünewalder-Str. 29-31",
///        "addressLocality": "Gründer und Technologiezentrum",
///        "postalCode": "42657"
///      },
///      "geopoint": {
///        "__type": "GeoPoint",
///        "latitude": 51.162517,
///        "longitude": 7.077970
///      }
///    },
///    "phone": "+49 212 24940",
///    "url": "https://coworkit.cobot.me/"
/// }
/// ```
public struct OSCACoworkingFormContact: Codable {
  /// Auto generated id
  public private(set) var objectId : String?
  /// UTC date when the object was created
  public private(set) var createdAt: Date?
  /// UTC date when the object was changed
  public private(set) var updatedAt: Date?
  /// Description of the coworking space
  public var description:   String?
  /// The email recipient of the coworking form
  public var email      :   String?
  /// The location of the event
  public var location   : Location?
  /// The phone number of the coworking space
  public var phone      :   String?
  /// The url of the coworking space
  public var url        :   String?
  
  // MARK: Location
  /// ```json
  /// {
  ///    "id": "CoworkingLocationId",
  ///    "address": {
  ///      "name": "coworkit",
  ///      "streetAddress": "Grünewalder-Str. 29-31",
  ///      "addressLocality": "Gründer und Technologiezentrum",
  ///      "postalCode": "42657"
  ///    },
  ///    "geopoint": {
  ///      "__type": "GeoPoint",
  ///      "latitude": 51.162517,
  ///      "longitude": 7.077970
  ///    }
  /// }
  /// ```
  public struct Location: Codable, Equatable, Hashable {
    /// The id of the event location
    public var id      :        String?
    /// The address of the event location
    public var address :       Address?
    /// The geopoint of the event location
    public var geopoint: ParseGeoPoint?
    
    public init(
      id      :        String?,
      address :       Address? = nil,
      geopoint: ParseGeoPoint?
    ) {
      self.id       = id
      self.address  = address
      self.geopoint = geopoint
    }
    
    // MARK: Address
    ///```json
    ///{
    ///  "name": "coworkit",
    ///  "streetAddress": "Grünewalder-Str. 29-31",
    ///  "addressLocality": "Gründer und Technologiezentrum",
    ///  "postalCode": "42657"
    ///}
    ///```
    public struct Address: Codable, Equatable, Hashable {
      /// The name of the event location
      public var name           : String?
      /// The street address of the event location
      public var streetAddress  : String?
      /// The locality of the event location
      public var addressLocality: String?
      /// The postal code of the event location
      public var postalCode     : String?
      
      public init(
        name           : String?,
        streetAddress  : String?,
        addressLocality: String?,
        postalCode     : String?
      ) {
        self.name            = name
        self.streetAddress   = streetAddress
        self.addressLocality = addressLocality
        self.postalCode      = postalCode
      }
    }
  }
}

extension OSCACoworkingFormContact: OSCAParseClassObject {
  /// Parse class name
  public static var parseClassName : String { return "CoworkingFormContact" }
}// end extension OSCACoworkingFormContact
