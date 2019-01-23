//
//  SynologySwift.swift
//  SynologySwift
//
//  Created by Thomas le Gravier on 13/12/2018.
//  Copyright © 2018 Thomas Le Gravier. All rights reserved.
//

import Foundation


public class SynologySwift {
    
    public enum Result<T> {
        case success(T)
        case failure(ResultError)
    }
    
    public enum ResultError: Error {
        case requestError(SynologySwiftCoreNetwork.RequestError)
        case other(String)
    }
    
    /*
     * Public interfaces
     */
    
    /// Global connect login whole process
    public static func login(quickConnectid: String, login: String, password: String, completion: @escaping (SynologySwift.Result<SynologySwiftAuth.DSAuthInfos>) -> ()) {
        /* Get global DSM path infos */
        SynologySwift.resolveURL(quickConnectId: quickConnectid) { (dsInfos) in
            /* Get APIsInfos */
            SynologySwift.resolveAvailableAPIs(completion: { (apisInfos) in
                /* Start Auth login */
                SynologySwift.resolveLogin(login: login, password:  password, completion: completion)
            })
        }
    }
    
    /// Resolve DS reachable interface for a specific QuickConnectId
    public static func resolveURL(quickConnectId: String, completion: @escaping (SynologySwift.Result<SynologySwiftURLResolver.DSInfos>) -> ()) {
        SynologySwiftURLResolver.resolve(quickConnectId: quickConnectId, completion: completion)
    }
    
    /// List available APIs on specific DS
    public static func resolveAvailableAPIs(dsInfos: SynologySwiftURLResolver.DSInfos? = SynologySwiftURLResolver.dsResultInfos, completion: @escaping (SynologySwift.Result<SynologySwiftGlobalObjectMapper.APIsInfo>) -> ()) {
        SynologySwiftGlobal.resolveAvailableAPIs(dsInfos: dsInfos, completion: completion)
    }
    
    /// Auth connection with encryption
    public static func resolveLogin(dsInfos: SynologySwiftURLResolver.DSInfos? = SynologySwiftURLResolver.dsResultInfos, encryptionServicePath: String? = nil, authServicePath: String? = nil, login: String, password: String, completion: @escaping (SynologySwift.Result<SynologySwiftAuth.DSAuthInfos>) -> ()) {
        SynologySwiftAuth.login(dsInfos: dsInfos, encryptionServicePath: encryptionServicePath, authServicePath: authServicePath, login: login, password: password, completion: completion)
    }

}
