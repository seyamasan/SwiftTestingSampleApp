//
//  FakeURLProtocol.swift
//  SwiftTestingSampleApp
//
//  Created by 瀬山皐太 on 2025/06/07.

import Foundation

/*
 Reference
 https://sussan-po.com/2022/08/17/mocking-url-session/#%E5%8F%82%E8%80%83%E3%81%AB%E3%81%99%E3%82%8B%E3%82%B5%E3%82%A4%E3%83%88
*/
final class FakeURLProtocol: URLProtocol {

    static var testURLs = [URL?: (error: Error?, data: Data?, response: URLResponse?)]()

    override class func canInit(with request: URLRequest) -> Bool {
        // Mock all requests(全リクエストをモックする)
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        // Requests are not normalized and remain as is.(リクエストは正規化せずそのまま)
        request
    }

    override func startLoading() {
        if let url = self.request.url {
            if let (error, data, response) = FakeURLProtocol.testURLs[url] {
                 
                 // Notify clients of response(レスポンスをクライアントに通知)
                 if let responseStrong = response {
                     self.client?.urlProtocol(self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
                 }
                 
                // Notify clients of data(データをクライアントに通知)
                 if let dataStrong = data {
                     self.client?.urlProtocol(self, didLoad: dataStrong)
                 }
                 
                // Notify clients of error(エラーをクライアントに通知)
                 if let errorStrong = error {
                     self.client?.urlProtocol(self, didFailWithError: errorStrong)
                 }
             }
         }

        // Notify end of loading(ローディングの終了を通知)
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // No implementation required(実装の必要なし)
    }
}
