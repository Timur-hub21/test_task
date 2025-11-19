import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:recipes_test_task/data/models/recipe/recipe.dart';
import 'package:recipes_test_task/data/models/recipe/step_item.dart';
import 'package:recipes_test_task/data/models/recipe/ingredient_item.dart';
import 'package:recipes_test_task/data/models/recipe/energy_item.dart';

class RecipesLocalDataSource {
  static final RecipesLocalDataSource _instance = RecipesLocalDataSource._internal();
  factory RecipesLocalDataSource() => _instance;

  RecipesLocalDataSource._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'recipes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE recipes (
        id TEXT PRIMARY KEY,
        title TEXT,
        text TEXT,
        prepTime TEXT,
        image TEXT,
        dateAdded TEXT,
        link TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE steps (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        recipeId TEXT,
        text TEXT,
        image1 TEXT,
        image2 TEXT,
        FOREIGN KEY(recipeId) REFERENCES recipes(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE ingredients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        recipeId TEXT,
        title TEXT,
        text TEXT,
        type TEXT,
        FOREIGN KEY(recipeId) REFERENCES recipes(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE energy (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        recipeId TEXT,
        title TEXT,
        text TEXT,
        FOREIGN KEY(recipeId) REFERENCES recipes(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> insertOrUpdateRecipes(List<Recipe> recipes) async {
    final db = await database;

    final batch = db.batch();

    for (final recipe in recipes) {
      batch.insert(
        'recipes',
        {
          'id': recipe.id,
          'title': recipe.title,
          'text': recipe.text,
          'prepTime': recipe.prepTime,
          'image': recipe.image,
          'dateAdded': recipe.dateAdded,
          'link': recipe.link,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      batch.delete('steps', where: 'recipeId = ?', whereArgs: [recipe.id]);
      batch.delete('ingredients', where: 'recipeId = ?', whereArgs: [recipe.id]);
      batch.delete('energy', where: 'recipeId = ?', whereArgs: [recipe.id]);

      for (final step in recipe.steps) {
        batch.insert('steps', {
          'recipeId': recipe.id,
          'text': step.text,
          'image1': step.image1,
          'image2': step.image2,
        });
      }

      for (final ingredient in recipe.ingredientsOne) {
        batch.insert('ingredients', {
          'recipeId': recipe.id,
          'title': ingredient.title,
          'text': ingredient.text,
          'type': 'one',
        });
      }
      for (final ingredient in recipe.ingredientsTwo) {
        batch.insert('ingredients', {
          'recipeId': recipe.id,
          'title': ingredient.title,
          'text': ingredient.text,
          'type': 'two',
        });
      }

      for (final energy in recipe.energy) {
        batch.insert('energy', {
          'recipeId': recipe.id,
          'title': energy.title,
          'text': energy.text,
        });
      }
    }

    await batch.commit(noResult: true);
  }

  Future<List<Recipe>> getAllRecipes() async {
    final db = await database;
    final recipeMaps = await db.query('recipes');

    List<Recipe> recipes = [];

    for (final map in recipeMaps) {
      final recipeId = map['id'] as String;

      final stepsMaps = await db.query('steps', where: 'recipeId = ?', whereArgs: [recipeId]);
      final ingredientsMaps = await db.query('ingredients', where: 'recipeId = ?', whereArgs: [recipeId]);
      final energyMaps = await db.query('energy', where: 'recipeId = ?', whereArgs: [recipeId]);

      recipes.add(
        Recipe(
          id: recipeId,
          title: map['title'] as String,
          text: map['text'] as String,
          prepTime: map['prepTime'] as String,
          image: map['image'] as String,
          dateAdded: map['dateAdded'] as String,
          link: map['link'] as String?,
          steps: stepsMaps
              .map(
                (e) => StepItem(
                  text: e['text'] as String,
                  image1: e['image1'] as String?,
                  image2: e['image2'] as String?,
                ),
              )
              .toList(),
          ingredientsOne: ingredientsMaps
              .where((e) => e['type'] == 'one')
              .map((e) => IngredientItem(title: e['title'] as String, text: e['text'] as String))
              .toList(),
          ingredientsTwo: ingredientsMaps
              .where((e) => e['type'] == 'two')
              .map((e) => IngredientItem(title: e['title'] as String, text: e['text'] as String))
              .toList(),
          energy: energyMaps.map((e) => EnergyItem(title: e['title'] as String, text: e['text'] as String)).toList(),
        ),
      );
    }

    return recipes;
  }

  Future<void> clearAll() async {
    final db = await database;
    await db.delete('steps');
    await db.delete('ingredients');
    await db.delete('energy');
    await db.delete('recipes');
  }
}
