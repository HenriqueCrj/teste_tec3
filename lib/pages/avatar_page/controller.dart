import 'package:get_it/get_it.dart';
import 'package:teste_tec3/repository/avatar_repository.dart';

class AvatarPageController {
  final avatarRepository = GetIt.instance.get<AvatarRepository>();

  void saveAvatar() async {
    await avatarRepository.saveAvatar();
  }
}
