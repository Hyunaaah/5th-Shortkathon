//
//  AppDelegate.swift
//  5ht-Shortkathon
//
//  Created by 주현아 on 5/24/25.
//

import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // MARK: - 알림 버튼 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        switch response.actionIdentifier {
        case "START_ACTION":
            print("▶️ 시작하기 버튼 눌림 - 앱 열기")
        case "SNOOZE_ACTION":
            print("⏰ 미루기 버튼 눌림 - 앱은 열리지 않음")
        default:
            break
        }

        completionHandler()
    }
}
