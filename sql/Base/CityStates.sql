--==============================================================
--******			       CITY STATES      			  ******
--==============================================================

-- nan-modal culture per district no longer applies to city center or wonders
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType, Inverse ) VALUES
    ( 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
    ( 'REQUIRES_DISTRICT_IS_NOT_AQUEDUCT_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
    ( 'REQUIRES_DISTRICT_IS_NOT_CANAL_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
    ( 'REQUIRES_DISTRICT_IS_NOT_DAM_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
    ( 'REQUIRES_DISTRICT_IS_NOT_NEIGHBORHOOD_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
    ( 'REQUIRES_DISTRICT_IS_NOT_SPACEPORT_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
    ( 'REQUIRES_DISTRICT_IS_NOT_WORLD_WONDER_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 );
INSERT OR IGNORE INTO RequirementArguments ( RequirementId, Name, Value ) VALUES
    ( 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_BBG', 'DistrictType', 'DISTRICT_CITY_CENTER' ),
    ( 'REQUIRES_DISTRICT_IS_NOT_AQUEDUCT_BBG', 'DistrictType', 'DISTRICT_AQUEDUCT' ),
    ( 'REQUIRES_DISTRICT_IS_NOT_CANAL_BBG', 'DistrictType', 'DISTRICT_CANAL' ),
    ( 'REQUIRES_DISTRICT_IS_NOT_DAM_BBG', 'DistrictType', 'DISTRICT_DAM' ),
    ( 'REQUIRES_DISTRICT_IS_NOT_NEIGHBORHOOD_BBG', 'DistrictType', 'DISTRICT_NEIGHBORHOOD' ),
    ( 'REQUIRES_DISTRICT_IS_NOT_SPACEPORT_BBG', 'DistrictType', 'DISTRICT_SPACEPORT' ),
    ( 'REQUIRES_DISTRICT_IS_NOT_WORLD_WONDER_BBG', 'DistrictType', 'DISTRICT_WONDER' );
INSERT OR IGNORE INTO RequirementSets ( RequirementSetId, RequirementSetType ) VALUES
    ( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIREMENTSET_TEST_ALL' );
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId ) VALUES
    ( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_PLOT_IS_ADJACENT_TO_COAST' ),
    ( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_BBG' ),
    ( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_AQUEDUCT_BBG' ),
    ( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_CANAL_BBG' ),
    ( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_DAM_BBG' ),
    ( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_NEIGHBORHOOD_BBG' ),
    ( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_SPACEPORT_BBG' ),
    ( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_WORLD_WONDER_BBG' );

INSERT INTO Requirements(RequirementId,RequirementType) VALUES
    ('REQUIRES_SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIREMENT_REQUIREMENTSET_IS_MET');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
    ('REQUIRES_SPECIAL_DISTRICT_ON_COAST_BBG', 'RequirementSetId', 'SPECIAL_DISTRICT_ON_COAST_BBG');

UPDATE Modifiers SET SubjectRequirementSetId='SPECIAL_DISTRICT_ON_COAST_BBG' WHERE ModifierId='MINOR_CIV_NAN_MADOL_DISTRICTS_CULTURE_BONUS';

-- Nan madol nerf to +1 culture.
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='MINOR_CIV_NAN_MADOL_DISTRICTS_CULTURE_BONUS' AND Name='Amount';
-- +1 culture once exploration reach
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('MINOR_CIV_NAN_MADOL_TRAIT', 'BBG_NAN_MADOL_UNIQUE_INFLUENCE_EXPLORATION_MODIFIER');

INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('BBG_NAN_MADOL_UNIQUE_INFLUENCE_EXPLORATION_MODIFIER', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 'PLAYER_IS_SUZERAIN'),
    ('BBG_NAN_MADOL_EXPLORATION_BONUS_MODIFIER', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'SPECIAL_DISTRICT_ON_COAST_EXPLORATION_BBG');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_NAN_MADOL_UNIQUE_INFLUENCE_EXPLORATION_MODIFIER', 'ModifierId', 'BBG_NAN_MADOL_EXPLORATION_BONUS_MODIFIER'),
    ('BBG_NAN_MADOL_EXPLORATION_BONUS_MODIFIER', 'YieldType', 'YIELD_CULTURE'),
    ('BBG_NAN_MADOL_EXPLORATION_BONUS_MODIFIER', 'Amount', '1');

INSERT INTO RequirementSets('RequirementSetId', 'RequirementSetType') VALUES
    ('SPECIAL_DISTRICT_ON_COAST_EXPLORATION_BBG', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
    ('SPECIAL_DISTRICT_ON_COAST_EXPLORATION_BBG', 'REQUIRES_SPECIAL_DISTRICT_ON_COAST_BBG'),
    ('SPECIAL_DISTRICT_ON_COAST_EXPLORATION_BBG', 'BBG_UTILS_PLAYER_HAS_CIVIC_EXPLORATION_REQUIREMENT');


-- Ngazargamu legacy city-state is carthage
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='MINOR_CIV_CARTHAGE_BARRACKS_STABLE_PURCHASE_BONUS';
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='MINOR_CIV_CARTHAGE_ARMORY_PURCHASE_BONUS';
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='MINOR_CIV_CARTHAGE_MILITARY_ACADEMY_PURCHASE_BONUS';

-- 09/03/24 Lisbon pillage apply on land too
UPDATE ModifierArguments SET Value='ABILITY_ECONOMIC_GOLDEN_AGE_PLUNDER_IMMUNITY' WHERE ModifierId='MINOR_CIV_LISBON_SEA_TRADE_ROUTE_PLUNDER_IMMUNITY_BONUS' AND Name='AbilityType';

-- Bandar Brunei +2 golds flat for external
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('BBG_MINOR_CIV_JAKARTA_UNIQUE_INFLUENCE_BONUS_GOLD', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 'PLAYER_IS_SUZERAIN'),
    ('BBG_MINOR_CIV_JAKARTA_GOLD_BONUS', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_MINOR_CIV_JAKARTA_UNIQUE_INFLUENCE_BONUS_GOLD', 'ModifierId', 'BBG_MINOR_CIV_JAKARTA_GOLD_BONUS'),
    ('BBG_MINOR_CIV_JAKARTA_GOLD_BONUS', 'YieldType', 'YIELD_GOLD'),
    ('BBG_MINOR_CIV_JAKARTA_GOLD_BONUS', 'Amount', '2');
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('MINOR_CIV_JAKARTA_TRAIT', 'BBG_MINOR_CIV_JAKARTA_UNIQUE_INFLUENCE_BONUS_GOLD');

-- 09/03/24 Mogadiscio +2 golds flat for external
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('BBG_MINOR_CIV_LISBON_UNIQUE_INFLUENCE_BONUS_GOLD', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 'PLAYER_IS_SUZERAIN'),
    ('BBG_MINOR_CIV_LISBON_GOLD_BONUS', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_MINOR_CIV_LISBON_UNIQUE_INFLUENCE_BONUS_GOLD', 'ModifierId', 'BBG_MINOR_CIV_LISBON_GOLD_BONUS'),
    ('BBG_MINOR_CIV_LISBON_GOLD_BONUS', 'YieldType', 'YIELD_GOLD'),
    ('BBG_MINOR_CIV_LISBON_GOLD_BONUS', 'Amount', '2');
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('MINOR_CIV_LISBON_TRAIT', 'BBG_MINOR_CIV_LISBON_UNIQUE_INFLUENCE_BONUS_GOLD');

--09/03/2024 moai buildable next rainforest and forest
DELETE FROM Improvement_InvalidAdjacentFeatures WHERE ImprovementType = 'IMPROVEMENT_MOAI';

--09/03/24 Batey buff 
--+1 prod for each strat
--+1 food for each luxe
INSERT INTO Improvement_YieldChanges (ImprovementType, YieldType, YieldChange) VALUES
	('IMPROVEMENT_BATEY', 'YIELD_PRODUCTION', 0),
    ('IMPROVEMENT_BATEY', 'YIELD_GOLD', 0);

INSERT INTO Improvement_Adjacencies (ImprovementType, YieldChangeId) VALUES
	('IMPROVEMENT_BATEY', 'BBG_Batey_gold_Luxe'),
    ('IMPROVEMENT_BATEY', 'BBG_Batey_Prod_Strat');

INSERT INTO Adjacency_YieldChanges (ID, Description, YieldType, YieldChange, TilesRequired, AdjacentResourceClass) VALUES
	('BBG_Batey_gold_Luxe', 'Placeholder', 'YIELD_GOLD', 1, 1, 'RESOURCECLASS_LUXURY'),
    ('BBG_Batey_Prod_Strat', 'Placeholder', 'YIELD_PRODUCTION', 1, 1,'RESOURCECLASS_STRATEGIC');

-- Batey buildable on hills
INSERT INTO Improvement_ValidTerrains(ImprovementType, TerrainType) VALUES
    ('IMPROVEMENT_BATEY', 'TERRAIN_GRASS_HILLS'),
    ('IMPROVEMENT_BATEY', 'TERRAIN_PLAINS_HILLS'),
    ('IMPROVEMENT_BATEY', 'TERRAIN_DESERT_HILLS'),
    ('IMPROVEMENT_BATEY', 'TERRAIN_TUNDRA_HILLS'),
    ('IMPROVEMENT_BATEY', 'TERRAIN_SNOW_HILLS');


-- 09/03/2024 colossal heads +1 food, +1 housing
INSERT INTO Improvement_YieldChanges (ImprovementType, YieldType, YieldChange) VALUES ('IMPROVEMENT_COLOSSAL_HEAD', 'YIELD_FOOD', 1);
UPDATE Improvements SET Housing=1 WHERE ImprovementType='IMPROVEMENT_COLOSSAL_HEAD';

-- 09/03/2024 Monastery +1 food, +1faith per adjacent district at reformed church (instead of 2)
INSERT INTO Improvement_YieldChanges (ImprovementType, YieldType, YieldChange) VALUES ('IMPROVEMENT_MONASTERY', 'YIELD_FOOD', 1);
UPDATE Adjacency_YieldChanges SET TilesRequired='1' WHERE ID='Monastery_DistrictAdjacency';
