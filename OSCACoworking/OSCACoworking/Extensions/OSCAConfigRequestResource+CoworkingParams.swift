//
//  OSCAConfigRequestResource+CoworkingParams.swift
//  OSCACoworking
//
//  Created by Ömer Kurutay on 03.05.22.
//

import Foundation
import OSCANetworkService

extension OSCAConfigRequestResource {
  /// ConfigReqestRessource for coworking-form's config params
  /// - Parameters:
  ///   - baseURL: The base url of your parse-server
  ///   - headers: The authentication headers for parse-server
  /// - Returns: A ready to use OSCAConfigRequestResource
  static func coworkingFormParseConfig(baseURL: URL, headers: [String: CustomStringConvertible]) -> OSCAConfigRequestResource {
    return OSCAConfigRequestResource(
      baseURL: baseURL,
      headers: headers)
  }
}
