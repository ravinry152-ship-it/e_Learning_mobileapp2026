// Obx(() {
//   final unreadCount = n.unreadNotificationsCount.value;
//   return Stack(
//     clipBehavior: Clip.none, // អនុញ្ញាតឱ្យគ្រាប់ក្រហមលោតធ្លាយចេញក្រៅបន្តិចបានស្អាត
//     children: [
//       // 1. គ្រឹះខាងក្រោមគឺ ប៊ូតុងកណ្តឹង
//       IconButton(
//         onPressed: () {
//           n.clearNotificationBadge();
//           Get.toNamed('/notification');
//         },
//         icon: const Icon(
//           Icons.notifications,
//           color: Colors.white,
//           size: 30,
//         ),
//       ),
      
//       // 2. គ្រាប់លេខក្រហម (បង្ហាញតែពេលមានលេខ > 0)
//       if (unreadCount > 0)
//         Positioned(
//           top: 4,   // 🔥 លៃរំកិលឡើងលើ/ចុះក្រោម (លេខកាន់តែតូច កាន់តែឡើងលើ)
//           right: 4, // 🔥 លៃរំកិលទៅឆ្វេង/ស្តាំ (លេខកាន់តែតូច កាន់តែទៅស្តាំ)
//           child: Container(
//             padding: const EdgeInsets.all(4), // ចន្លោះពីអក្សរទៅរង្វង់ក្រហម
//             constraints: const BoxConstraints(
//               minWidth: 18,  // ប្រវែងទទឹងតូចបំផុត ដើម្បីឱ្យចេញរង្វង់មូលស្អាត
//               minHeight: 18, // កម្ពស់តូចបំផុត
//             ),
//             decoration: BoxDecoration(
//               color: Colors.red, // ពណ៌គ្រាប់ Badge
//               shape: BoxShape.circle, // ធ្វើឱ្យចេញជារង្វង់មូល
//               border: Border.all(color: Colors.white, width: 1), // ថែមខ្សែបន្ទាត់សជុំវិញឱ្យកាន់តែលេចធ្លោ
//             ),
//             child: Center(
//               child: Text(
//                 '$unreadCount',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 10, // ទំហំអក្សរតូចល្មមស្អាត
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ),
//     ],
//   );
// })