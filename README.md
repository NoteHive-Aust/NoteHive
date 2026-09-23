# NoteHive

A Flutter-based academic resource sharing platform where students can join class rooms, share study materials, and collaborate — powered by Firebase.

---

## Table of Contents

- [About](#about)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Firebase Setup](#firebase-setup)
- [Getting Started](#getting-started)
- [User Roles](#user-roles)
- [Firestore Data Model](#firestore-data-model)

---

## About

NoteHive lets students create or join academic **Rooms** (classes/courses). Inside a room, members can upload resources (notes, past papers, slides), browse materials by category, receive announcements from admins, and collaborate with their classmates. Admins and moderators manage the room and control content through a pending-approval workflow.

---

## Features

### Authentication
- Email & password sign up and login
- Profile photo upload on sign up (stored in Firebase Storage)
- Persistent login session

### Rooms
- Create a public or private room with categories
- Join a room using a 6-character room code (private) or browse public rooms
- Leave a room at any time

### Resources
- Upload study materials (notes, slides, past papers, etc.)
- Browse and search resources by category
- Pending approval workflow — uploaded resources require admin/moderator approval before going live
- View resource details

### Members
- View all room members grouped by role: Admin, Moderators, Members
- Member list fetched from Firestore
- Search members by name
- Admin and moderators can kick regular members

### Moderators
- Admin can promote members to moderators
- Moderators can approve/reject resource uploads and kick members

### Announcements
- Admin and moderators can publish announcements to all room members

### Profile
- View and edit profile (name, school, profile photo)
- Track total uploads and reputation points

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Dart) |
| Authentication | Firebase Auth |
| Database | Cloud Firestore |
| File Storage | Firebase Storage |
| Image Picking | image_picker |
| State Management | StatefulWidget + FutureBuilder |
| Fonts | Helvetica Now Display (heading), Gilroy (paragraph) |

---

## Project Structure

```
lib/
├── main.dart                          # App entry point, Firebase init, auth gate
├── firebase_options.dart              # Auto-generated Firebase config
│
├── FirebaseOperations/                # Firestore & Auth helper functions
│   ├── auth_services.dart             # Sign in, sign up, sign out, password reset
│   ├── auth_layout.dart               # Auth state stream listener
│   ├── getMyRooms.dart                # Fetch rooms the current user belongs to
│   ├── getRoomResources.dart          # Fetch resources for a room
│   ├── getRoomMembers.dart            # Fetch admin, moderators & members for a room
│   ├── getMyUploads.dart              # Fetch current user's uploaded resources
│   ├── getAnnouncemnets.dart          # Fetch announcements for a room
│   ├── createAnnouncements.dart       # Create a new announcement
│   ├── SearchRooms.dart               # Search public rooms
│   ├── getUserProfile.dart            # Fetch user profile document
│   └── firebase_storage_services.dart # Upload files to Firebase Storage
│
├── Structures/                        # Dart model classes
│   ├── roomStructure.dart             # Room model + fromMap / toMap
│   ├── userStructure.dart             # User model + fromMap
│   └── resourcesStructure.dart        # Resource model + fromMap
│
├── Screens/                           # All app screens
│   ├── startingScreen.dart            # Splash / landing screen
│   ├── login.dart                     # Login screen
│   ├── signup.dart                    # Sign up screen with photo picker
│   ├── pageController.dart            # Bottom nav controller
│   ├── homeScreen.dart                # My Rooms list
│   ├── browseRoom.dart                # Browse public rooms
│   ├── joinRoom.dart                  # Join room by code
│   ├── create_room_screen.dart        # Create a new room
│   ├── searchMyRooms.dart             # Search within joined rooms
│   ├── roomScreen.dart                # Room view for regular members
│   ├── RoomScreen_adminOrMod.dart     # Room dashboard for admin / moderators
│   ├── members.dart                   # Members list
│   ├── moderators.dart                # Moderators list
│   ├── add_moderators.dart            # Promote a member to moderator
│   ├── pendingApproval.dart           # Approve / reject resource uploads
│   ├── resourcesScreen.dart           # All resources in a room
│   ├── resourceDetails.dart           # Single resource detail view
│   ├── resourceUpload.dart            # Upload a new resource
│   ├── room_announcement_page.dart    # View announcements
│   ├── room_settings.dart             # Edit room settings (admin only)
│   ├── notifications_screen.dart      # User notifications
│   ├── my_uploads.dart                # Current user's uploaded resources
│   ├── profile_screen.dart            # User profile view / edit
│   └── setting_screen.dart            # App settings
│
└── widgets/                           # Reusable UI components
    ├── bottomNavigation.dart
    ├── cards.dart
    ├── searchBox.dart
    ├── leadingbackButton.dart
    ├── leadingTitleAndTailButton.dart
    ├── listTileForResources.dart
    ├── listTileForBrowseRoom.dart
    ├── listitemcardforhome.dart
    ├── floatingUploadButton.dart
    ├── AppbarWidgets.dart
    └── pop_up.dart
```

---




---


