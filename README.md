# Study Card App

A Flutter-based study and flashcard application designed to help students
create, manage, and revise study cards.

## Development Progress

### Commit 1 — Initial Flutter Project Setup

**Commit message:** `Initial Flutter project setup`

**Description:**  
Created the Flutter project and initialized the basic project structure
required for developing the Study Card application.

---

### Commit 2 — Create Study Card Home Screen

**Commit message:** `Create study card home screen`

**Description:**  
Designed the initial home screen of the Study Card application. The screen
contains the application title, study introduction, progress section, and
buttons for creating cards and starting a study session.

#### Screenshot

![Study Card Home Screen](screenshots/commit-2.jpg)

**Screenshot explanation:**  
This screenshot shows the initial Study Card home screen developed in
Commit 2. It displays the study introduction, current progress information,
and the main actions available to the user: Create Card and Study Now.

---

### Commit 3 — Add Flashcard Data Model

**Commit message:** `Add flashcard data model`

**Description:**  
Created a Flashcard data model containing question and answer fields.
Sample flashcards were added to demonstrate how flashcard data is
represented and displayed in the application.

#### Screenshot

![Flashcard Data Model](screenshots/commit-3.jpg)

**Screenshot explanation:**  
This screenshot shows the Study Card home screen after introducing
the Flashcard data model. The application displays the number of
available flashcards.

---

### Commit 4 — Implement Flashcard Creation

**Commit message:** `Implement flashcard creation`

**Description:**  
Implemented the flashcard creation feature in the Study Card application.
Users can now enter a question and answer and save the flashcard.

A separate Create Flashcard screen was added with input fields for:

- Question
- Answer
- Save Card button

After saving a flashcard, the user is returned to the home screen and
the flashcard count is updated.

#### Screenshot

![Create Flashcard Screen](screenshots/commit-4.2.jpg)

**Screenshot explanation:**  
This screenshot shows the Create Flashcard screen of the Study Card
application. The user can enter a question and its corresponding answer
and save the new flashcard using the Save Card button.

---

---

### Commit 5 — Implement Flashcard Study Mode

**Commit message:** `Implement flashcard study mode`

**Description:**  
Implemented a Study Mode feature for the Study Card application.

Users can now:

- View the current flashcard question
- Tap the flashcard to reveal the answer
- Move to the next flashcard
- See the current flashcard number

The Study Now button on the home screen opens the Study Mode screen.

#### Screenshot

![Study Mode](screenshots/commit-5.1.jpg)
![Study Mode](screenshots/commit-5.2.jpg)

**Screenshot explanation:**  
This screenshot shows the Study Mode screen of the Study Card application.
The current flashcard question is displayed along with the card number.
The user can tap the card to reveal the answer and use the Next Card button
to continue studying.

---

### Commit 6 — Add Dart Utility Functions

**Commit message:** `Add Dart utility functions`

**Description:**

Implemented reusable Dart utility functions to calculate flashcard statistics and study progress.

Features:

- Calculate total flashcards.
- Track the number of studied flashcards.
- Calculate study progress percentage.
- Generate progress messages using conditional statements.
- Display a dynamic progress bar on the home screen.

**Dart Concepts Used:**

- Functions and static methods
- Conditional statements
- Lists and Sets
- Return values

#### Screenshot

![Study Progress](screenshots/commit-6.jpg)

---

### Commit 7 — Create Reusable Study Card Widgets

**Commit message:** `Create reusable study card widgets`

**Description:**

Created a custom reusable Flutter widget to display flashcard study progress. Extracted the progress UI from `main.dart` into a separate widget to improve code organization and reusability.

**Features:**

- Created a reusable `ProgressCard` widget.
- Displays the total number of flashcards.
- Shows the number of studied cards.
- Displays a dynamic progress bar.
- Shows study progress as a percentage.
- Displays progress messages based on study activity.

**Dart and Flutter Concepts Used:**

- Custom widgets
- StatelessWidget
- Constructor parameters
- Required properties
- Widget reusability
- Component-based UI design

**Files Created:**

- `lib/widgets/progress_card.dart`

**Files Modified:**

- `lib/main.dart`

---

---

### Commit 8 — Improve Layouts Using Flutter Widgets

**Commit message:** `Improve layouts using Flutter widgets`

**Description:**

Improved the Study Card dashboard layout using Flutter's basic layout widgets.

**Features:**

- Used Row to arrange the dashboard heading and school icon horizontally.
- Used Column to organize screen elements vertically.
- Used Stack to overlay an icon on the progress card.
- Used Positioned to control the icon's placement.
- Used Expanded to manage available horizontal space.

**Flutter Concepts Used:**

- Row
- Column
- Stack
- Positioned
- Expanded

#### Screenshot

!(screenshots/commit-8.jpg)
