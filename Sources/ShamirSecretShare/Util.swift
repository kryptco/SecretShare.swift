import Foundation

extension UInt8 {
    var hex:String {
        return "0x" + String(format: "%02x", self)
    }
}

enum DataError : Error {
    case encoding
    case cryptoRandom
    case range(Range<Int>)
    case utfEncoding
}

extension Data {
    static func random(size:Int) throws -> Data {
        var result = [UInt8](repeating: 0, count: size)
        let res = SecRandomCopyBytes(kSecRandomDefault, size, &result)
        
        guard res == 0 else {
            throw DataError.cryptoRandom
        }
        
        return Data(bytes: result)
    }
    
    func utf8String() throws -> String {
        guard let utf8String = String(data: self, encoding: String.Encoding.utf8) else {
            throw DataError.utfEncoding
        }
        return utf8String
    }
    
    var bytes:[UInt8] {
        return self.withUnsafeBytes {
            [UInt8](UnsafeBufferPointer(start: $0, count: self.count))
        }
    }
    
    func toBase64(_ urlEncoded:Bool = false) -> String {
        var result = self.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        if urlEncoded {
            result = result.replacingOccurrences(of: "/", with: "_")
            result = result.replacingOccurrences(of: "+", with: "-")
        }
        
        return result
    }

}

extension String {
    func fromBase64() throws -> Data {
        var urlDecoded = self
        urlDecoded = urlDecoded.replacingOccurrences(of: "_", with: "/")
        urlDecoded = urlDecoded.replacingOccurrences(of: "-", with: "+")
        
        guard let data = Data(base64Encoded: urlDecoded, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) else {
            throw DataError.encoding
        }
        
        return data
    }
}

