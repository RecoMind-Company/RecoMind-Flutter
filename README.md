# recomind

lib/
├── core/
│   ├── constants/   الحاجات الثابته اللي هتبقى فالapplication
│   │   ├── api_endpoints.dart
│   │   ├── app_colors.dart
│   │   └── app_strings.dart
│   ├── network/
│   │   ├── api_service.dart
│   │   ├── api_exceptions.dart
│   │   ├── dio_client.dart
│   │   └── api_exceptions.dart
│   ├── utils/
│   │   ├── helpers.dart
│   │   └── validators.dart
├── features/
│   ├── admin/
│   │   ├── dashboard/
│   │   │   └── admin_dashboard.dart
│   │   ├── user_management/
│   │   │   ├── manage_users.dart
│   │   │   ├── user_details.dart
│   │   │   └── add_user.dart
│   │   ├── system_settings/
│   │   │   ├── settings.dart
│   │   │   └── update_settings.dart
│   │   ├── content_management/
│   │   │   ├── manage_food.dart
│   │   │   ├── food_details.dart
│   │   │   └── add_food_item.dart
│   │
├── shared/ للwidget المشتركه و اللي بتعدي ال 7 سطور
│
├── root.dart هي اهم اسكرين و بتخليني اربط الصفحات كلها ببعض
│
├── splash_screen.dart
│
├── main.dart
