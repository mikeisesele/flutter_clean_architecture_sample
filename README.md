# Flutter Clean Architecture Project

## Overview

This repository serves as an implementation of clean architecture in a scalable, maintainable Flutter project, employing industry-best practices for state management using Flutter Bloc and Cubit. The project adheres to reactive clean architecture principles and integrates robust dependency injection. The codebase is crafted with a Test-Driven Development (TDD) approach, emphasizing clear separation of concerns.

## Libraries Utilized

- **Object Equality:** Equitable
- **Dependency Injection:** get-it
- **Functional Programming:** Dartz
- **Testing Blocs and Cubits:** bloc_test
- **Mocking Test Dependencies:** mocktail

Feel free to explore and contribute to this Flutter project as we strive for excellence in code quality and maintainability.

### Folder Structure

```markdown
## Folder Structure

The project follows a structured organization for better maintainability. Here's a brief overview:

- `lib/`: Main application code.
  - `src/`: Feature-specific modules. [Authentication]
    - `data/`: Data layer implementation.
    - `domain/`: Business logic and domain entities.
    - `presentation/`: User interface and presentation logic.
  - `core/`: DI implementation, Wrapper classes, Abstract classes serving as Interfaces.


## Getting Started

To get started with this Flutter project, follow these steps:

1. Clone this repository:

   git clone <repository-url>

2. Navigate to the Project Directory:
   
   cd <project-directory>
 
3. Install dependencie

   flutter pub get

5. Run the App:

   flutter run
