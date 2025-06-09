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

    static var testURLs = [URL?: Data]()

    override class func canInit(with request: URLRequest) -> Bool {
        // Mock all requests(全リクエストをモックする)
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        // Requests are not normalized and remain as is.(リクエストは正規化せずそのまま)
        request
    }

    override func startLoading() {
        if
            let url = request.url,  // requestはInstance Property
            let data = FakeURLProtocol.testURLs[url]
        {
            // Create a response(レスポンスを作って)
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200, // 200 == success
                httpVersion: "HTTP/2",
                headerFields: nil
            )!

            // Notifies the client that a response has been received(レスポンスを受信したことをクライアントに通知)
            client?.urlProtocol(
                self,
                didReceive: response,
                cacheStoragePolicy: .notAllowed
            )

            // Notify clients of data(データをクライアントに通知)
            client?.urlProtocol(
                self,
                didLoad: data
            )
        }

        // Notify end of loading(ローディングの終了を通知)
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // No implementation required(実装の必要なし)
    }
}
