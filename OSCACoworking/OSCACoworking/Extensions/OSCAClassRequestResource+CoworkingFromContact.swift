//
//  OSCAClassRequestResource+CoworkingFromContact.swift
//  OSCACoworking
//
//  Created by Ömer Kurutay on 25.04.22.
//

import Foundation
import OSCANetworkService

extension OSCAClassRequestResource {
  /**
   ClassReqestRessource for coworking-form's contact
   
   ```console
   curl -vX GET \
    -H "X-Parse-Application-Id: ApplicationId" \
    -H "X-PARSE-CLIENT-KEY: ClientKey" \
    -H 'Content-Type: application/json' \
     'https://parse-dev.solingen.de/classes/CoworkingFormContact'
   ```
   - Parameters:
   - baseURL: The base url of your parse-server
   - headers: The authentication headers for parse-server
   - query: HTTP query parameters for the request
   - Returns: A ready to use OSCAClassRequestResource
   */
  static func coworkingFormContact(baseURL: URL, headers: [String: CustomStringConvertible], query: [String: CustomStringConvertible] = [:]) -> OSCAClassRequestResource {
    let parseClass = OSCACoworkingFormContact.parseClassName
    return OSCAClassRequestResource(baseURL: baseURL, parseClass: parseClass, parameters: query, headers: headers)
  }
}
