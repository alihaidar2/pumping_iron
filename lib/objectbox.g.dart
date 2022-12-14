// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_sync_flutter_libs/objectbox_sync_flutter_libs.dart';

import 'models/exercise.dart';
import 'models/set.dart';
import 'models/workout.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(4, 5556306561390569104),
      name: 'Set',
      lastPropertyId: const IdUid(4, 8336198939918899926),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8739569359095664345),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 264214112287146924),
            name: 'repetitions',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1650906018156953232),
            name: 'date',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 8336198939918899926),
            name: 'exerciseName',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 5542957906642155572),
      name: 'Exercise',
      lastPropertyId: const IdUid(6, 4637854562634076556),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 416436984501812623),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8504445299494800586),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5096844990576401295),
            name: 'target',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 8764803219866291283),
            name: 'bodyPart',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 610323052548603806),
            name: 'equipment',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 4637854562634076556),
            name: 'gifUrl',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(6, 961841792392638427),
      name: 'Workout',
      lastPropertyId: const IdUid(1, 4750836698139640229),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4750836698139640229),
            name: 'id',
            type: 6,
            flags: 1)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(6, 961841792392638427),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [
        658129015512293571,
        6674796547357999322,
        996443871069670041
      ],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        1274146726252656724,
        1748644007173850896,
        9215775960355072575,
        1868734573763643329,
        4345878167843593260,
        486059245126040481,
        4701210221314884544,
        5096502320797118806,
        916299560753839574
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Set: EntityDefinition<Set>(
        model: _entities[0],
        toOneRelations: (Set object) => [],
        toManyRelations: (Set object) => {},
        getId: (Set object) => object.id,
        setId: (Set object, int id) {
          object.id = id;
        },
        objectToFB: (Set object, fb.Builder fbb) {
          final exerciseNameOffset = fbb.writeString(object.exerciseName);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.repetitions);
          fbb.addInt64(2, object.date.millisecondsSinceEpoch);
          fbb.addOffset(3, exerciseNameOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Set(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              exerciseName: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              repetitions: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              date: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0)));

          return object;
        }),
    Exercise: EntityDefinition<Exercise>(
        model: _entities[1],
        toOneRelations: (Exercise object) => [],
        toManyRelations: (Exercise object) => {},
        getId: (Exercise object) => object.id,
        setId: (Exercise object, int id) {
          object.id = id;
        },
        objectToFB: (Exercise object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final targetOffset =
              object.target == null ? null : fbb.writeString(object.target!);
          final bodyPartOffset = object.bodyPart == null
              ? null
              : fbb.writeString(object.bodyPart!);
          final equipmentOffset = object.equipment == null
              ? null
              : fbb.writeString(object.equipment!);
          final gifUrlOffset =
              object.gifUrl == null ? null : fbb.writeString(object.gifUrl!);
          fbb.startTable(7);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, targetOffset);
          fbb.addOffset(3, bodyPartOffset);
          fbb.addOffset(4, equipmentOffset);
          fbb.addOffset(5, gifUrlOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Exercise(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              target: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              bodyPart: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              equipment: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              gifUrl: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14));

          return object;
        }),
    Workout: EntityDefinition<Workout>(
        model: _entities[2],
        toOneRelations: (Workout object) => [],
        toManyRelations: (Workout object) => {},
        getId: (Workout object) => object.id,
        setId: (Workout object, int id) {
          object.id = id;
        },
        objectToFB: (Workout object, fb.Builder fbb) {
          fbb.startTable(2);
          fbb.addInt64(0, object.id);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Workout(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Set] entity fields to define ObjectBox queries.
class Set_ {
  /// see [Set.id]
  static final id = QueryIntegerProperty<Set>(_entities[0].properties[0]);

  /// see [Set.repetitions]
  static final repetitions =
      QueryIntegerProperty<Set>(_entities[0].properties[1]);

  /// see [Set.date]
  static final date = QueryIntegerProperty<Set>(_entities[0].properties[2]);

  /// see [Set.exerciseName]
  static final exerciseName =
      QueryStringProperty<Set>(_entities[0].properties[3]);
}

/// [Exercise] entity fields to define ObjectBox queries.
class Exercise_ {
  /// see [Exercise.id]
  static final id = QueryIntegerProperty<Exercise>(_entities[1].properties[0]);

  /// see [Exercise.name]
  static final name = QueryStringProperty<Exercise>(_entities[1].properties[1]);

  /// see [Exercise.target]
  static final target =
      QueryStringProperty<Exercise>(_entities[1].properties[2]);

  /// see [Exercise.bodyPart]
  static final bodyPart =
      QueryStringProperty<Exercise>(_entities[1].properties[3]);

  /// see [Exercise.equipment]
  static final equipment =
      QueryStringProperty<Exercise>(_entities[1].properties[4]);

  /// see [Exercise.gifUrl]
  static final gifUrl =
      QueryStringProperty<Exercise>(_entities[1].properties[5]);
}

/// [Workout] entity fields to define ObjectBox queries.
class Workout_ {
  /// see [Workout.id]
  static final id = QueryIntegerProperty<Workout>(_entities[2].properties[0]);
}
