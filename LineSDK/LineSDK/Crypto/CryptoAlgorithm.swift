//
//  CryptoAlgorithm.swift
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
import CommonCrypto

typealias CryptoDigest = (
    _ data: UnsafeRawPointer?,
    _ length: CC_LONG,
    _ md: UnsafeMutablePointer<UInt8>?) -> UnsafeMutablePointer<UInt8>?

/// Represents an algorithm used in crypto.
protocol CryptoAlgorithm {
    var length: CC_LONG { get }
    var signatureAlgorithm: SecKeyAlgorithm { get }
    var encryptionAlgorithm: SecKeyAlgorithm { get }
    var digest: CryptoDigest { get }
}

extension Data {

    /// Calculate the digest with a given algorithm.
    ///
    /// - Parameter algorithm: The algorithm be used. It should provice a digest hash method at least.
    /// - Returns: The digest data.
    func digest(using algorithm: CryptoAlgorithm) -> Data {
        var hash = [UInt8](repeating: 0, count: Int(algorithm.length))
        withUnsafeBytes { _ = algorithm.digest($0, CC_LONG(count), &hash) }
        return Data(bytes: hash)
    }
}
