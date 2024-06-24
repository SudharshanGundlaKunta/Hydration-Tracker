# Hydration-Tracker

Hydration Tracker

Hydration Tracker is an iOS application designed to help users monitor their daily water intake. This app is built using Swift and UIKit, and it uses Core Data for local storage.

Features

Water Intake Logging: Easily log your water consumption with different measurements (e.g., glass, bottle).
Daily Tracking: View a comprehensive summary of your daily hydration.
Edit Logs: Modify your water intake entries to maintain accurate records.
Hydration Notifications: Receive reminders to drink water and stay hydrated.
User-friendly Interface: Intuitive and engaging UI/UX design to promote regular use.



Requirements

iOS 13.0+
Xcode 12.0+
Swift 5.0+



Installation

1.Clone the Repository
git clone https://github.com/SudharshanGundlaKunta/Hydration-Tracker.git
cd Hydration-Tracker

2.Open the Project in Xcode
open HydrationTracker.xcodeproj

3.Install Dependencies
4.Run the App


Usage

Logging Water Intake
Open the app.
Tap the "Add" button.
Enter the amount of water consumed.
Tap "Save" to log the entry.
Editing Water Intake
In the list of logged entries, swipe left on the entry you want to edit.
Tap the "Edit" button.
Update the amount of water.
Tap "Save" to update the entry.
Receiving Notifications
Allow notifications when prompted.
Notifications will remind you to drink water at the scheduled times.
Core Data Model

The Core Data model includes the following entity:

WaterLog
id: UUID (optional)
date: Date (required)
amount: Double (required)
Version Control

This project uses Git for version control. The repository is hosted on GitHub, demonstrating proper use of commits, branches, and pull requests.

