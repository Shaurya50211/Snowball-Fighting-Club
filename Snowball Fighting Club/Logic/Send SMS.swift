//
//  Send SMS.swift
//  Snowball Fighting Club
//
//  Created by Shaurya Gupta on 2022-12-31.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct SendSMS {

    mutating func doStuff(phoneNumber: String, message: String) {
        let semaphore = DispatchSemaphore (value: 0)

        let parameters = "To=%2B\(phoneNumber)&MessagingServiceSid=KEYCODE&Body=\(message)"
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://api.twilio.com/2010-04-01/Accounts/KEYCODE/Messages.json")!,timeoutInterval: Double.infinity)
        request.addValue("Basic KEYCODE==", forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()

    }
}
