//
//  OSCAUploadClassRequestResource+CoworkingFromData.swift
//  OSCACoworking
//
//  Created by Ömer Kurutay on 25.04.22.
//

import Foundation
import OSCANetworkService

extension OSCAUploadClassRequestResource {
  /**
   ClassUploadRessource for coworking-form's data
   - Parameters:
   - baseURL: The base url of the parse-server
   - headers: The authentication headers for the parse-server
   - uploadParseClassObject: the parse class object requested for upload
   - Returns: A ready to use `OSCAUploadClassRequestResource`
   */
  static func coworkingFormData(baseURL: URL, headers: [String: CustomStringConvertible], uploadParseClassObject: OSCACoworkingFormData?) -> OSCAUploadClassRequestResource<OSCACoworkingFormData> {
    let parseClass = OSCACoworkingFormData.parseClassName
    return OSCAUploadClassRequestResource<OSCACoworkingFormData>(
      baseURL: baseURL,
      parseClass: parseClass,
      uploadParseClassObject: uploadParseClassObject,
      headers: headers)
  }
}
