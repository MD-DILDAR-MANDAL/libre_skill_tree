// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_tree_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSkillTreeModelCollection on Isar {
  IsarCollection<SkillTreeModel> get skillTreeModels => this.collection();
}

const SkillTreeModelSchema = CollectionSchema(
  name: r'SkillTreeModel',
  id: 8840990309132602816,
  properties: {
    r'edges': PropertySchema(
      id: 0,
      name: r'edges',
      type: IsarType.objectList,

      target: r'SkillEdgeModel',
    ),
    r'name': PropertySchema(id: 1, name: r'name', type: IsarType.string),
    r'nodes': PropertySchema(
      id: 2,
      name: r'nodes',
      type: IsarType.objectList,

      target: r'SkillNodeModel',
    ),
  },

  estimateSize: _skillTreeModelEstimateSize,
  serialize: _skillTreeModelSerialize,
  deserialize: _skillTreeModelDeserialize,
  deserializeProp: _skillTreeModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'SkillNodeModel': SkillNodeModelSchema,
    r'SkillEdgeModel': SkillEdgeModelSchema,
  },

  getId: _skillTreeModelGetId,
  getLinks: _skillTreeModelGetLinks,
  attach: _skillTreeModelAttach,
  version: '3.3.0',
);

int _skillTreeModelEstimateSize(
  SkillTreeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.edges.length * 3;
  {
    final offsets = allOffsets[SkillEdgeModel]!;
    for (var i = 0; i < object.edges.length; i++) {
      final value = object.edges[i];
      bytesCount += SkillEdgeModelSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.nodes.length * 3;
  {
    final offsets = allOffsets[SkillNodeModel]!;
    for (var i = 0; i < object.nodes.length; i++) {
      final value = object.nodes[i];
      bytesCount += SkillNodeModelSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  return bytesCount;
}

void _skillTreeModelSerialize(
  SkillTreeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<SkillEdgeModel>(
    offsets[0],
    allOffsets,
    SkillEdgeModelSchema.serialize,
    object.edges,
  );
  writer.writeString(offsets[1], object.name);
  writer.writeObjectList<SkillNodeModel>(
    offsets[2],
    allOffsets,
    SkillNodeModelSchema.serialize,
    object.nodes,
  );
}

SkillTreeModel _skillTreeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SkillTreeModel(
    edges:
        reader.readObjectList<SkillEdgeModel>(
          offsets[0],
          SkillEdgeModelSchema.deserialize,
          allOffsets,
          SkillEdgeModel(),
        ) ??
        [],
    name: reader.readString(offsets[1]),
    nodes:
        reader.readObjectList<SkillNodeModel>(
          offsets[2],
          SkillNodeModelSchema.deserialize,
          allOffsets,
          SkillNodeModel(),
        ) ??
        [],
  );
  object.id = id;
  return object;
}

P _skillTreeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<SkillEdgeModel>(
                offset,
                SkillEdgeModelSchema.deserialize,
                allOffsets,
                SkillEdgeModel(),
              ) ??
              [])
          as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readObjectList<SkillNodeModel>(
                offset,
                SkillNodeModelSchema.deserialize,
                allOffsets,
                SkillNodeModel(),
              ) ??
              [])
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _skillTreeModelGetId(SkillTreeModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _skillTreeModelGetLinks(SkillTreeModel object) {
  return [];
}

void _skillTreeModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  SkillTreeModel object,
) {
  object.id = id;
}

extension SkillTreeModelQueryWhereSort
    on QueryBuilder<SkillTreeModel, SkillTreeModel, QWhere> {
  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SkillTreeModelQueryWhere
    on QueryBuilder<SkillTreeModel, SkillTreeModel, QWhereClause> {
  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension SkillTreeModelQueryFilter
    on QueryBuilder<SkillTreeModel, SkillTreeModel, QFilterCondition> {
  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  edgesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'edges', length, true, length, true);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  edgesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'edges', 0, true, 0, true);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  edgesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'edges', 0, false, 999999, true);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  edgesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'edges', 0, true, length, include);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  edgesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'edges', length, include, 999999, true);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  edgesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'edges',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nodesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'nodes', length, true, length, true);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nodesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'nodes', 0, true, 0, true);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nodesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'nodes', 0, false, 999999, true);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nodesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'nodes', 0, true, length, include);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nodesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'nodes', length, include, 999999, true);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nodesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nodes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SkillTreeModelQueryObject
    on QueryBuilder<SkillTreeModel, SkillTreeModel, QFilterCondition> {
  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  edgesElement(FilterQuery<SkillEdgeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'edges');
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterFilterCondition>
  nodesElement(FilterQuery<SkillNodeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'nodes');
    });
  }
}

extension SkillTreeModelQueryLinks
    on QueryBuilder<SkillTreeModel, SkillTreeModel, QFilterCondition> {}

extension SkillTreeModelQuerySortBy
    on QueryBuilder<SkillTreeModel, SkillTreeModel, QSortBy> {
  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension SkillTreeModelQuerySortThenBy
    on QueryBuilder<SkillTreeModel, SkillTreeModel, QSortThenBy> {
  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SkillTreeModel, SkillTreeModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension SkillTreeModelQueryWhereDistinct
    on QueryBuilder<SkillTreeModel, SkillTreeModel, QDistinct> {
  QueryBuilder<SkillTreeModel, SkillTreeModel, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension SkillTreeModelQueryProperty
    on QueryBuilder<SkillTreeModel, SkillTreeModel, QQueryProperty> {
  QueryBuilder<SkillTreeModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SkillTreeModel, List<SkillEdgeModel>, QQueryOperations>
  edgesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edges');
    });
  }

  QueryBuilder<SkillTreeModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SkillTreeModel, List<SkillNodeModel>, QQueryOperations>
  nodesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nodes');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SkillNodeModelSchema = Schema(
  name: r'SkillNodeModel',
  id: 6212713728648618293,
  properties: {
    r'id': PropertySchema(id: 0, name: r'id', type: IsarType.string),
    r'level': PropertySchema(id: 1, name: r'level', type: IsarType.long),
    r'locked': PropertySchema(id: 2, name: r'locked', type: IsarType.bool),
    r'maxLevel': PropertySchema(id: 3, name: r'maxLevel', type: IsarType.long),
    r'title': PropertySchema(id: 4, name: r'title', type: IsarType.string),
    r'x': PropertySchema(id: 5, name: r'x', type: IsarType.double),
    r'y': PropertySchema(id: 6, name: r'y', type: IsarType.double),
  },

  estimateSize: _skillNodeModelEstimateSize,
  serialize: _skillNodeModelSerialize,
  deserialize: _skillNodeModelDeserialize,
  deserializeProp: _skillNodeModelDeserializeProp,
);

int _skillNodeModelEstimateSize(
  SkillNodeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _skillNodeModelSerialize(
  SkillNodeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.id);
  writer.writeLong(offsets[1], object.level);
  writer.writeBool(offsets[2], object.locked);
  writer.writeLong(offsets[3], object.maxLevel);
  writer.writeString(offsets[4], object.title);
  writer.writeDouble(offsets[5], object.x);
  writer.writeDouble(offsets[6], object.y);
}

SkillNodeModel _skillNodeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SkillNodeModel(
    id: reader.readStringOrNull(offsets[0]) ?? '',
    level: reader.readLongOrNull(offsets[1]) ?? 0,
    locked: reader.readBoolOrNull(offsets[2]) ?? true,
    maxLevel: reader.readLongOrNull(offsets[3]) ?? 5,
    title: reader.readStringOrNull(offsets[4]) ?? '',
    x: reader.readDoubleOrNull(offsets[5]) ?? 0,
    y: reader.readDoubleOrNull(offsets[6]) ?? 0,
  );
  return object;
}

P _skillNodeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 5) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 6:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SkillNodeModelQueryFilter
    on QueryBuilder<SkillNodeModel, SkillNodeModel, QFilterCondition> {
  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  idLessThan(String value, {bool include = false, bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  idStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  idEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition> idMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'id',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  levelEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'level', value: value),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  levelGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'level',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  levelLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'level',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  levelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'level',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  lockedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'locked', value: value),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  maxLevelEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'maxLevel', value: value),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  maxLevelGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'maxLevel',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  maxLevelLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'maxLevel',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  maxLevelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'maxLevel',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition> xEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'x', value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  xGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'x',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition> xLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'x',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition> xBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'x',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition> yEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'y', value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition>
  yGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'y',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition> yLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'y',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<SkillNodeModel, SkillNodeModel, QAfterFilterCondition> yBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'y',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }
}

extension SkillNodeModelQueryObject
    on QueryBuilder<SkillNodeModel, SkillNodeModel, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SkillEdgeModelSchema = Schema(
  name: r'SkillEdgeModel',
  id: 4650924440982329313,
  properties: {
    r'fromNodeId': PropertySchema(
      id: 0,
      name: r'fromNodeId',
      type: IsarType.string,
    ),
    r'toNodeId': PropertySchema(
      id: 1,
      name: r'toNodeId',
      type: IsarType.string,
    ),
  },

  estimateSize: _skillEdgeModelEstimateSize,
  serialize: _skillEdgeModelSerialize,
  deserialize: _skillEdgeModelDeserialize,
  deserializeProp: _skillEdgeModelDeserializeProp,
);

int _skillEdgeModelEstimateSize(
  SkillEdgeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.fromNodeId.length * 3;
  bytesCount += 3 + object.toNodeId.length * 3;
  return bytesCount;
}

void _skillEdgeModelSerialize(
  SkillEdgeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.fromNodeId);
  writer.writeString(offsets[1], object.toNodeId);
}

SkillEdgeModel _skillEdgeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SkillEdgeModel(
    fromNodeId: reader.readStringOrNull(offsets[0]) ?? '',
    toNodeId: reader.readStringOrNull(offsets[1]) ?? '',
  );
  return object;
}

P _skillEdgeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SkillEdgeModelQueryFilter
    on QueryBuilder<SkillEdgeModel, SkillEdgeModel, QFilterCondition> {
  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  fromNodeIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fromNodeId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  fromNodeIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fromNodeId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  fromNodeIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fromNodeId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  fromNodeIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fromNodeId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  fromNodeIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fromNodeId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  fromNodeIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fromNodeId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  fromNodeIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fromNodeId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  fromNodeIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fromNodeId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  fromNodeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fromNodeId', value: ''),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  fromNodeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fromNodeId', value: ''),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  toNodeIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'toNodeId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  toNodeIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'toNodeId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  toNodeIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'toNodeId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  toNodeIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'toNodeId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  toNodeIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'toNodeId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  toNodeIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'toNodeId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  toNodeIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'toNodeId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  toNodeIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'toNodeId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  toNodeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'toNodeId', value: ''),
      );
    });
  }

  QueryBuilder<SkillEdgeModel, SkillEdgeModel, QAfterFilterCondition>
  toNodeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'toNodeId', value: ''),
      );
    });
  }
}

extension SkillEdgeModelQueryObject
    on QueryBuilder<SkillEdgeModel, SkillEdgeModel, QFilterCondition> {}
