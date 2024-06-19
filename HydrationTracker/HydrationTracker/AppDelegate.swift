//
//  AppDelegate.swift
//  HydrationTracker
//
//  Created by Sudharshan on 15/06/24.
//

import UIKit
import CoreData
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                self.scheduleNotifications()
            }
        }
        
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    // Handle notification when app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    // Handle notification when user taps on it
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        
        // Extract the root view controller
        if let rootViewController = window?.rootViewController {
            // Find the main storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let hydrationViewController = storyboard.instantiateViewController(withIdentifier: "WaterIntakeViewController") as? WaterIntakeViewController {
                rootViewController.present(hydrationViewController, animated: true) {
                    // Call the specific function
                    hydrationViewController.addWaterLog()
                }
            }
        }
        
        completionHandler()
    }
    
    func scheduleNotifications() {
        
        let times = [
                (hour: 9, minute: 0),
                (hour: 12, minute: 0),
                (hour: 15, minute: 0),
                (hour: 18, minute: 0),
                (hour: 21, minute: 0)
            ]
        
        for (index, time) in times.enumerated() {
                let content = UNMutableNotificationContent()
                content.title = "Hydration Reminder"
                content.body = "Don't forget to drink water and stay hydrated!"
                content.sound = .default

                var dateComponents = DateComponents()
                dateComponents.hour = time.hour
                dateComponents.minute = time.minute
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                let request = UNNotificationRequest(identifier: "hydrationReminder\(index)", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Error adding notification: \(error.localizedDescription)")
                    } else {
                        print("Notification scheduled for \(time.hour):\(time.minute)")
                    }
                }
            }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "HydrationTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

