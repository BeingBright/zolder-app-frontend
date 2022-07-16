import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zolder_app/component/sidebar.dart';
import 'package:zolder_app/component/user_card.dart';
import 'package:zolder_app/component/user_modal.dart';
import 'package:zolder_app/model/user/user.dart';
import 'package:zolder_app/model/user/user_model.dart';
import 'package:zolder_app/services/api_controller.dart';
import 'package:zolder_app/services/user_service.dart';

class UserView extends StatefulWidget {
  UserView({Key? key, this.children}) : super(key: key);

  final List<Widget>? children;

  final GetIt getIt = GetIt.instance;

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  _onAddUser() {
    var addUserDialog = showDialog(
      context: context,
      builder: (context) => const UserModal(title: "Add User"),
    );
    addUserDialog.then((user) {
      if (user == null) return;
      widget.getIt<UserService>().addUser(user);
    });
  }

  _onDeleteUser(User user) {
    widget.getIt<UserService>().removeUser(user);
  }

  _onUpdateUser(User user) {
    var updateUserModal = showDialog(
      context: context,
      builder: (context) => UserModal(
        currentUser: user,
        title: "Update User",
      ),
    );
    updateUserModal.then((user) {
      if (user != null) {
        widget.getIt<UserService>().updateUser(user);
      }
    });
  }


  _onRefresh() async {
    var result = await widget.getIt<UserService>().getUsers();
    setState(() {
      widget.getIt<UserModel>().setUsers(result);
    });
  }

  @override
  void initState() {
    super.initState();
    widget.getIt<APIController>().onBook = null;
    widget.getIt<APIController>().onLoc = null;
    widget.getIt<APIController>().onUser = _onRefresh;
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(children: widget.children),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("User"),
        actions: [
          IconButton(
            onPressed: _onRefresh,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddUser,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: GridView.builder(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 125),
            itemCount: widget.getIt<UserModel>().users.length,
            itemBuilder: (ctx, index) {
              return UserCard(
                user: widget.getIt<UserModel>().users[index],
                onDelete: _onDeleteUser,
                onUpdate: _onUpdateUser,
              );
            }),
      ),
    );
  }
}
