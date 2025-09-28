# Food Order App
A simple Flutter-based food ordering app with **BLoC state management**.  
The app allows users to browse restaurants, view menus, add items to cart, checkout, and track past orders.

---
## Project Structure
food_order_app/
├─ lib/
│ ├─ main.dart # App entry point
│ ├─ app.dart # App widget with BlocProvider
│ ├─ models/ # Data models
│ │ ├─ food_item.dart
│ │ └─ restaurant_model.dart
│ ├─ repository/ # Repository layer (mock/future APIs)
│ │ └─ food_repo.dart
│ ├─ blocs/ # Bloc State Management
│ │ └─ food_order/
│ │ ├─ food_order_bloc.dart
│ │ ├─ food_order_event.dart
│ │ └─ food_order_state.dart
│ ├─ screens/ # Screens (UI)
│ │ ├─ main_screen.dart
│ │ ├─ restaurant_list.dart
│ │ ├─ restaurant_details.dart
│ │ ├─ menu_screen.dart
│ │ ├─ cart_screen.dart
│ │ ├─ checkout_screen.dart
│ │ └─ order_screen.dart
│ └─ widgets/ # Reusable Widgets
│ ├─ food_item_card.dart
│ ├─ restaurant_card.dart
│ └─ custom_button.dart
├─ test/ # Unit/Bloc tests
│ └─ blocs/
│ └─ food_order_bloc_test.dart
├─ pubspec.yaml # Dependencies

- **Browse Restaurants**  
  Displays a list of restaurants with images, ratings, and menus.

- **Restaurant Menu**  
  Users can view food items, including images, prices, and ratings.

- **Add to Cart**  
  Items can be added to the cart from restaurant menus.

- **Cart Management**  
  View selected items, check total price, and proceed to checkout.

- **Checkout Flow**  
  Confirm the order, and items move from cart to past orders.

- **Past Orders**  
  View all previously confirmed orders on the "Orders" screen.

- **BLoC State Management**  
  Centralized business logic with events, states, and BlocBuilder.


##  Getting Started

### 1. Clone the repo
## bash
git clone https://github.com/your-username/food_order_app.git
cd food_order_app

## Install dependencies
flutter pub get

## Run the app
flutter run


## Screen shots
You can see the images of application in /assets folder

## Testing
flutter test


