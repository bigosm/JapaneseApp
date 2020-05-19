//
//  APIRequests+Default.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 16/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

extension APIRequest {
    var baseURL: URL { NetworkConfig.BaseURL.standard }
    var contentType: ContentType { .json }
    var responseContentType: ContentType { .json }
    var requiresAuth: Bool { true }
    var params: [URLQueryItem]? { nil }
    var body: String? { nil }
}
