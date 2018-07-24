//
//  LoginConfiguration.swift
//
//  Copyright (c) 2016-present, LINE Corporation. All rights reserved.
//
//  You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
//  copy and distribute this software in source code or binary form for use
//  in connection with the web services and APIs provided by LINE Corporation.
//
//  As with any software that integrates with the LINE Corporation platform, your use of this software
//  is subject to the LINE Developers Agreement [http://terms2.line.me/LINE_Developers_Agreement].
//  This copyright notice shall be included in all copies or substantial portions of the software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation

public protocol LoginManagerDelegate: class {
    func loginManager(_ manager: LoginManager, didSucceed loginProcess: LoginProcess, withResult: LoginResult)
    func loginManager(_ manager: LoginManager, didFail loginProcess: LoginProcess, withError: Error)
}

extension LoginManagerDelegate {
    
}

public class LoginManager {
    
    public static let shared = LoginManager()
    
    public private(set) var currentProcess: LoginProcess?
    
    var configuration: LoginConfiguration?
    
    private init() { }
    
    public func setup(channelID: String) {
        guard configuration == nil else {
            Log.assertionFailure("Trying to set configuration multiplet times is not permitted.")
            return
        }
        
        let config = LoginConfiguration(channelID: channelID)
        self.configuration = config
        Session.shared = Session(configuration: config)
    }
    
    public func login(permissions: Set<LoginPermission> = [], in viewController: UIViewController? = nil) -> LoginProcess? {
        guard currentProcess == nil else {
            Log.assertionFailure("Trying to start another login process while the previous one still valid is not permitted.")
            return nil
        }

        fatalError()
    }
}
