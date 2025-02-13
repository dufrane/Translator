//
//  TranslationData.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 12.02.2025.
//

import Foundation

struct TranslationData {
    static let phrases: [String] = [
        "I'm hungry, feed me!", "Where have you been?", "Let's go for a walk!",
        "I'm sleepy...", "Play with me!", "I missed you!", "Can I have a treat?",
        "I'm bored...", "Turn on the TV!", "Rub my belly!", "I love you!",
        "Open the door, please!", "Time for a nap!", "I'm scared, hold me...",
        "Chase me if you can!", "Give me more food!", "Do you like my tricks?",
        "I saw a bird outside!", "It's cuddle time!", "Don't leave me alone!",
        "Did you hear that sound?", "Look at my new trick!", "I need some fresh air!",
        "Pet me more!", "It's time for dinner!", "I'm your best friend!",
        "Throw the ball!", "I want to sit on your lap!", "Let's go outside!",
        "Don't stop scratching!", "Can we play hide and seek?", "Let's go to the park!",
        "Time for a treat!", "Why are you so busy?", "I found something interesting!",
        "I need some attention!", "Come and chase me!", "Can I have more cuddles?",
        "Look at me, I'm cute!", "I don't want to stay home!", "Time to wake up!",
        "I love belly rubs!", "Please don't go!", "You're my favorite human!",
        "Do you have my favorite snack?", "Let's have some fun!", "Are we going for a ride?",
        "I smell something yummy!", "Let's watch TV together!", "You're the best!"
    ]

    static func randomPhrase() -> String {
        return phrases.randomElement() ?? "Meow!"
    }
}
