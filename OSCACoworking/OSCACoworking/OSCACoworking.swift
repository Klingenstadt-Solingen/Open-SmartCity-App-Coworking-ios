//
//  OSCACoworking.swift
//  OSCACoworking
//
//  Created by Ömer Kurutay on 21.04.22.
//  Reviewed by Stephan Breidenbach 21.06.22
//

import Combine
import Foundation
import OSCAEssentials
import OSCANetworkService

public struct OSCACoworkingDependencies {
  let networkService: OSCANetworkService
  let userDefaults: UserDefaults
  let analyticsModule: OSCAAnalyticsModule?
  public init(networkService: OSCANetworkService,
              userDefaults: UserDefaults,
              analyticsModule: OSCAAnalyticsModule? = nil
  ) {
    self.networkService = networkService
    self.userDefaults = userDefaults
    self.analyticsModule = analyticsModule
  } // end public init
} // end public struct OSCACoworkingDependencies

public struct OSCACoworking: OSCAModule {
  /// module DI container
  var moduleDIContainer: OSCACoworkingDIContainer!

  let transformError: (OSCANetworkError) -> OSCACoworkingError = { networkError in
    switch networkError {
    case OSCANetworkError.invalidResponse:
      return OSCACoworkingError.networkInvalidResponse
    case OSCANetworkError.invalidRequest:
      return OSCACoworkingError.networkInvalidRequest
    case let OSCANetworkError.dataLoadingError(statusCode: code, data: data):
      return OSCACoworkingError.networkDataLoading(statusCode: code, data: data)
    case let OSCANetworkError.jsonDecodingError(error: error):
      return OSCACoworkingError.networkJSONDecoding(error: error)
    case OSCANetworkError.isInternetConnectionError:
      return OSCACoworkingError.networkIsInternetConnectionFailure
    } // end switch case
  } // end let transformOSCANetworkErrorToOSCACoworkingError closure

  /// Moduleversion
  public var version: String = "1.0.3"
  /// Bundle prefix of the module
  public var bundlePrefix: String = "de.osca.coworking"
  /// module `Bundle`
  ///
  /// **available after module initialization only!!!**
  public internal(set) static var bundle: Bundle!

  private var networkService: OSCANetworkService

  public private(set) var userDefaults: UserDefaults

  /**
   create module and inject module dependencies

   ** This is the only way to initialize the module!!! **
   - Parameter moduleDependencies: module dependencies
   ```
   call: OSCACoworking.create(with moduleDependencies)
   ```
   */
  public static func create(with moduleDependencies: OSCACoworkingDependencies) -> OSCACoworking {
    var module: Self = Self(networkService: moduleDependencies.networkService,
                            userDefaults: moduleDependencies.userDefaults)
    module.moduleDIContainer = OSCACoworkingDIContainer(dependencies: moduleDependencies)

    return module
  } // end public static func create

  /// Initializes the coworking module
  /// - Parameter networkService: Your configured network service
  private init(networkService: OSCANetworkService,
               userDefaults: UserDefaults) {
    self.networkService = networkService
    self.userDefaults = userDefaults
    var bundle: Bundle?
    #if SWIFT_PACKAGE
      bundle = Bundle.module
    #else
      bundle = Bundle(identifier: bundlePrefix)
    #endif
    guard let bundle: Bundle = bundle else { fatalError("Module bundle not initialized!") }
    Self.bundle = bundle
  } // end public init
} // end public struct OSCACoworking

extension OSCACoworking {
  /**
   Downloads coworking-form's contact data from parse server
   - Parameters:
   - limit: Limits the amount of coworking-form's contacts that gets downloaded from the server
   - query: HTTP query parameter
   - Returns: An array of coworking-form's contacts
   */
  public func getCoworkingFormContacts(limit: Int = 1000, query: [String: String] = [:]) -> AnyPublisher<Result<[OSCACoworkingFormContact], Error>, Never> {
    var parameters = query
    parameters["limit"] = "\(limit)"

    var headers = networkService.config.headers
    if let sessionToken = userDefaults.string(forKey: "SessionToken") {
      headers["X-Parse-Session-Token"] = sessionToken
    }

    return networkService
      .download(OSCAClassRequestResource
        .coworkingFormContact(baseURL: networkService.config.baseURL,
                              headers: headers,
                              query: parameters))
      .map { .success($0) }
      .catch { error -> AnyPublisher<Result<[OSCACoworkingFormContact], Error>, Never> in .just(.failure(error)) }
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .receive(on: OSCAScheduler.mainScheduler)
      .eraseToAnyPublisher()
  } // end public func getCoworkingFormContacts

  /// Downloads all config parameters declared in `OSCACoworkingParseConfig` from parse-server
  public func getParseConfigParams() -> AnyPublisher<Result<OSCACoworkingParseConfig, Error>, Never> {
    var headers = networkService.config.headers
    if let sessionToken = userDefaults.string(forKey: "SessionToken") {
      headers["X-Parse-Session-Token"] = sessionToken
    }

    return networkService
      .download(OSCAConfigRequestResource
        .coworkingFormParseConfig(baseURL: networkService.config.baseURL,
                                  headers: headers))
      .map { .success($0) }
      .catch { error -> AnyPublisher<Result<OSCACoworkingParseConfig, Error>, Never> in .just(.failure(error)) }
      .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
      .receive(on: OSCAScheduler.mainScheduler)
      .eraseToAnyPublisher()
  } // end public func getParseConfigParams

  /**
   Uploads coworking-form's data to parse server
   - Parameter coworkingFormData: coworking-form's data object
   - Returns: `ParseUploadResponse`
   */
  public func send(coworkingFormData: OSCACoworkingFormData) -> AnyPublisher<Result<ParseUploadResponse, Error>, Never> {
    var headers = networkService.config.headers
    if let sessionToken = userDefaults.string(forKey: "SessionToken") {
      headers["X-Parse-Session-Token"] = sessionToken
    }

    let anyPublisher: AnyPublisher<Result<ParseUploadResponse, Error>, Never> =
      networkService
        .upload(OSCAUploadClassRequestResource<OSCACoworkingFormData>
          .coworkingFormData(baseURL: networkService.config.baseURL,
                             headers: headers,
                             uploadParseClassObject: coworkingFormData))
        .map { .success($0) }
        .catch { error -> AnyPublisher<Result<ParseUploadResponse, Error>, Never> in
          .just(.failure(error))
        }
        .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
        .receive(on: OSCAScheduler.mainScheduler)
        .eraseToAnyPublisher()
    return anyPublisher
  } // end public func send
} // end extension public struct OSCACoworking
