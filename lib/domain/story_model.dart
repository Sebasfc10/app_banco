class UserModel {
  UserModel(this.stories);

  final List<StoryModel> stories;
}

class StoryModel {
  StoryModel(this.imageUrl);

  final String imageUrl;
}
