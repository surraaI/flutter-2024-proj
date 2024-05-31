import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_health_tracker/application/auth/admin_state.dart';
import 'package:personal_health_tracker/presention/widgets/my_button.dart';
import 'package:personal_health_tracker/presention/widgets/text_field.dart';
class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({super.key});

  @override
  ConsumerState<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  final emailController = TextEditingController();
  final roleController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    roleController.dispose();
    super.dispose();
  }

  void viewAllUsers() async {
    final notifier = ref.read(adminStateNotifierProvider.notifier);
    try {
      await notifier.fetchAllUsers();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch users: ${e.toString()}')),
      );
    }
  }

  void assignUserRole() async {
    final notifier = ref.read(adminStateNotifierProvider.notifier);
    try {
      await notifier.assignRole(emailController.text, roleController.text);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to assign role: ${e.toString()}')),
      );
    }
  }

  void deleteUser(String email) async {
    final notifier = ref.read(adminStateNotifierProvider.notifier);
    try {
      await notifier.deleteUser(email);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: ${e.toString()}')),
      );
    }
  }

  void deleteAllUsers() async {
    final notifier = ref.read(adminStateNotifierProvider.notifier);
    try {
      await notifier.deleteAllUsers();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete all users: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final adminState = ref.watch(adminStateNotifierProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 41, 81),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 234, 234, 234),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFB1B1B1),
                  offset: Offset(3, 3),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-10, -10),
                  blurRadius: 10,
                ),
              ],
            ),
            width: 350.0,
            height: 600.0,
            child: Column(
              children: [
                const SizedBox(height: 20,),
                const CircleAvatar(
                  backgroundImage: AssetImage("images/logo.png"),
                  radius: 30,
                ),
                const SizedBox(height: 15,),
                const Text("Admin Page", style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 56, 41, 81))),
                const SizedBox(height: 20,),
                MyButton(
                  onTap: viewAllUsers,
                  buttonText: 'View All Users',
                ),
                const SizedBox(height: 20,),
                MyTextField(
                  controller: emailController,
                  hintText: "User Email",
                  obscureText: false,
                ),
                const SizedBox(height: 10,),
                MyTextField(
                  controller: roleController,
                  hintText: "Role (user/admin)",
                  obscureText: false,
                ),
                const SizedBox(height: 10,),
                MyButton(
                  onTap: assignUserRole,
                  buttonText: 'Assign Role',
                ),
                const SizedBox(height: 20,),
                MyButton(
                  onTap: deleteAllUsers,
                  buttonText: 'Delete All Users',
                ),
                const SizedBox(height: 20,),
                if (adminState.isLoading)
                  const CircularProgressIndicator(),
                if (!adminState.isLoading && adminState.users.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: adminState.users.length,
                      itemBuilder: (context, index) {
                        final user = adminState.users[index];
                        return ListTile(
                          title: Text(user.email),
                          // subtitle: Text(user.role),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteUser(user.email),
                          ),
                        );
                      },
                    ),
                  ),
                if (!adminState.isLoading && adminState.users.isEmpty)
                  const Text("No users found."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
