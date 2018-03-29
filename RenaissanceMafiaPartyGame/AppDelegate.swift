//
//  AppDelegate.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let managedContext = persistentContainer.viewContext
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("Core data")
        print(urls[urls.count-1] as URL)
        
        do {
            let players: [Player] = try managedContext.fetch(Player.fetchRequest())
            if players.count == 0 {
                for i in 0..<7 {
                    let player = Player(context: managedContext)
                    switch i {
                    case 0:
                        player.name = "Przemek"
                    case 1:
                        player.name = "Daria"
                    case 2:
                        player.name = "Igor"
                    case 3:
                        player.name = "Koksu"
                    case 4:
                        player.name = "Marzena"
                    case 5:
                        player.name = "Robert"
                    case 6:
                        player.name = "Krzysiu"
                    default:
                        player.name = "Other"
                    }
                }
            }
            
            let classes: [GameClass] = try managedContext.fetch(GameClass.fetchRequest())
            
            if classes.count == 0 {
                for i in 0..<7 {
                    let newClass = GameClass(context: managedContext)
                    switch i {
                    case 0:
                        newClass.name = "Knight"
                        newClass.isGood = true
                        newClass.about = "One of lawful characters that know nothing."
                        newClass.isAdditional = false
                    case 1:
                        newClass.name = "Wizard"
                        newClass.isGood = true
                        newClass.about = "One of lawful characters that know everything about other players."
                        newClass.isAdditional = false
                    case 2:
                        newClass.name = "Bandit"
                        newClass.isGood = false
                        newClass.about = "Evil character that know about other evil characters"
                        newClass.isAdditional = false
                    case 3:
                        newClass.name = "Assassin"
                        newClass.isGood = false
                        newClass.about = "Evil character that know about other evil characters. Moreover, at the end of game you can kill Merlin."
                        newClass.isAdditional = false
                    case 4:
                        newClass.name = "Warlock"
                        newClass.isGood = false
                        newClass.about = "Warlocks is evil character that has magical power, therefore is seen by psychic."
                        newClass.isAdditional = true
                    case 5:
                        newClass.name = "Psychic"
                        newClass.isGood = true
                        newClass.about = "Psychic is good character that can sense people with power. Therefore know who is Wizard and Warlock"
                        newClass.isAdditional = true
                    case 6:
                        newClass.name = "Outcast"
                        newClass.isGood = false
                        newClass.about = "Evil character that hides from everyone, even other evil characters"
                        newClass.isAdditional = true
                    default:
                        newClass.name = "Other"
                    }
                }
            }
            
            let expansions: [Expansion] = try managedContext.fetch(Expansion.fetchRequest())
            
            if expansions.count == 0 {
                for i in 0..<2 {
                    let newExpansion = Expansion(context: managedContext)
                    switch i {
                    case 0:
                        newExpansion.name = "Magic Mirror"
                        newExpansion.about = "At the end of 3rd, 4th and 5th turn one player will check fraction of another player. Then Magic Mirror is transferred to that player."
                    case 1:
                        newExpansion.name = "Sword of Distrust"
                        newExpansion.about = "During quest one player can use the sword to change decision of one player (without seeing it)."
                    default:
                        newExpansion.name = "Other"
                    }
                }
            }
            
            try managedContext.save()
        } catch {
            print("Error creating players. \(error)")
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "RenaissanceMafiaPartyGame")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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

