//
//  CryptoUtils.swift
//  FlightAssistant
//
//  Created by Joao Duarte on 08/04/2024.
//

import Foundation
import CryptoKit

final class CryptoUtils: NSObject {
  static private func symmetricKey(from keyString: String = "igkjh4jk23h4kl32h4kjg23h4lk23hl4kjh23gjk4g23jk4h23") -> SymmetricKey {
    var sha256 = SHA256()
    let keyData = keyString.data(using: .utf8)!
    sha256.update(data: keyData)
    let hashedKeyData = Data(sha256.finalize())
    return SymmetricKey(data: hashedKeyData)
  }
  
  static private func encodeAndEncryptString(_ string: String, withKey key: String = "fhiweuqgfhnwe hiuofynhcweir786e78f6ewfe") -> String? {
    if let data = string.data(using: .utf8) {
      if let str = encodeAndEncryptData(data, withKey: key) {
        return str
      }
    }
    return nil
  }
  
  static private func encodeAndEncryptData(_ data: Data, withKey key: String = "rwetfewrfverwjghvuewygvhjkewbvfuyie3wh32") -> String? {
    if let encryptedData = try? AES.GCM.seal(data, using: symmetricKey(from: key)).combined {
      return encryptedData.base64EncodedString()
    }
    return nil
  }
  
  static private func decryptAndDecodeString(_ encrypted: String, withKey key: String = "igkjh4jk23h4kl32h4kjg23h4lk23hl4kjh23gjk4g23jk4h23") -> String? {
    if let encryptedData = decryptAndDecodeData(encrypted, withKey: key) {
      return String(decoding: encryptedData, as: UTF8.self)
    }
    return nil
  }
  
  static private func decryptAndDecodeData(_ encrypted: String, withKey key: String = "fedwfweqfewfewfw23ef3223ewgfrgdesgwe") -> Data? {
    if let data = Data(base64Encoded: encrypted) {
      if let encryptedData = try? AES.GCM.SealedBox(combined: data) {
        if let decryptedData = try? AES.GCM.open(encryptedData, using: symmetricKey(from: key)) {
          return decryptedData
        }
      }
    }
    return nil
  }
  
  static func encode(_ input: String, withKey key: String) -> String? {
    return encodeAndEncryptString(input, withKey: key)
  }
  
  static func decode(_ input: String, withKey key: String) -> String? {
    return decryptAndDecodeString(input, withKey: key)
  }
}

