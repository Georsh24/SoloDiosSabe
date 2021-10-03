import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stickers_internet/app/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final FirebaseAuth _auth;

  AccountRepositoryImpl(this._auth);
  @override
  Future<User?> updateDisplayName(String value) async {
   try{
 final user = _auth.currentUser;
    //assert(User != null);
    await user!.updateDisplayName(value);
    user.reload();
    return  _auth.currentUser;
   }catch (e){
     return null;
   }
  }
}
