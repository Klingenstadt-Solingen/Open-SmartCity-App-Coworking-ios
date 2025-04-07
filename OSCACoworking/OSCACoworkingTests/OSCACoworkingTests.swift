//
//  OSCACoworkingTests.swift
//  OSCACoworkingTests
//
//  Created by Ömer Kurutay on 21.04.22.
//  Reviewed by Stephan Breidenbach on 21.06.22
//
#if canImport(XCTest) && canImport(OSCATestCaseExtension)
import OSCANetworkService
import Foundation
import Combine
import XCTest
import OSCATestCaseExtension
@testable import OSCACoworking

final class OSCACoworkingTests: XCTestCase {
  static let moduleVersion = "1.0.3"
  private var cancellables  : Set<AnyCancellable>!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    // initialize cancellables
    self.cancellables = []
  }// end override func setUpWithError
  
  func testModuleInit() throws -> Void {
    // init module
    let module = try makeDevModule()
    XCTAssertNotNil(module)
    XCTAssertEqual(module.bundlePrefix, "de.osca.coworking")
    XCTAssertEqual(module.version, OSCACoworkingTests.moduleVersion)
    // init bundle
    let bundle = OSCACoworking.bundle
    XCTAssertNotNil(bundle)
    XCTAssertNotNil(self.productionPlistDict)
    XCTAssertNotNil(self.devPlistDict)
  }// end func testModuleInit
}// end final class OSCACoworkingTests

// MARK: - factory methods
extension OSCACoworkingTests {
  public func makeDevModuleDependencies() throws -> OSCACoworkingDependencies {
    let networkService = try makeDevNetworkService()
    let userDefaults   = try makeUserDefaults(domainString: "de.osca.coworking")
    let dependencies = OSCACoworkingDependencies(
      networkService: networkService,
      userDefaults: userDefaults)
    return dependencies
  }// end public func makeDevModuleDependencies
  
  public func makeDevModule() throws -> OSCACoworking {
    let devDependencies = try makeDevModuleDependencies()
    // initialize module
    let module = OSCACoworking.create(with: devDependencies)
    return module
  }// end public func makeDevModule
  
  public func makeProductionModuleDependencies() throws -> OSCACoworkingDependencies {
    let networkService = try makeProductionNetworkService()
    let userDefaults   = try makeUserDefaults(domainString: "de.osca.coworking")
    let dependencies = OSCACoworkingDependencies(
      networkService: networkService,
      userDefaults: userDefaults)
    return dependencies
  }// end public func makeProductionModuleDependencies
  
  public func makeProductionModule() throws -> OSCACoworking {
    let productionDependencies = try makeProductionModuleDependencies()
    // initialize module
    let module = OSCACoworking.create(with: productionDependencies)
    return module
  }// end public func makeProductionModule
}// end extension final class OSCAEventsTests
#endif
