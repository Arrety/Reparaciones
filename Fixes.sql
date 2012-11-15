/* Estas reparaciones, han sido realizadas por "Arrety", y otras que están en este mismo archivo, por gente que ayuda en "Trinity Core". 
Fueron realizadas para el servidor WowAura/WowUxía, pero tras 3 meses esperando su implementación,... pasaron de todo, así que decidí dejarlo y hacer públicos
los fixes.
Estos fixes pueden ser usados sin ningún problema en cualquier servidor privado. Espero que les sean útiles, y poder llegar a ayudar a alguien.

Un saludo y muchas gracias por leer esto!
*/

#######
#Quest#
#######

/* El Bancal del Maestro --> Quest Karazhan */

UPDATE creature_template SET InhabitType = 4 WHERE entry = 17652;
DELETE FROM event_scripts WHERE id=10951;
INSERT INTO event_scripts (id,delay,command,datalong,datalong2,dataint,x,y,z,o) VALUES
(10951,0,10,17651,300000,0,-11161,-1923.2,91.4737,2.89811);

/* Cabalgando sobre el cohete rojo --> Colinas Pardas */

UPDATE creature_template SET AIName='SmartAI' WHERE entry=27593;
DELETE FROM smart_scripts WHERE (entryorguid=27593 AND source_type=0);
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(27593,0,0,1,8,0,100,0,49177,0,0,0,33,27688,0,0,0,0,0,7,0,0,0,0,0,0,0,'Rocket Propelled Warhead - on Ride Rocket Propelled Warhead SpellHit - Call KilledMonster Alliance Lumberboat'),
(27593,0,1,0,61,0,100,0,0,0,0,0,33,27702,0,0,0,0,0,7,0,0,0,0,0,0,0,'Rocket Propelled Warhead - on Ride Rocket Propelled Warhead SpellHit - Call KilledMonster Horde Lumberboat');

/* Encuentro en el aquelarre: --> Montañas Filospada */
SET @QUEST_MEETING_AT_THE_BLACKWING_COVEN := 10722;
SET @NPC_KOLPHIS := 22019;
SET @NPC_KOLPHIS_FIRST_GOSSIP := 8436;
SET @NPC_KOLPHIS_GOSSIP_QUESTCREDIT := 8439;
SET @SPELL_DISGUISE := 38157;
DELETE FROM gossip_menu WHERE entry IN (8436,8435,8437,8438,8439,8440);
INSERT INTO gossip_menu (entry, text_id) VALUES
(8436,10539),
(8435,10541),
(8437,10542),
(8438,10543),
(8439,10544),
(8440,10545);
DELETE FROM npc_text WHERE id IN (10539,10541,10542,10543,10544,10545);
INSERT INTO npc_text (id, text0_0) VALUES
(10539, 'Nuaar, are you feeling well? You don"t look like yourself today.'),
(10541, 'Right, the meeting. Let"s get down to it then.$B$BThe fact is that the lumber and livestock being gathered from the Ruuan Weald, which you"re responsible for, has slowed to a trickle.$B$BWe need those resources, but you"ve allowed the druids of the Cenarion Expedition to get in the way!'),
(10542, 'I don"t want excuses, I demand results!$B$BYou think what we"ve doing here is a joke?$B$BIf we don"t do this right, then not only will the so-called do-gooders come calling, but we"ll be found unworthy for elevation within the ranks of the Blackwing.'),
(10543, 'You could at least try to sound a little bit convincing.$B$BLook, Nuaar I wasn"t going to tell you this, but I might as well because it"s going to involve you, too.$B$BMaxnar Is planning an all-out attack on the druids at Ruuan Weald. And he intends to wipe them out.$B$BIt"s bad enough that we"ve beend fighting with the Boulder"mok ogres, so we can"t afford another front to deal with. I"ve arrangged for a temporary truce with the Arrakkoa.$B$BWell, what do you think?'),
(10544, 'We"ve putting the final preparations together even as we speak. The rest will depend upon how quickly you can organize you forces at Ruuan Weald.$B$BDo you think that you can handle that and get done quickly?'),
(10545, 'That"s the spirit!$B$BI"m glad that we had this little meeting. I feel much better about the attack now. With leader like you on the front, how can we lose?$B$BAlright, you have your marching orders. Now get back to the Ruuan Weald and make it happen!');
DELETE FROM gossip_menu_option WHERE menu_id IN (8436,8435,8437,8438,8439,8440);
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id) VALUES
(8436,0,0, 'I"m fine, thank you. You asked for me?',1,1,8435),
(8435,0,0, 'Oh, it"s not my fault, I can assure you.',1,1,8437),
(8437,0,0, 'Um, no... no, I don"t want that at all.',1,1,8438),
(8438,0,0, 'Impressive. When do we attack?',1,1,8439),
(8439,0,0, 'Absolutely!',1,1,8440);
UPDATE creature_template SET npcflag=npcflag|1, gossip_menu_id=@NPC_KOLPHIS_FIRST_GOSSIP WHERE entry=@NPC_KOLPHIS;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=@NPC_KOLPHIS;
DELETE FROM smart_scripts WHERE entryorguid=@NPC_KOLPHIS AND source_type=0;
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(@NPC_KOLPHIS,0,0,0,62,0,100,0,@NPC_KOLPHIS_GOSSIP_QUESTCREDIT,0,0,0,15,@QUEST_MEETING_AT_THE_BLACKWING_COVEN,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Kolphis - On 5th Gossip Select - Give Credit');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=@NPC_KOLPHIS_FIRST_GOSSIP;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, Comment) VALUES
(15,@NPC_KOLPHIS_FIRST_GOSSIP,0,1,9,@QUEST_MEETING_AT_THE_BLACKWING_COVEN, 'Gossip 8436 available if player has Q10722'),
(15,@NPC_KOLPHIS_FIRST_GOSSIP,0,1,1,@SPELL_DISGUISE, 'Gossip 8436 available if player has Overseer Disguise aura');

/* ¡Destruye las forjas! --> Cumbres Tormentosas */

UPDATE creature_template SET AIName='SmartAI',flags_extra=128 WHERE entry IN (30209,30211,30212);
DELETE FROM smart_scripts WHERE entryorguid IN (30209,30211,30212);
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(30209,0,0,1,8,0,100,0,56275,0,0,0,33,30209,0,0,0,0,0,7,0,0,0,0,0,0,0,"North Lightning Forge - On Spellhit - Quest Credit"),
(30209,0,1,0,61,0,100,0,0,0,0,0,11,65129,0,0,0,0,0,1,0,0,0,0,0,0,0,"North Lightning Forge - On Spellhit - Cast Explosion"),
(30211,0,0,1,8,0,100,0,56275,0,0,0,33,30211,0,0,0,0,0,7,0,0,0,0,0,0,0,"Central Lightning Forge - On Spellhit - Quest Credit"),
(30211,0,1,0,61,0,100,0,0,0,0,0,11,65129,0,0,0,0,0,1,0,0,0,0,0,0,0,"Central Lightning Forge - On Spellhit - Cast Explosion"),
(30212,0,0,1,8,0,100,0,56275,0,0,0,33,30212,0,0,0,0,0,7,0,0,0,0,0,0,0,"South Lightning Forge - On Spellhit - Quest Credit"),
(30212,0,1,0,61,0,100,0,0,0,0,0,11,65129,0,0,0,0,0,1,0,0,0,0,0,0,0,"South Lightning Forge - On Spellhit - Cast Explosion");

/* Da'd de comedd a ezoz necrófagoz --> Zul´drak */

SET @ghoul := 28565;
SET @Triger := 28591;
SET @SOURCETYPE := 0;
UPDATE creature_template SET AiName='SmartAI', flags_extra=flags_extra|2|128 WHERE entry=@Triger;
UPDATE creature_template SET AiName='SmartAI' WHERE entry=@ghoul;
DELETE FROM creature_ai_scripts WHERE creature_id IN (@ghoul, @Triger);
DELETE FROM smart_scripts WHERE entryorguid IN (@ghoul, @Triger);
INSERT INTO smart_scripts VALUES
(@ghoul, @SOURCETYPE, 0, 0, 38, 0, 100, 0, 0, 1, 0, 0, 29, 1, 1, 28591, 0, 0, 0, 19, @Triger, 15, 0, 0, 0, 0, 0,'Ghoul - on data 1 set - start follow'),
(@ghoul, @SOURCETYPE, 1, 2, 65, 0, 100, 0, 0, 0, 0, 0, 33, 28591, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0,'Ghoul - on follow completed - give kill credit'),
(@ghoul, @SOURCETYPE, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Ghoul - on follow completed - despawn'),
(@ghoul, @SOURCETYPE, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 11, @Triger, 50, 0, 0, 0, 0, 0,'Ghoul - on follow completed - kill ghoul'),
(@Triger, @SOURCETYPE, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, @ghoul, 15, 0, 0, 0, 0, 0,'Ghoul Trigger - on just summoned - set data 1 on nearest Ghoul');

/* Y ahora, el momento de la verdad --> Bosque de Terokkar */

SET @ENTRY := 19606;
DELETE FROM creature_ai_texts WHERE entry IN (-247,-246,-245,-244);
DELETE FROM creature_text WHERE entry=@ENTRY;
INSERT INTO creature_text (entry,groupid,id,text,type,language,probability,emote,duration,sound,comment) VALUES
(@ENTRY,0,0,"Someone come read this wanted poster to Grek. Grek can't read.",12,0,100,18,0,6941,"Grek1"),
(@ENTRY,1,0,"Grek get a drink.",12,0,100,7,0,0,"Grek2"),
(@ENTRY,2,0,"Grek try!",12,0,100,5,0,0,"Grek - Quest1"),
(@ENTRY,3,0,"This oil no good for Grek! What Grek look like to you, some weakling in robes?",12,0,100,6,0,0,"Grek - Quest2");
UPDATE creature_template SET gossip_menu_id = 7999 WHERE entry = @ENTRY;
DELETE FROM gossip_menu WHERE entry=7999 AND text_id=9853;
INSERT INTO gossip_menu (entry,text_id) VALUES (7999,9853);
DELETE FROM gossip_menu_option WHERE menu_id=7999;
INSERT INTO gossip_menu_option (menu_id,id,option_icon,option_text,option_id,npc_option_npcflag,action_menu_id,action_poi_id,box_coded,box_money,box_text) VALUES
(7999,0,0,"Grek, will you try out this new weapon oil Rakoria made?",1,1,0,0,0,0,'');
UPDATE creature_template SET AIName='SmartAI' WHERE entry = @ENTRY;
DELETE FROM creature_ai_scripts WHERE creature_id=@ENTRY;
DELETE FROM smart_scripts WHERE entryorguid=@ENTRY AND source_type=0;
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(@ENTRY,0,0,0,1,0,100,0,120000,120000,120000,120000,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Grek - OOC - Say Grek1"),
(@ENTRY,0,1,0,1,0,100,0,420000,420000,420000,420000,1,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Grek - OOC - Say Grek2"),
(@ENTRY,0,2,3,62,0,100,0,7999,0,0,0,1,2,3000,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Grek - On gossip select - Say Quest1"),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Grek - Link - Close gossip"),
(@ENTRY,0,4,5,52,0,100,0,2,@ENTRY,0,0,1,3,10000,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Grek - On text_over - Say Quest2"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Grek - Link - Give quest credit");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=7999 AND SourceEntry=0;
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,ElseGroup,ConditionTypeOrReference,ConditionValue1,ConditionValue2,ConditionValue3,ErrorTextId,ScriptName,Comment) VALUES
(15,7999,0,0,9,10201,0,0,0,'',"Display gossip only if quest taken");

/* Pasar desapercibido --> Tundra Boreal */

SET @Blood := 4135;
SET @Decay := 4136;
SET @Pain := 4137;
SET @ReqAura := 45614;
SET @Quest := 11633;
SET @Credit1 := 45627;
SET @Credit2 := 45628;
SET @Credit3 := 45629;
DELETE FROM creature_ai_scripts WHERE creature_id IN (25471,25472,25473);
DELETE FROM creature WHERE id IN (25471,25472,25473);
DELETE FROM spell_area WHERE spell IN (@Credit1,@Credit2,@Credit3);
INSERT INTO spell_area (spell, area, quest_start, quest_start_active, quest_end, aura_spell, racemask, gender, autocast) VALUES
(@Credit1,@Decay,@Quest,1,@Quest,@ReqAura,0,2,1),
(@Credit2,@Blood,@Quest,1,@Quest,@ReqAura,0,2,1),
(@Credit3,@Pain,@Quest,1,@Quest,@ReqAura,0,2,1);

Delete from creature_addon where guid in(85121,85206);

/* Tú, robot --> Tormenta Abisal */

DELETE FROM creature_ai_scripts WHERE creature_id=19851;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=19851;
DELETE FROM smart_scripts WHERE entryorguid=19851;
INSERT INTO smart_scripts VALUES
(19851,0,0,0,9,0,100,0,8,25,15000,21000,11,35570,0,0,0,0,0,2,0,0,0,0,0,0,0,'Negatron - Cast Charge'),
(19851,0,1,0,9,0,100,0,0,5,15000,21000,11,34625,0,0,0,0,0,2,0,0,0,0,0,0,0,'Negatron - Cast Demolish'),
(19851,0,2,0,0,0,100,0,15000,19000,21000,25000,11,35565,0,0,0,0,0,2,0,0,0,0,0,0,0,'Negatron - Cast Earthquake'),
(19851,0,3,0,2,0,100,0,0,50,16000,22000,11,34624,0,0,0,0,0,1,0,0,0,0,0,0,0,'Negatron - Cast Frenzy at 50% HP'),
(19851,0,4,0,6,0,100,0,0,0,0,0,15,10248,0,0,0,0,0,7,0,0,0,0,0,0,0,'Negatron - Death - Quest Complete');
Update creature_template set unit_flags=0 where entry=19851;
UPDATE quest_template SET SourceItemId=0, SourceItemCount=0, RequiredItemId2=0,flags=136, RequiredItemCount2=0 where id=10248;

/* Posponiendo lo inevitable --> Gelidar (El Nexo) */

UPDATE creature_template SET flags_extra = 128 WHERE entry = 26105;
DELETE FROM event_scripts WHERE id = 17364;
INSERT INTO event_scripts (id,delay,command,datalong,datalong2,dataint,x,y,z,o) VALUES
(17364,0,8,26105,0,0,0,0,0,0);
UPDATE gameobject_template SET data1 = 25 WHERE entry = 300183;

/* Distorsiones temporales: --> Cumbres Tormentosas */
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(30444);
DELETE FROM smart_scripts WHERE entryorguid IN(30444);
INSERT INTO smart_scripts VALUES (30444, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 30446, 7, 0, 0, 0, 0, 0, 'The Chieftain\'s Totem - OOC 1 Sec - Set Data to Rift at 7 Yards');
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(30446);
DELETE FROM smart_scripts WHERE entryorguid IN(30446);
INSERT INTO smart_scripts VALUES
(30446, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 33, 30444, 0, 0, 0, 0, 0, 18, 15, 0, 0, 0, 0, 0, 0, 'Frostfloe Rift - Data Set - Credit'),
(30446, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostfloe Rift - Linked - Unseen'),
(30446, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostfloe Rift - Linked - Despawn');

/* Recuerdos de Pezuña Tempestuosa: --> Cumbres Tormentosas */

DELETE FROM gossip_menu_option WHERE menu_id=9906 AND id=0;
INSERT INTO gossip_menu_option (menu_id,id,option_icon,option_text,option_id,npc_option_npcflag,action_menu_id,action_poi_id,box_coded,box_money,box_text) VALUES
(9906,0,0,"Lamento perturbar su descanso, jefe, pero el espíritu de su hermano puede estar en peligro. ¿Me puedes decir lo que recuerdas de él?",1,1,0,0,0,0,'');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9906 AND SourceEntry=0;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, Comment) VALUES
(15,9906,0,0,9,13037,'Only show gossip if player has quest Memories of Stormhoof');
UPDATE creature_template SET AIName = 'SmartAI' WHERE entry = 30395;
DELETE FROM smart_scripts WHERE (entryorguid=30395 AND source_type=0);
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(30395,0,0,0,62,0,100,0,9906,0,0,0,33,30381,0,0,0,0,0,7,0,0,0,0,0,0,0,'Chieftain Swiftspear - On gossip select - Call killedmonster for quest Memories of Stormhoof');

/* Cambiar el curso del viento --> Cumbres Tormentosas */

SET @Stormhoof := 30388;
SET @VehicleSpell := 56863;
SET @Ride := 46598;
SET @Wind := 30474;
SET @DropHorn := 56892;
SET @Stun := 62794;
SET @Guid := 938394;

DELETE FROM creature WHERE guid=@Guid;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(@Guid,@Wind,571,1,256,0,0,7942.61,-2723.29,1138,6.09394,60,0,0,63000,19970,0,0,0,0);

UPDATE creature_template SET AIName='SmartAI',spell1=56897,spell2=61668,spell3=56896 WHERE entry=30388;
DELETE FROM smart_scripts WHERE entryorguid=@Stormhoof;
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(@Stormhoof,0,0,1,54,0,100,0,0,0,0,0,11,56900,0,0,0,0,0,7,0,0,0,0,0,0,0,'Stormhoof - On summoned - Cast power of Lorehammer on invoker /used to store invoker/'),
(@Stormhoof,0,1,0,61,0,100,0,0,0,0,0,85,@Ride,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormhoof - Linked with previous event - Ivoker cast Ride hardcoded on Stormhoof '),
(@Stormhoof,0,2,0,4,0,100,1,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormhoof - On aggro - Disable auto attacks'),
(@Stormhoof,0,3,0,8,0,100,0,@Ride,0,0,0,2,2141,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormhoof - On hit by spell Ride - Change faction to hostile towards Wind'),
(@Stormhoof,0,4,5,38,0,100,0,0,1,0,0,18,8196,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormhoof - On data set 0 1 - Set unit flags for No move, Silence and Pacified'),
(@Stormhoof,0,5,0,61,0,100,0,0,0,0,0,1,0,1000,0,0,0,0,1,0,0,0,0,0,0,0,'Stormhoof - Linked with previous event - Say text 1'),
(@Stormhoof,0,6,7,38,0,100,0,0,2,0,0,75,@Stun,0,0,0,0,0,19,@Wind,30,0,0,0,0,0,'Stormhoof - On Data set 0 2 - Set stun on wind'),
(@Stormhoof,0,7,8,61,0,100,0,0,0,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormhoof - Linked with previous event - Die'),
(@Stormhoof,0,8,0,61,0,100,0,0,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormhoof - Linked with previous event - Set unseen'),
(@Stormhoof,0,9,10,6,0,100,0,0,0,0,0,19,8196,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormhoof - On death - Remove unit_flags'),
(@Stormhoof,0,10,0,61,0,100,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormhoof - Linkedw with previous event - Change faction to 35');

UPDATE creature_template SET mindmg=327,maxdmg=362,faction_A=16,faction_H=16,AIName='SmartAI' WHERE entry=@Wind;
DELETE FROM creature_ai_scripts WHERE creature_id=@Wind;
DELETE FROM smart_scripts WHERE entryorguid=@Wind;
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(@Wind,0,0,0,0,0,100,0,1000,3000,14000,17000,11,61662,0,0,0,0,0,2,0,0,0,0,0,0,0,'North Wind - IC - Cast Cyclone'),
(@Wind,0,1,0,0,0,100,0,1000,8000,17000,21000,11,61663,0,0,0,0,0,2,0,0,0,0,0,0,0,'North Wind - IC - Gust of Wind'),
(@Wind,0,2,3,2,0,100,1,10,20,20000,20000,11,@DropHorn,0,0,0,0,0,2,0,0,0,0,0,0,0,'North Wind - Between 10 and 20% HP - Drop Horn'),
(@Wind,0,3,4,61,0,100,0,0,0,0,0,18,139270,0,0,0,0,0,1,0,0,0,0,0,0,0,'North Wind - Linked with previous event - Set unit flags for No move, Silence and Pacified'),
(@Wind,0,4,0,61,0,100,0,0,0,0,0,1,0,1200,0,0,0,0,1,0,0,0,0,0,0,0,'North Wind - Linked with previous event - Say text 0'),
(@Wind,0,5,6,52,0,100,0,0,@Wind,0,0,45,0,1,0,0,0,0,19,@Stormhoof,30,0,0,0,0,0,'North Wind - On text 0 over - Set data 0 1 on Stormhoof'),
(@Wind,0,6,0,61,0,100,0,0,0,0,0,1,1,4000,0,0,0,0,1,0,0,0,0,0,0,0,'North Wind - Linked with previous event - Say text 1'),
(@Wind,0,7,0,52,0,100,0,1,@Wind,0,0,45,0,2,0,0,0,0,19,@Stormhoof,30,0,0,0,0,0,'North Wind - On text over 1 - Data set 0 2 on Stormhoof'),
(@Wind,0,8,9,38,0,100,1,0,2,0,0,1,2,1000,0,0,0,0,1,0,0,0,0,0,0,0,'North Wind - On data set 0 2 - Say text 2'),
(@Wind,0,9,0,61,0,100,0,0,0,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'North Wind - Linked with previous event - Die'),
(@Wind,0,10,0,6,0,100,0,0,0,0,0,19,139270,0,0,0,0,0,1,0,0,0,0,0,0,0,'North Wind - On death - Remove unit_flags');

DELETE FROM creature_text WHERE entry IN (@Wind,@Stormhoof);
INSERT INTO creature_text (entry,groupid,id,text,type,language,probability,emote,duration,sound,comment) VALUES
(@Wind,0,0,'Fool! You will never defeat me!',14,0,100,1,1200,0,'North Wind'),
(@Wind,1,0,'I will never allow you to use the Horn of Elemental Fury against us! Die, weakling!',14,0,100,1,3000,0,'North Wind'),
(@Wind,2,0,'That horn is... MINE!',14,0,100,1,2000,0,'North Wind'),
(@Stormhoof,0,0,'The horn! Use the horn on it while it''s weak!',14,0,100,1,1000,0,'Stormhoof');

SET @GO := 194123;
UPDATE gameobject_template SET AIName= 'SmartGameObjectAI' WHERE entry=@GO;
DELETE FROM smart_scripts WHERE source_type=1 AND entryorguid=@GO;
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(@GO,1,0,0,70,0,100,0,2,0,0,0,45,0,2,0,0,0,0,19,@Wind,30,0,0,0,0,0,'Horn of Elemental Fury - On state changed - Data set 0 2 on The Winf of North');

DELETE FROM disables WHERE entry=@VehicleSpell;
INSERT INTO disables (sourceType, entry, flags, params_0, params_1, comment) VALUES
(0,@VehicleSpell,1,'0','0', 'Spell 56900 is TPing to home position');

UPDATE item_template SET spellid_1=56900 WHERE entry=42918;

SET @Guid1 := 1023207;
DELETE FROM creature WHERE guid=@Guid1;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(@Guid1,@Stormhoof,571,1,256,0,0,7978.93,-2728.28,1137.36,2.98987,60,0,0,36525,3893,0,0,0,0);

UPDATE creature_template SET npcflag=16777216 WHERE entry=@Stormhoof;
DELETE FROM npc_spellclick_spells WHERE npc_entry=@Stormhoof;
INSERT INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES
(@Stormhoof,@Ride,1,0);

/* Una madeja enredada --> Zul´drak */
UPDATE quest_template SET RequiredNpcOrGo1 = 28274, RequiredSpellCast1 = 51165 WHERE id = 12555;
UPDATE creature_template SET AIName = 'EventAI' WHERE entry = 28274;
INSERT INTO creature_ai_scripts VALUES
( 2827400, 28274, 8, 0, 100, 0, 51165, -1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 'Increase phase on spellhit.'),
( 2827401, 28274, 0, 1, 100, 0, 5100, 5200, 0, 0, 11, 53236, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Sprayer explosion.'),
( 2827402, 28274, 0, 1, 100, 0, 5400, 5500, 0, 0, 11, 51314, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Sprayer spawn corpse.'),
(2827403, 28274, 0, 1, 100, 0, 5600, 5700, 0, 0, 41, 0, 0, 0, 23, -1, 0, 0, 0, 0, 0, 0, 'Sprayer despawn.');

/* ¡Cruzada Argenta, nos vamos! --> Zul´drak */

SET @Gossip :=9640;
SET @NPCText :=13047;

DELETE FROM gossip_menu WHERE entry IN (@Gossip);
INSERT INTO gossip_menu VALUES
(@Gossip,@NPCText);

DELETE FROM npc_text WHERE id IN (@NPCText);
INSERT INTO npc_text (id,text0_0) VALUES
(@NPCText,'¿Que estas haciendo aqui?');

DELETE FROM gossip_menu_option WHERE menu_id IN (@Gossip);
INSERT INTO gossip_menu_option VALUES
(@Gossip,0,0,"Soldado, usted tiene nuevas ordenes. Tiene que dar marcha atrás e informar al sargento",1,1,0,0,0,0,NULL);

UPDATE creature_template SET gossip_menu_id=@Gossip, AIName='SmartAI', npcflag=1 WHERE entry=28041;

DELETE FROM creature_ai_scripts WHERE creature_id=28041;
DELETE FROM smart_scripts WHERE entryorguid IN(28041,2804100);
INSERT INTO smart_scripts VALUES
(28041,0,0,0,0,0,100,0,8000,10000,8000,12000,11,50370,0,0,0,0,0,2,0,0,0,0,0,0,0,'Argent Soldier - Combat - Cast Sunder Armor'),
(28041,0,1,2,62,0,100,0,@Gossip,0,0,0,33,28041,0,0,0,0,0,7,0,0,0,0,0,0,0,'Argent Soldier - On Gossip - Credit'),
(28041,0,2,3,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Argent Soldier - Event Linked - Close Gossip'),
(28041,0,3,4,61,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Soldier - Event Linked - NpcFlag Remove'),
(28041,0,4,0,61,0,100,0,0,0,0,0,80,2804100,0,2,0,0,0,1,0,0,0,0,0,0,0,'Argent Soldier - Event Linked - Run Script'),
(2804100,9,0,0,0,0,100,0,6000,6000,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Soldier - Script 6 Seconds - Unseen'),
(2804100,9,1,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Soldier - Script - Despawn');

DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=@Gossip;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry,ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(15, @Gossip, 0, 0, 9, 12504, 0, 0, 0, '', NULL);

/* Arriba la cola --> Zul´drak */

SET @ENTRY := 29327;
SET @QUEST := 13549;
SET @GOSSIP := 54000;
SET @SPELL_RAKE := 54668;
SET @SPELL_BLOWGUN := 62105;
SET @SPELL_SLEEP := 42386;
UPDATE creature_template SET AIName='SmartAI',npcflag=0,gossip_menu_id=@GOSSIP,faction_A=1990,faction_H=1990,unit_flags=0 WHERE entry=@ENTRY;
DELETE FROM creature_ai_scripts WHERE creature_id=@ENTRY;
DELETE FROM smart_scripts WHERE entryorguid IN (@ENTRY,@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2);
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_RAKE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Frost Leopard - In Combat - Cast Rake"),
(@ENTRY,0,1,0,25,0,100,0,0,0,0,0,2,1990,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Reset - Set Faction Back"),
(@ENTRY,0,2,0,8,0,100,1,@SPELL_BLOWGUN,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Spellhit - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script - Set Faction Friendly"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,11,@SPELL_SLEEP,2,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script - Cast Sleep"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script - Set npc_flag Gossip"),
(@ENTRY,0,3,0,62,0,100,0,@GOSSIP,0,0,0,88,@ENTRY*100+1,@ENTRY*100+2,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Gossip Select - Run Random Script"),
(@ENTRY*100+1,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - Script 1 - Say Line 0"),
(@ENTRY*100+1,9,1,0,0,0,100,0,1000,1000,0,0,36,33007,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 1 - Update Template Male"),
(@ENTRY*100+1,9,2,0,0,0,100,0,0,0,0,0,28,@SPELL_SLEEP,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 1 - Remove Sleep"),
(@ENTRY*100+1,9,3,0,0,0,100,0,0,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 1 - Remove OOC Flag"),
(@ENTRY*100+2,9,0,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - Script 2 - Say Line 1"),
(@ENTRY*100+2,9,1,0,0,0,100,0,0,0,0,0,36,33010,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Update Template Female"),
(@ENTRY*100+2,9,2,0,0,0,100,0,0,0,0,0,28,@SPELL_SLEEP,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Remove Sleep"),
(@ENTRY*100+2,9,3,0,0,0,100,0,0,0,0,0,33,33005,0,0,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Quest Credit"),
(@ENTRY*100+2,9,4,0,0,0,100,0,0,0,0,0,29,0,0,28527,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Follow Player");
DELETE FROM gossip_menu WHERE entry=@GOSSIP AND text_id=14266;
INSERT INTO gossip_menu (entry,text_id) VALUES (@GOSSIP,14266);
DELETE FROM gossip_menu_option WHERE menu_id=@GOSSIP;
INSERT INTO gossip_menu_option (menu_id,id,option_icon,option_text,option_id,npc_option_npcflag,action_menu_id) VALUES
(@GOSSIP,0,0,"Levanta la cola del leopardo de las heladas para comprobar si es un macho o una hembra.",1,1,0);
DELETE FROM creature_text WHERE entry=@ENTRY;
INSERT INTO creature_text (entry,groupid,id,text,type,language,probability,emote,duration,sound,comment) VALUES
(@ENTRY,0,0,"¡Es un macho cabreado!",42,0,100,0,0,0,"Male Frost Leopard"),
(@ENTRY,1,0,"¡Es una hembra!",42,0,100,0,0,0,"Female Frost Leopard");
SET @ENTRY := 33007;
SET @SPELL_RAKE := 54668;
UPDATE creature_template SET AIName='SmartAI',faction_A=1990,faction_H=1990,unit_flags=unit_flags|0 WHERE entry=@ENTRY;
DELETE FROM smart_scripts WHERE entryorguid IN (@ENTRY,@ENTRY*100);
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(@ENTRY,0,0,0,0,0,100,0,3000,4000,9000,11000,11,@SPELL_RAKE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Male Frost Leopard - In Combat - Cast Rake");
SET @ENTRY := 33010;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=@ENTRY;
SET @ENTRY := 29319;
SET @QUEST := 13549;
SET @GOSSIP := 55000;
SET @SPELL_CLAWS_OF_ICE := 54632;
SET @SPELL_BLOWGUN := 62105;
SET @SPELL_SLEEP := 42386;
UPDATE creature_template SET AIName='SmartAI',npcflag=0,gossip_menu_id=@GOSSIP,faction_A=1990,faction_H=1990,unit_flags=32768 WHERE entry=@ENTRY;
DELETE FROM creature_ai_scripts WHERE creature_id=@ENTRY;
DELETE FROM smart_scripts WHERE entryorguid IN (@ENTRY,@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2);
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_CLAWS_OF_ICE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Icepaw Bear - In Combat - Cast Claws of Ice"),
(@ENTRY,0,1,0,25,0,100,0,0,0,0,0,2,1990,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Reset - Set Faction Back"),
(@ENTRY,0,2,0,8,0,100,1,@SPELL_BLOWGUN,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Spellhit - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script - Set Faction Friendly"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,11,@SPELL_SLEEP,2,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script - Cast Sleep"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script - Set npc_flag Gossip"),
(@ENTRY,0,3,0,62,0,100,0,@GOSSIP,0,0,0,88,@ENTRY*100+1,@ENTRY*100+2,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Gossip Select - Run Random Script"),
(@ENTRY*100+1,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Icepaw Bear - Script 1 - Say Line 0"),
(@ENTRY*100+1,9,1,0,0,0,100,0,1000,1000,0,0,36,33008,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 1 - Update Template Male"),
(@ENTRY*100+1,9,2,0,0,0,100,0,0,0,0,0,28,@SPELL_SLEEP,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 1 - Remove Sleep"),
(@ENTRY*100+1,9,3,0,0,0,100,0,0,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 1 - Remove OOC Flag"),
(@ENTRY*100+2,9,0,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Icepaw Bear - Script 2 - Say Line 1"),
(@ENTRY*100+2,9,1,0,0,0,100,0,0,0,0,0,36,33011,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Update Template Female"),
(@ENTRY*100+2,9,2,0,0,0,100,0,0,0,0,0,28,@SPELL_SLEEP,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Remove Sleep"),
(@ENTRY*100+2,9,3,0,0,0,100,0,0,0,0,0,33,33006,0,0,0,0,0,7,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Quest Credit"),
(@ENTRY*100+2,9,4,0,0,0,100,0,0,0,0,0,29,0,0,28527,0,0,0,7,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Follow Player");
DELETE FROM gossip_menu WHERE entry=@GOSSIP AND text_id=14267;
INSERT INTO gossip_menu (entry,text_id) VALUES (@GOSSIP,14267);
DELETE FROM gossip_menu_option WHERE menu_id=@GOSSIP;
INSERT INTO gossip_menu_option (menu_id,id,option_icon,option_text,option_id,npc_option_npcflag,action_menu_id) VALUES
(@GOSSIP,0,0,"Lift the icepaw bear's tail to check if it's a male or a female.",1,1,0);
DELETE FROM creature_text WHERE entry=@ENTRY;
INSERT INTO creature_text (entry,groupid,id,text,type,language,probability,emote,duration,sound,comment) VALUES
(@ENTRY,0,0,"It's an angry male!",42,0,100,0,0,0,"Male Icepaw Bear"),
(@ENTRY,1,0,"It's a female!",42,0,100,0,0,0,"Female Icepaw Bear");
SET @ENTRY := 33008;
SET @SPELL_CLAWS_OF_ICE := 54632;
UPDATE creature_template SET AIName='SmartAI',faction_A=1990,faction_H=1990,unit_flags=unit_flags|0 WHERE entry=@ENTRY;
DELETE FROM smart_scripts WHERE entryorguid IN (@ENTRY,@ENTRY*100);
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(@ENTRY,0,0,0,0,0,100,0,3000,4000,9000,11000,11,@SPELL_CLAWS_OF_ICE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Male Icepaw Bear - In Combat - Cast Claws of Ice");
SET @ENTRY := 33011;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=@ENTRY;

/* Donde vagan las cosas salvajes --> Cementerio de los Dragones */

DELETE FROM conditions WHERE SourceEntry=47627;
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,ElseGroup,ConditionTypeOrReference,ConditionValue1,ConditionValue2,ConditionValue3,
ErrorTextId,Scriptname,Comment) VALUES
(17, 0, 47627, 0, 9, 12111, 0, 0, 0, '', NULL),
(17, 0, 47627, 0, 23, 65, 0, 0, 0, '', NULL);

UPDATE creature_template SET AIName='SmartAI' WHERE entry IN (26615,26482);
DELETE FROM creature_ai_scriptswhere creature_id IN (26615,26482);
DELETE FROM smart_scripts WHERE entryorguid IN (26615,26482);
INSERT INTO smart_scripts VALUES
(26615,0,0,0,9,0,100,1,0,5,8000,12000,11,15976,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Snowfall Elk - Cast Puncture'),
(26615,0,1,2,23,0,100,1,47628,1,1,1,11,47675,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Snowfall Elk - On Aura - Cast Recently Inoculated'),
(26615,0,2,3,61,0,100,1,0,0,0,0,33,26895,0,0,0,0,0,18,40,0,0,0,0,0,0, 'Snowfall Elk - Event Linked - Credit'),
(26615,0,3,0,61,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Snowfall Elk - Event Linked - Despawn Delay 5 Seconds'),
(26482,0,0,1,23,0,100,1,47628,1,1,1,11,47675,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Arctic Grizzly - On Aura - Cast Recently Inoculated'),
(26482,0,1,2,61,0,100,1,0,0,0,0,33,26882,0,0,0,0,0,18,40,0,0,0,0,0,0, 'Arctic Grizzly - Event Linked - Credit'),
(26482,0,2,0,61,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Arctic Grizzly - Event Linked - Despawn Delay 5 Seconds');

/* Npc=18931 Actualizados los gossips para poder volar directamente a Bastión del Honor para la quest 'Viaje al Bastión del Honor' y para que pueda mostrarte las rutas de vuelo */

SET @criatura:=18931;
SET @dialogo:=7939;
DELETE FROM gossip_menu WHERE entry =@dialogo;
DELETE FROM npc_text WHERE ID IN (9935,9991);
INSERT INTO gossip_menu (entry,text_id) VALUES
(@dialogo,10052);

DELETE FROM gossip_menu_option WHERE menu_id =@dialogo;
INSERT INTO gossip_menu_option (menu_id,id,option_icon,option_text,option_id,npc_option_npcflag,action_menu_id,action_poi_id,box_coded,box_money,box_text) VALUES
(@dialogo,0,2,'Muéstrame a donde puedo volar',4,8192,0,0,0,0,''),
(@dialogo,1,2,'¡Envíame a Bastión del Honor!',4,8192,0,0,0,0,'');

DELETE FROM creature_ai_scripts WHERE creature_id =@criatura;
UPDATE creature_template SET AIName= 'SmartAI' WHERE entry =@criatura;
DELETE FROM smart_scripts WHERE entryorguid =@criatura;
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(@criatura,0,0,0,62,0,100,0,@dialogo,1,0,0,11,34907,2,0,0,0,0,7,0,0,0,0,0,0,0,'Amish Wildhammer - On gossip option 1 select - Cast Stair of Destiny to Honor Hold'),
(@criatura,0,1,0,4,0,100,0,0,0,0,0,12,9526,4,30000,0,0,0,1,0,0,0,0,0,0,0,'Amish Wildhammer - Summon Enraged Gryphon on Aggro'),
(@criatura,0,2,0,4,0,100,0,0,0,0,0,12,9526,4,30000,0,0,0,1,0,0,0,0,0,0,0,'Amish Wildhammer - Summon Enraged Gryphon on Aggro'),
(@criatura,0,3,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Amish Wildhammer - Say text on Aggro');

/* Plaga Chamuscada --> Colinas Pardas (La normal y la diaria) */

DELETE FROM creature_ai_scripts WHERE creature_id=26570;
DELETE FROM creature_template_addon WHERE entry=26570;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=26570;
DELETE FROM smart_scripts WHERE (entryorguid=26570 AND source_type=0);
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(26570, 0, 0, 0, 8, 0, 100, 0, 47214, 0, 0, 0, 11, 42726, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Famished Scourge Troll in Spellhit Cast Cosmetic Immolation (Whole Body)'),
(26570, 0, 1, 0, 8, 0, 100, 0, 47214, 0, 0, 0, 11, 47208, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Famished Scourge Troll in Spell Hit Cast Kill Credit Spell For Player'),
(26570, 0, 2, 0, 8, 0, 100, 0, 47214, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Famished Scourge Troll Dies In Spell Hit'),
(26570, 0, 3, 0, 1, 0, 100, 0, 100, 100, 5000, 5000, 11, 47178, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Famished Scourge Troll Cast Cosmetic Plague in Self ICC');
UPDATE quest_template SET method=2,RequiredNpcOrGo1=26612,RequiredNpcOrGoCount1=20 WHERE id=12029;
UPDATE quest_template SET Method=2,RequiredNpcOrGo1 =26612,RequiredNpcOrGoCount1=30 WHERE id=12038;
UPDATE creature SET spawntimesecs= 60, MovementType = 1, spawndist= 10 WHERE id=26570;
UPDATE creature_template SET speed_run=6, spell1= 51744 WHERE entry =26570;

/* El peso de la justicia --> Zul´drak */

SET @Medallion := 52596;
SET @Mammoth := 28851;
SET @Trample := 52603;
SET @TAura := 52607;
SET @Desciple := 28861;
SET @Credit := 28876;
UPDATE creature_template SET AIName='SmartAI',spell1=52601,spell2=52603 WHERE entry=@Mammoth;
DELETE FROM smart_scripts WHERE entryorguid=@Mammoth AND source_type=0;
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(@Mammoth,0,0,0,8,0,100,0,@Medallion,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Enraged Mammoth - On hit by spell from medallion - Change faction to friendly'),
(@Mammoth,0,1,0,1,0,100,0,15000,15000,15000,15000,2,1924,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Enraged Mammoth - On OOC for 10 sec - Change faction to back to normal');
-- Añadir SAI para discípulo Mam'toth
UPDATE creature_template SET AIName='SmartAI' WHERE entry=@Desciple;
DELETE FROM smart_scripts WHERE entryorguid=@Desciple AND source_type=0;
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(@Desciple,0,0,0,6,0,100,0,0,0,0,0,33,@Credit,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Mam''toth desciple - On death - Give credit to invoker, if Tampered'),
(@Desciple,0,1,0,25,0,100,0,0,0,0,0,28,@TAura,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Mam''toth desciple - On reset - Remove aura from trample');
-- Condiciones
DELETE FROM conditions WHERE SourceEntry=@Medallion AND SourceTypeOrReferenceId=17;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(17,0,@Medallion,0,0,31,1,3,@Mammoth,0,0,0,'', 'Medallion of Mam''toth can hit only Enraged Mammoths');
DELETE FROM conditions WHERE SourceEntry=@Trample AND SourceTypeOrReferenceId=13;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(13,1,@Trample,0,0,31,0,3,@Desciple,0,0,0,'', 'Trample effect 1 can hit only Desciple of Mam''toth'),
(13,2,@Trample,0,0,31,0,3,@Desciple,0,0,0,'', 'Trample effect 2 can hit only Desciple of Mam''toth');
DELETE FROM conditions WHERE SourceEntry=@Desciple AND SourceTypeOrReferenceId=22;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(22,1,@Desciple,0,0,1,1,@TAura,0,0,0,0,'', 'Mam''toth desciple 1st event is valid only, if has Tampered aura credit');
DELETE FROM conditions WHERE SourceEntry=@TAura AND SourceTypeOrReferenceId=13;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(13,1,@TAura,0,0,31,0,3,@Desciple,0,0,0,'', 'TAura effect can hit only Desciple of Mam''toth');

/* Imposible reproducir --> Corona del Hielo */

SET @NPC_BLUE_KC := 32242;
SET @NPC_GREEN_KC := 32244;
SET @NPC_DARK_KC := 32245;
SET @SPELL_COLLECT := 60256;
SET @SPELL_WRITHING := 60310;
SET @NPC_MASS_KC := 32266;
SET @AURA_DISCERNMENT := 60311;
SET @ITEM_ESSENCE := 44301;
UPDATE creature_template SET AIName='SmartAI',flags_extra=128 WHERE entry IN (@NPC_BLUE_KC,@NPC_GREEN_KC,@NPC_DARK_KC);
UPDATE creature SET MovementType=0,spawndist=0 WHERE id IN (@NPC_BLUE_KC,@NPC_GREEN_KC,@NPC_DARK_KC);

DELETE FROM smart_scripts WHERE entryorguid IN (@NPC_BLUE_KC,@NPC_GREEN_KC,@NPC_DARK_KC) AND source_type=0;
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(@NPC_BLUE_KC,0,0,0,8,0,100,0,@SPELL_COLLECT,0,0,0,33,@NPC_BLUE_KC,0,0,0,0,0,7,0,0,0,0,0,0,0,"Blue Sample KC Bunny - On spellhit - Killed moster credit"),
(@NPC_BLUE_KC,0,1,0,8,0,100,0,@SPELL_WRITHING,0,0,0,33,@NPC_MASS_KC,0,0,0,0,0,7,0,0,0,0,0,0,0,"Blue Sample KC Bunny - On spellhit - Killed moster credit"),

(@NPC_GREEN_KC,0,0,0,8,0,100,0,@SPELL_COLLECT,0,0,0,33,@NPC_GREEN_KC,0,0,0,0,0,7,0,0,0,0,0,0,0,"Green Sample KC Bunny - On spellhit - Killed moster credit"),
(@NPC_GREEN_KC,0,1,0,8,0,100,0,@SPELL_WRITHING,0,0,0,33,@NPC_MASS_KC,0,0,0,0,0,7,0,0,0,0,0,0,0,"Green Sample KC Bunny - On spellhit - Killed moster credit"),

(@NPC_DARK_KC,0,0,0,8,0,100,0,@SPELL_COLLECT,0,0,0,33,@NPC_DARK_KC,0,0,0,0,0,7,0,0,0,0,0,0,0,"Dark Sample KC Bunny - On spellhit - Killed moster credit"),
(@NPC_DARK_KC,0,1,0,8,0,100,0,@SPELL_WRITHING,0,0,0,33,@NPC_MASS_KC,0,0,0,0,0,7,0,0,0,0,0,0,0,"Dark Sample KC Bunny - On spellhit - Killed moster credit");

DELETE FROM conditions WHERE SourceEntry IN (@SPELL_COLLECT,@SPELL_WRITHING) AND SourceTypeOrReferenceId=13;
DELETE FROM conditions WHERE SourceEntry=@ITEM_ESSENCE AND SourceTypeOrReferenceId=1;
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,SourceId,ElseGroup,ConditionTypeOrReference,ConditionTarget,ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition,ErrorTextId,ScriptName,Comment) VALUES
(13,1,@SPELL_COLLECT,0,0,31,0,3,@NPC_BLUE_KC,0,0,0,'','Spell target creature'),
(13,1,@SPELL_COLLECT,0,1,31,0,3,@NPC_GREEN_KC,0,0,0,'','Spell target creature'),
(13,1,@SPELL_COLLECT,0,2,31,0,3,@NPC_DARK_KC,0,0,0,'','Spell target creature'),

(13,1,@SPELL_WRITHING,0,0,31,0,3,@NPC_BLUE_KC,0,0,0,'','Spell target creature'),
(13,1,@SPELL_WRITHING,0,1,31,0,3,@NPC_GREEN_KC,0,0,0,'','Spell target creature'),
(13,1,@SPELL_WRITHING,0,2,31,0,3,@NPC_DARK_KC,0,0,0,'','Spell target creature'),

(1,32236,@ITEM_ESSENCE,0,0,1,0,@AURA_DISCERNMENT,0,0,0,0,'','Loot requires aura'),
(1,32259,@ITEM_ESSENCE,0,0,1,0,@AURA_DISCERNMENT,0,0,0,0,'','Loot requires aura'),
(1,32262,@ITEM_ESSENCE,0,0,1,0,@AURA_DISCERNMENT,0,0,0,0,'','Loot requires aura'),
(1,32268,@ITEM_ESSENCE,0,0,1,0,@AURA_DISCERNMENT,0,0,0,0,'','Loot requires aura'),
(1,32276,@ITEM_ESSENCE,0,0,1,0,@AURA_DISCERNMENT,0,0,0,0,'','Loot requires aura'),
(1,32279,@ITEM_ESSENCE,0,0,1,0,@AURA_DISCERNMENT,0,0,0,0,'','Loot requires aura'),
(1,32289,@ITEM_ESSENCE,0,0,1,0,@AURA_DISCERNMENT,0,0,0,0,'','Loot requires aura'),
(1,32290,@ITEM_ESSENCE,0,0,1,0,@AURA_DISCERNMENT,0,0,0,0,'','Loot requires aura'),
(1,32297,@ITEM_ESSENCE,0,0,1,0,@AURA_DISCERNMENT,0,0,0,0,'','Loot requires aura');

/* Templar la Hoja --> Quel´Delar */

UPDATE creature_template SET faction_A=190,faction_H=190,baseattacktime=2000,unit_flags=768,flags_extra=128,AIName='SmartAI' WHERE entry=37094;

DELETE from smart_scripts where entryorguid=37094;

INSERT INTO smart_scripts VALUES (37094, 0, 0, 1, 8, 0, 0, 0, 69922, 0, 0, 0, 11, 70663, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crucible of Souls - On spellhit by Temper Quel\'Delar cast Shadownova');

INSERT INTO smart_scripts VALUES (37094, 0, 1, 0, 61, 0, 0, 0, 69922, 0, 0, 0, 11, 69956, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Crucible of Souls - On spellhit by Temper Quel\'Delar (link) cast Return Tempered Quel\'Delar');

DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=69922;

INSERT INTO conditions VALUES (13, 1, 69922, 0, 0, 31, 0, 3, 37094, 0, 0, 0, '', 'Temper Quel\'Delar - Crucible of Souls');

/* A lomos de la osa --> Cumbres Tormentosas */

UPDATE creature SET spawndist=0, MovementType=0 where id in (29498,29351,29358);
UPDATE creature_template SET ScriptName = 'npc_icefang' WHERE entry IN (29358,29351);
UPDATE quest_template SET RequiredNpcOrGo1=29358, RequiredNpcOrGo2=29351 where id=12851;

/* Guiado por el honor --> Fiordo Aquilonal */

UPDATE quest_template SET SourceSpellId=0,Method=2,Flags=128,SpecialFlags=2 where id=11289;
DELETE from spell_area where spell=43228;
insert into spell_area (spell,area,quest_start,quest_start_active,quest_end,aura_spell,racemask,gender,autocast) VALUES
(43228,3981,11289,1,11289,0,2047,2,1);

/* ¡Vamos a hacer surf! ( No fuca la spell)--> Fiordo Aquilonal */

UPDATE quest_template SET Method=0,Flags=65664,SpecialFlags=2 where id=11436;

/* Patrulla trol: hasta la muerte --> Zul´drak */

UPDATE creature_template SET unit_flags=0,type_flags=0,Health_mod=1, faction_A=14,faction_H=14 where entry=28260;
UPDATE quest_template SET RequiredNpcOrGo1=28260 where id=12568;
UPDATE quest_template SET SourceItemId=0,SourceItemCount=0 WHERE id=12568;

/* Apaciguar la Gran Piedra de Lluvia --> Cuenca de Scholazar */

DELETE FROM gameobject WHERE id=190561;
INSERT INTO gameobject (guid,id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES
(null,190561, 571, 1,1, 5623.81, 4575.30, -137.782, 0.62120,0,0,0,0,300,100,1),
(null,190561, 571, 1,1, 5644.79, 4553.52, -134.437, 1.35947,0,0,0,0,300,100,1),
(null,190561, 571, 1,1, 5656.10, 4567.27, -134.269, 2.16686,0,0,0,0,300,100,1),
(NULL,190561, 571, 1,1, 5649.01, 4599.76, -136.916, 5.09325,0,0,0,0,300,100,1),
(null,190561, 571, 1,1, 5680.40, 4537.14, -136.110, 5.18514,0,0,0,0,300,100,1);

DELETE FROM gameobject WHERE id=190563;
INSERT INTO gameobject (guid,id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES
(null,190563, 571, 1, 1, 5648.77, 4544.13, -134.129, 0.95891,0,0,0,0,300,100,1),
(null,190563, 571, 1, 1, 5591.50, 4653.75, -135.648, 3.71016,0,0,0,0,300,100,1);

DELETE FROM gameobject WHERE id=190560;
INSERT INTO gameobject (guid,id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES

(null,190560, 571, 1, 1, 5871.71, 4748.74, -132.800, 3.21065,0,0,0,0,300,100,1),
(null,190560, 571, 1, 1, 5695.81, 4536.54, -136.110, 3.87668,0,0,0,0,300,100,1),
(null,190560, 571, 1, 1, 5643.64, 4548.87, -131.895, 1.09401,0,0,0,0,300,100,1),
(null,190560, 571, 1, 1,5607.35, 4624.28, -136.885, 0.70996,0,0,0,0,300,100,1);

/* Pensando en el futuro --> Cementerio de los Dragones (Correguida la repu que daba, de 250 --> 500) */

UPDATE quest_template SET RewardFactionValueId1=5, RewardFactionValueIdOverride1=50000 where id=11960;

/* Concatena las misiones del npc 31135 y hace que los npcs de cada mision aparezcan al cogerlas (Código emu anterior adaptado al nuevo) */

UPDATE quest_template SET PrevQuestId = 0,StartScript = 13214,SpecialFlags=0,RequiredNpcOrGo1=31191,RequiredNpcOrGoCount1=1 WHERE id = 13214;
UPDATE quest_template SET PrevQuestId = 13214,StartScript = 13215,SpecialFlags=0,RequiredNpcOrGo1=31222,RequiredNpcOrGoCount1=1 WHERE id = 13215;
UPDATE quest_template SET PrevQuestId = 13215,StartScript = 13216,SpecialFlags=0,RequiredNpcOrGo1=31242,RequiredNpcOrGoCount1=1 WHERE id = 13216;
UPDATE quest_template SET PrevQuestId = 13216,StartScript = 13217,SpecialFlags=0,RequiredNpcOrGo1=31271,RequiredNpcOrGoCount1=1 WHERE id = 13217;
UPDATE quest_template SET PrevQuestId = 13217,StartScript = 13218,SpecialFlags=0,RequiredNpcOrGo1=31277,RequiredNpcOrGoCount1=1 WHERE id = 13218;
UPDATE quest_template SET PrevQuestId = 13218,StartScript = 13219,SpecialFlags=0,RequiredNpcOrGo1=14688,RequiredNpcOrGoCount1=1 WHERE id = 13219;

DELETE FROM quest_start_scripts WHERE id IN (13214,13215,13216,13217,13218,13219);
INSERT INTO quest_start_scripts SELECT 13214, 0, 10, entry, 720000, 0, 8246.787109, 3537.759521, 629.086853, 3.814590 FROM creature_template WHERE entry IN (31195,31193,31191,31192,31196,31194);
INSERT INTO quest_start_scripts VALUES (13215, 0, 10, 31222, 720000, 0, 8246.787109, 3537.759521, 629.086853, 3.814590);
INSERT INTO quest_start_scripts VALUES (13216, 0, 10, 31242, 720000, 0, 8246.787109, 3537.759521, 629.086853, 3.814590);
INSERT INTO quest_start_scripts VALUES (13217, 0, 10, 31271, 720000, 0, 8246.787109, 3537.759521, 629.086853, 3.814590);
INSERT INTO quest_start_scripts VALUES (13218, 0, 10, 31277, 720000, 0, 8246.787109, 3537.759521, 629.086853, 3.814590);
INSERT INTO quest_start_scripts VALUES (13219, 0, 10, 14688, 720000, 0, 8246.787109, 3537.759521, 629.086853, 3.814590);

-- Corrección de facciones, nivel, daño, en los npc del desafío:

UPDATE creature_template set faction_A=14,faction_H=14, unit_flags=0 where entry in (31191,31192,31193,31194,31195,31196,31222,31242,31271,31277,14688);

UPDATE creature_template SET minlevel=80,maxlevel=80,attackpower=250,mindmg=300,maxdmg=500 where entry=31242;
UPDATE creature_template SET minlevel=80,maxlevel=80,attackpower=252,mindmg=300,maxdmg=430 where entry=31271;
UPDATE creature_template SET minlevel=80,maxlevel=80,attackpower=250,mindmg=300,maxdmg=410 where entry=31277;

/* Abundante generosidad --> Corona del hielo */

UPDATE creature_template SET faction_A=14,faction_H=14,unit_flags=0 where entry=31075;
UPDATE creature SET spawntimesecs=60,phaseMask=135 where id=31075;

/* Emparejamientos --> Corona del Hielo */

UPDATE quest_template SET RequiredNpcOrGo1=30921 WHERE id=13147;

/* Conversando con las profundidades --> Cementerio de Dragones */

UPDATE quest_template SET RequiredNpcOrGo1=26648,SpecialFlags=0,EndText='',Flags=128, RequiredNpcOrGoCount1=1 where id=12032;
DELETE from creature where id=26648;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,26648,571,1,1,0,0,2471.398,1636.06,3.719,4.367,300,0,0,0,0,0,0,0,0);
UPDATE creature_template SET faction_A=7,faction_H=7,unit_flags=0,mindmg=50,maxdmg=70,scale=0.2,rank=0,attackpower=54,Health_mod=10 where entry=26648;

/* Sarathstra, Plaga del norte --> Cementerio de Dragones */

UPDATE creature SET position_x=4422.617,position_y=781.55,position_z=75.48,orientation=3.27,MovementType=0,spawndist=0 where id=26858;

/* Reparación de la cadena de misiones de Limpiar Drak'Tharon */

DELETE FROM creature WHERE id IN (26500,26543,26701,26787,28016);
INSERT INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (NULL, 26787, 571, 1, 1, 0, 0, 4599.53, -4876.94, 48.9552, 0.115355, 300, 0, 0, 6986, 0, 0, 0, 0, 0);
INSERT INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (NULL, 26701, 571, 1, 1, 0, 0, 4523.83, -3472.85, 228.393, 3.96302, 300, 0, 0, 6986, 0, 0, 0, 0, 0);
INSERT INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (NULL, 28016, 600, 3, 1, 0, 0, -236.704, -614.584, 117.973, 4.60795, 300, 0, 0, 6986, 0, 0, 0, 0, 0);
INSERT INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (NULL, 26543, 571, 1, 1, 0, 0, 4244, -2024.94, 238.249, 1.44268, 300, 0, 0, 6986, 0, 0, 0, 0, 0);
INSERT INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (NULL, 26500, 571, 1, 1, 0, 0, 3386.22, -1805.32, 115.058, 4.89765, 300, 0, 0, 42, 0, 0, 0, 0, 0);

UPDATE quest_template SET RequiredItemId1 = 0,RequiredItemCount1 = 0 WHERE id = 12007;

UPDATE creature_template SET npcflag = 2 WHERE entry IN (26543,26701,26787);

DELETE FROM creature_questrelation WHERE id = 26500;
INSERT INTO creature_questrelation VALUES (26500,12007);
DELETE FROM creature_involvedrelation WHERE id = 26500;
INSERT INTO creature_involvedrelation VALUES (26500,11991);

DELETE FROM creature_questrelation WHERE id = 26543;
INSERT INTO creature_questrelation VALUES (26543,12042);
DELETE FROM creature_involvedrelation WHERE id = 26543;
INSERT INTO creature_involvedrelation VALUES (26543,12007);

DELETE FROM creature_questrelation WHERE id = 26701;
INSERT INTO creature_questrelation VALUES (26701,12068);
DELETE FROM creature_involvedrelation WHERE id = 26701;
INSERT INTO creature_involvedrelation VALUES (26701,12802);

DELETE FROM creature_questrelation WHERE id = 26787;
INSERT INTO creature_questrelation VALUES (26787,12238);
DELETE FROM creature_involvedrelation WHERE id = 26787;
INSERT INTO creature_involvedrelation VALUES (26787,12068);

/* Las cámaras de Reflexión (horda y alianza) --> Quel´Delar */

DELETE from creature Where id = 37158;
INSERT INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (NULL, 37158, 668, 1, 1, 0, 0, 5279.44, 1975.32, 707.695, 4.00106, 300, 0, 0, 214200, 0, 0, 0, 0, 0);
UPDATE creature_template SET equipment_id=1726 WHERE entry=37158;
DELETE from creature_loot_template Where entry = 37158 AND item = 50254;
INSERT INTO creature_loot_template (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES (37158, 50254, -100, 1, 0, 1, 1);
UPDATE creature_template SET modelid1 = 30547,modelid2 = 0,mindmg = 420,maxdmg = 630,attackpower = 157, dmg_multiplier = 2,baseattacktime = 2000,equipment_id=1726,ScriptName='' WHERE entry IN (37745, 37158);

/* Venganza para los vargul --> Corona del Hielo */

UPDATE creature_template SET unit_flags=0 where entry=30475;
UPDATE quest_template SET RequiredNpcOrGo1=0, RequiredNpcOrGoCount1=0 where id=13059;

/* En las profundidades de las Cámaras Subterráneas--> Corona del Hielo */

UPDATE quest_template SET RequiredNpcOrGo1=0,RequiredNpcOrGoCount1=0 where id=13042;
UPDATE creature_template SET faction_A=14,faction_H=14,unit_flags=0 where entry=30409;

/* Segundas Oportunidades --> Corona del Hielo */

UPDATE creature_template SET faction_A=35,faction_H=35,unit_flags=131072 where entry=29560;
DELETE from creature Where id = 29560;
INSERT INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(NULL, 29560, 571, 1, 1, 0, 0, 7461.33, 4828.074, 54.158, 1.5857, 300, 0, 0, 63000, 0, 0, 0, 0, 0);

/* Neutralizar la peste --> Corona del Hielo */

UPDATE quest_template SET Flags=128, RequiredNpcOrGo1=31139,RequiredNpcOrGoCount1=1,RequiredSpellCast1=0,RequiredSourceItemId1=0,RequiredSourceItemCount1=0,RequiredSourceItemId2=0,RequiredSourceItemCount2=0 where id=13297;

/*¡A Vil gustar fuego! --> Corona del Hielo */

UPDATE quest_template SET Method=0 where id=13071;

/* Por donde vinieron --> Corona del Hielo */

UPDATE creature_template SET unit_flags=0 where entry=31131;

/* Encontrar al culpable --> Cumbres Tormentosas */

UPDATE quest_template SET SourceItemId=0,SourceItemCount=0,RequiredNpcOrGo1=0,RequiredNpcOrGoCount1=0 where id=12855;

/* Equilibrio de Luz y Sombras --> Tierras de la Peste Este */
UPDATE quest_template SET RequiredNpcOrGo1=14484,SpecialFlags=0,Flags=136, RequiredNpcOrGoCount1=15,EndText=null, Objectives='Mata a 15 Campesino malherido para completar la misión' where id=7622;
UPDATE creature_template SET faction_A=14,faction_H=14 where entry=14484;

DELETE FROM creature WHERE id=14484;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,14484,0,1,1,0,0,3356.25,-3030.040,162.0,5.256,300,0,0,0,0,0,0,0,0),
(NULL,14484,0,1,1,0,0,3368.1826,-3061.7866,166.20,1.439,300,0,0,0,0,0,0,0,0),
(NULL,14484,0,1,1,0,0,3368.658,-3049.97,165.56,1.5789,300,0,0,0,0,0,0,0,0),
(NULL,14484,0,1,1,0,0,3351.117,-3052.2187,165.55,2.088,300,0,0,0,0,0,0,0,0),
(NULL,14484,0,1,1,0,0,3355.154,-3042.40,163.859,2.058,300,0,0,0,0,0,0,0,0),
(NULL,14484,0,1,1,0,0,3343.818,-3043.559,163.185,1.767,300,0,0,0,0,0,0,0,0);

/* El mejor amigo de un no-muerto --> Corona del Hielo */

Update quest_template SET RequiredNpcOrGo1=30952,RequiredNpcOrGoCount1=18 where id=13169;

/* Una distracción necesaria (Arúspices) --> Valle de Sombraluna */

UPDATE quest_template SET RequiredSpellCast1=0,RequiredNpcOrGo1=0,RequiredSourceItemId2=0,RequiredItemId1=30811,RequiredItemCount1=1,RequiredSourceItemCount2=0,RequiredNpcOrGoCount1=0 WHERE id=10688;

/* Malentendidos afortunados --> Cuenca de Scholazar (Sólo hay que entregar la quest)*/

update quest_template SET Method=0 where id=12570;

/* El delicado sonido del trueno --> Fiordo Aquilonal */

UPDATE quest_template SET EndText=null, RequiredNpcOrGo1=24847,Flags=65664,RequiredNpcOrGoCount1=1 where id=11495;

/*Reliquias imbuidas de relámpagos --> Fiordo Aquilonal */

Update quest_template set RequiredNpcOrGo1=24271,RequiredNpcOrGo2=0,RequiredNpcOrGo3=0,RequiredNpcOrGo4=0,RequiredNpcOrGoCount1=15,RequiredNpcOrGoCount2=0,
RequiredNpcOrGoCount3=0,RequiredNpcOrGoCount4=0 where id=11494;

/* La Caverna Agonía de Escarcha --> Cementerio de Dragones */

DELETE FROM creature WHERE id=27879;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,27879,571,1,1,0,0,4819.10,-580.580,163.39,3.975,300,0,0,0,0,0,0,0,0);
UPDATE quest_template set RequiredNpcOrGo1=27879,SpecialFlags=0,RequiredNpcOrGoCount1=1,RequiredSourceItemId4=0,RequiredSourceItemCount4=0,RequiredSpellCast1=0 where Id=12478;
update creature_template set faction_A=14,faction_H=14 where entry=27879;

/* El almirante descubierto --> Corona del hielo */
UPDATE quest_template SET RequiredNpcOrGo1=29621,RequiredNpcOrGoCount1=1 WHERE id=12852;

/* LLamada cercana --> Zul´drak */
update quest_template set method=0 where Id=12638;

/* Sobre unas alas rubí --> Cementerio de Dragones */

DELETE from creature_loot_template where entry=28018 and item=38305;
insert into creature_loot_template (entry,item,ChanceOrQuestChance,lootmode,groupid,mincountOrRef,maxcount) values
(28018,38305,100,1,0,1,1);

/* Consigue la llave --> Corona del Hielo */
update creature_template set faction_A=14,faction_H=14,unit_flags=0 where entry=29915;
DELETE from creature_loot_template where entry=29915 and item=41843;
insert into creature_loot_template (entry,item,ChanceOrQuestChance,lootmode,groupid,mincountOrRef,maxcount) values
(29915,41843,100,1,0,1,1);


/*Entrega de cobardes... en menos de 30 minutos, o será gratis --> Tundra Boreal */

Update quest_template set Flags=65664 where id=11711;

/* Regalos de despedida --> Corona del Hielo */

UPDATE creature_template SET faction_A=14,faction_H=14,unit_flags=0,mechanic_immune_mask=0 where entry=30947;
Update quest_template SET RequiredNpcOrGo1=30947, EndText=null,SpecialFlags=0,RequiredNpcOrGoCount1=1 where id=13168;

/* Presagista de Sombraluna --> Valle de Sombraluna */

update creature_template SET faction_A=7,faction_H=7,unit_flags=0 where entry=21795;

/* Npc (Venerador de Skettis Tiempo Perdido,Atracador de Skettis Tiempo Perdido) --> Bosque de Terokkar*/

update creature_template SET faction_A=14,faction_H=14,unit_flags=0 where entry=21651;
update creature_template SET faction_A=14,faction_H=14,unit_flags=0 where entry=21763;

/* Perder la cabeza... por unos cardos --> Valle de Sombraluna */

UPDATE creature_template SET faction_A=14,faction_H=14,unit_flags=0 where entry=21409;

/*El cazador y el príncipe --> Corona del Hielo (No encuentro por ninguna parte ni la id ni el nombre del go) */

Update quest_template set method=0 where id=13400;

/* El caparazón de Norgannon --> Cumbres Tormentosas */

Update creature_template SET faction_A=14,faction_H=14,unit_flags=0 where entry=29775;
DELETE from creature_loot_template where entry=29775 and item=41258;
insert into creature_loot_template (entry,item,ChanceOrQuestChance,lootmode,groupid,mincountOrRef,maxcount) values
(29775,41258,-100,1,0,1,1);

/*Enfrentamiento --> Montañas Filospada*/

Update creature_template set faction_A=14, faction_H=14 where entry=20555;

/* Francamente, no tiene ningún sentido... --> Valle de Sombraluna */

UPDATE quest_template set RequiredNpcOrGo1=21462,RequiredNpcOrGoCount1=8 where Id=10672;

/* Caída en desgracia --> Cementerio de Dragones */

update quest_template SET SourceItemId=37381,SourceItemCount=1 where Id=12274;

/* La clave de la condenación --> Valle de Sombraluna */

update creature_template set faction_A=14, faction_H=14, unit_flags=0 where entry=21181;

/* Sangre Adversaria --> Bosque de Terokkar*/

UPDATE creature_template SET unit_flags=0, faction_A=14,faction_H=14 WHERE entry=23162;

/* La venganza del Rey de la Tormenta --> Zul´drak */

UPDATE quest_template set RequiredNpcOrGo1=0, RequiredNpcOrGoCount1=0 where id=12919;

DELETE FROM creature WHERE id=29872;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,29872,571,1,256,0,0,6174.85,-2051.2626,238.231,4.533,300,0,0,176550,0,0,0,0,0);

DELETE FROM creature WHERE id=29895;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,29895,571,1,256,0,0,5621.399,-2179.76,235.983,3.351,300,0,0,189000,0,0,0,0,0);

DELETE FROM creature WHERE id=29821;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,29821,571,1,256,0,0,5521.4790,-2193.6579,235.0668,5.07,300,0,0,88008,0,0,0,0,0);

UPDATE creature_template SET faction_A=14, faction_H=14, unit_flags=0 where entry in (29872,29895,29821);
UPDATE creature_template SET spell2=0 where entry=29884;

/* Que nadie se quede atrás --> Zul´drak */

update quest_template set method=0 where Id=12512;

/* Donde hay patrón... --> Zul´drak */

Update quest_template set RequiredItemId2=39159,RequiredItemCount2=7,RequiredNpcOrGo1=0,RequiredNpcOrGOCount1=0 WHERE Id=12673;
delete from creature_loot_template where entry=28750 and item=39159;
INSERT INTO creature_loot_template VALUES(28750,39159,100,1,0,1,3);

/* Tierras apestadas --> Costa Oscura */

update quest_template SET RequiredNpcOrGo1=2164,RequiredSpellCast1=0,RequiredNpcOrGOCount1=1 where id=2118;

/* Las observaciones de Senir --> Dun Morogh (La quest se autoaceptaba)*/

UPDATE quest_template set SpecialFlags=0, Flags=0 where Id=420;

/* ¡Gnomas Piedad! --> Montañas Filospada */
Delete from creature_loot_template where entry=21057 and item=30890;
INSERT INTO creature_loot_template VALUES(21057,30890,-100,1,0,1,1);

/* Vuelo de prueba: La Foresta de Ruuan --> Montañas Filospada */

Update quest_template set SourceItemId=0,SourceItemCount=0,Method=0,RequiredItemId1=0,EndText='',RequiredItemCount1=0 where id=10712;

/* No hay honor entre los pájaros --> Fiordo Aquilonal */
update item_template set spellid_1=0 where entry=34124;
update quest_template SET SourceItemId=34123,SourceItemCount=8,RequiredItemId2=0,RequiredItemCount2=0 where id=11470;

/* Libertad para todas las criaturas --> Feralas */

UPDATE quest_template set SpecialFlags=0, RequiredNpcOrGoCount1=6, RequiredNpcOrGO1=7997 where id=2969;
UPDATE creature_template SET faction_A=14, faction_H=14 where entry=7997;

/* El eco de Ymiron --> Fiordo Aquilonal (Autocompletable, falta código en C++ para realizar el enlace al evento) */

Update quest_template set Method=0 where id=11343;

/* La obligación de un padre --> Montañas Filospada (No reunes los requisitos necesarios para completar esta misión) y reparación */

Update quest_template set NextQuestId=11061,ExclusiveGroup=-11061 where Id=11030;
UPDATE quest_template SET SourceItemId=32601,SourceItemCount=1 where id=11061;

/* La X indica... ¡tu perdición! --> Zul´aman */

UPDATE creature_template SET unit_flags = 33554432, flags_extra = 0 WHERE entry = 23815;

/* Quest "¡Una vez más en la brecha, héroe!" (Añadida aclaración en el texto de la quest) --> Vanguardia Argenta */

UPDATE quest_template set Title='Once More Unto The Breach, Hero. IMPORTANTE: ANTES DE ENTREGAR ESTA QUEST completa las 3 quest que te proporciona el npc El Vigía de Ébano (El npc donde tienes que entregar esta quest), QUE SON : La pidera de la Plaga, La purga de la ciudad de la plaga y El aire permanece quieto. Una vez realizadas y entregadas esas 3 quest ya puedes entregar esta', Details='NO ENTREGUES LA QUEST HASTA QUE HAGAS LAS 3 QUEST QUE TE PROPONE El Vigía de Ébano, QUE SON : La pidera de la Plaga, La purga de la ciudad de la plaga y El aire permanece quieto. The Vanguard is secure, ally. We have reclaimed the Valley of Echoes and taken down the web walls blocking entry to the Breach. Now is the time to strike at Scourgeholme and establish our presence inside Icecrown. The battlefront moves on!$B$BI have asked the Ebon Watcher for his assistance with our assault upon Scourgeholme. His intimate knowledge of the Scourge will be invaluable in our effort.$B$BGo now and report to him at the tent outside of the Breach, northwest of here.' where id=13104;

/* El arma totem siniestro --> Marjal Revolcafango */

update quest_template SET RequiredNpcOrGo1=4344, RequiredNpcOrGoCount1=10 where id=11169;

/* Fervor de los Natoescarcha --> Cumbres Tormentosas */

DELETE FROM creature WHERE id=30142;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,30142,571,1,135,0,0,8426.599,-1965.83,1463.53,0.0837,300,0,0,100800,0,0,0,0,0);

/* Tecnología verde --> Corona del Hielo */

DELETE FROM creature WHERE id=32430;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,
spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,32430,571,1,135,0,0,7889.2255,2057.75,600.259,5.59,60,0,0,7988,0,0,0,0,0);

/* La ametralladora y tú: --> Cementerio de Dragones */
Update creature_template set faction_A=7,faction_H=7,unit_flags=0 where entry=27788;

/* Alzar la lanza de Hodir --> Cumbres Tormentosas */

Delete from gameobject where id=192187;
Insert into gameobject (guid,id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES
(NULL,192187,571,1,135,7320.32,-2040.82,761.35,0.023,0,0,0,1,300,100,1),
(NULL,192187,571,1,135,7309.98,-2055.67,761.33,3.19,0,0,0,1,300,100,1),
(NULL,192187,571,1,135,7325.9,-2054.77,761.408,5.00,0,0,0,1,300,100,1);

DELETE from creature WHERE id=30260;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,
spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,30260,571,1,135,0,0,7193.62,-2210.58,760.063,0.545,300,0,0,11770,0,0,0,0,0),
(NULL,30260,571,1,135,0,0,7103.54,-2144.83,758.68,1.79,300,0,0,11770,0,0,0,0,0),
(NULL,30260,571,1,135,0,0,7130.9,-2140.95,760.57,6.16,300,0,0,11770,0,0,0,0,0);

DELETE FROM creature_loot_template WHERE entry=30260 AND item=42542;
INSERT INTO creature_loot_template (entry,item,ChanceOrQuestChance,lootmode,groupid,mincountOrRef,maxcount) VALUES
(30260,42542,100,1,0,1,1);

/* Cazador de Espías --> Cumbres Tormentosas */

DELETE from creature WHERE id=30222;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,
spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,30222,571,1,135,0,0,7164.02,-2219.79,758.22,4.306,300,0,0,11770,0,0,0,0,0),
(NULL,30222,571,1,135,0,0,7156.87,-2236.73,758.45,4.54,300,0,0,11770,0,0,0,0,0),
(NULL,30222,571,1,135,0,0,7167.76,-2235.078,759.088,0.729,300,0,0,11770,0,0,0,0,0);

/* Busca a la diosa alada --> Zul´drak */

DELETE FROM creature WHERE id=28030;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,28030,571,1,2,0,0,5719.47,-4360.9,385.802,1.44292,300,0,0,13945,0,0,0,0,0);

/* El gigante de carne campeón --> Corona del Hielo */

DELETE from creature WHERE id=30698;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,
spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,30698,571,1,135,0,0,6823.69,3584.898,740.055,4.47,300,0,0,11770,0,0,0,0,0);

update creature_template set faction_A=14,faction_H=14,unit_flags=0 WHERE entry=30698;

/* Npc (Rastreador Val'zij) --> Cumbres Tormentosas */

DELETE FROM creature WHERE id=30469;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,30469,571,1,135,0,0,7619.647,-1608.135,969.346,0.907,300,0,0,13945,0,0,0,0,0);

/* Vuelo de prueba: el Cefirium Capacitorium --> Montañas Filospada */

Update quest_template set Method=0 where id=10557;

/* Un espíritu guía --> Península de Fuego Infernal */

update creature_template SET faction_A=35,faction_H=35 where entry=16845;

/* Oportunidad --> Corona del hielo (Añadido Npc Sargento Kregga) */

DELETE FROM creature WHERE id=31440;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,31440,571,1,135,0,0,5888.76,2005.38,513.43,2.548,300,0,0,12600,0,0,0,0,0);

/* Canción de Purificación --> Cuenca de Scholazar */

-- Añadir Espíritu de Atha:

DELETE FROM creature WHERE id=29033;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,29033,571,1,1,0,0,6164.18,5193.66,-125.27,2.115,300,0,0,12600,0,0,0,0,0),
(NULL,29033,571,1,1,0,0,6124.967,5176.968,-124.445,0.3623,300,0,0,12600,0,0,0,0,0);

-- Añadir Espíritu de Ha-Khalan

DELETE FROM creature WHERE id=29018;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,29018,571,1,1,0,0,5487.229,4756.659,-197.2365,5.125,300,0,0,12600,0,0,0,0,0);

-- Añadir Espíritu de Koosu

DELETE FROM creature WHERE id=29034;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,29034,571,1,1,0,0,5148.4956,4920.38,-135.38,3.997,300,0,0,12600,0,0,0,0,0);

/* Confalones y prácticas --> Nagrand */

DELETE FROM gameobject WHERE id=182263;
INSERT INTO gameobject (guid,id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES
(NULL, 182263, 530, 1, 1, -2532.99, 6306.90, 14.0280, 2.81871, 0, 0, 0.986996, 0.160743, 181, 100, 1),
(NULL, 182263, 530, 1, 1, -2474.44, 6111.16, 91.7629, 3.66388, 0, 0, 0.966096, -0.258184, 181, 100, 1),
(NULL, 182263, 530, 1, 1, -2533.21, 6168.56, 59.9387, 3.75028, 0, 0, 0.954044, -0.299666, 181, 100, 1);

/* Todas las atalayas --> Tierras de la Peste Oeste */

DELETE FROM gameobject WHERE id=300030;
INSERT INTO gameobject (guid, id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(NULL, 300030, 0, 1, 1, 1308.24, -1303.41, 64.3047, 4.15194, 0, 0, 0.875091, -0.483959, 300, 0, 1),
(NULL, 300030, 0, 1, 1, 1467.8, -1409.18, 67.7638, 5.60571, 0, 0, 0.332297, -0.943175, 300, 0, 1),
(NULL, 300030, 0, 1, 1, 1560.28, -1485.03, 68.3929, 1.36456, 0, 0, 0.630563, 0.776138, 300, 0, 1),
(NULL, 300030, 0, 1, 1, 1327.56, -1581.53, 61.7238, 3.42781, 0, 0, 0.989778, -0.14262, 300, 0, 1);

/* Vuelo de prueba: La Cresta Canto --> Montañas Filospada */

Update quest_template set Method=0 where id=10710;

/* ¡Largo de aquí! --> Montañas Filospada (añadir npc=19963) */

DELETE FROM creature WHERE id=19963;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,19963,530,1,1,0,0,2935.348,4841.16,279.15,1.864,300,0,0,10466,0,0,0,0,0);

/* Verog el derviche --> Los Baldíos (Añadir npc) */

DELETE FROM creature WHERE id=3395;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,3395,1,1,1,0,0,-1207.568,-2743.338,102.52,4.58,300,0,0,417,0,0,0,0,0);

/* La caza de ectoplasmas --> Desolace */

DELETE FROM creature WHERE id=11560;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,11560,1,1,1,0,0,-2310.23,1358.24,63.742,6.769,300,0,0,1220,0,0,0,0,0),
(NULL,11560,1,1,1,0,0,-2288.72,1338.2088,63.625,5.88,300,0,0,1220,0,0,0,0,0),
(NULL,11560,1,1,1,0,0,-2292.159,1323.17,64.144,2.548,300,0,0,1220,0,0,0,0,0),
(NULL,11560,1,1,1,0,0,-2316.552,1349.732,63.589,2.27,300,0,0,1220,0,0,0,0,0);
Delete from creature_loot_template where entry=11560 and item=15849;
Insert into creature_loot_template (entry,item,ChanceOrQuestChance,lootmode,groupid,mincountOrRef,maxcount) values
(11560,15849,-100,1,0,1,1);

/* Química básica --> Corona del Hielo */

Update quest_template set method=0 where id in (13279,13295);

/* Corazón oscuro --> Feralas */

DELETE FROM creature WHERE id=8075;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,8075,1,1,1,0,0,-2759.88,2618.375,68.66,2.10,300,0,0,0,0,0,0,0,0);

/* El oro de Cuergo --> Tanaris */

DELETE FROM creature WHERE id in (7899,7902,7901);
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,7899,1,1,1,0,0,-10246.655,-3967.8476,1.3636,0.38,300,0,0,0,0,0,0,0,0),
(NULL,7902,1,1,1,0,0,-10210.90,-3964.81,2.677,3.466,300,0,0,0,0,0,0,0,0),
(NULL,7901,1,1,1,0,0,-10227.07,-4005.958,3.0496,0.3419,300,0,0,0,0,0,0,0,0);

/* La fiebre de tuercespina --> Vega de Tuercespina */

DELETE FROM creature WHERE id=1514;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,1514,0,1,1,0,0,-13730.99,-33.8186,45.92,2.51,300,0,0,0,0,0,0,0,0);

/* Npc (Suplicante Aguja del Filo) --> Montañas Filospada */

DELETE FROM creature WHERE id=23053;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,23053,530,1,1,0,0,2765.987793,5807.949707,-3.372080,2.100464,300,0,0,0,0,0,0,0,0);

/* Espectróculos --> Valle de Sombraluna */

Update creature_template SET faction_A=7,faction_H=7, unit_flags=0 where entry=21788;

/* Visión guía --> Montañas Filospada */

update quest_template SET SpecialFlags=0 where id=10525;

/* Forjar una cabeza --> Cumbres Tormentosas */

Delete from creature_loot_template where item=42423 and entry=29375;
Insert into creature_loot_template (entry,item,ChanceOrQuestChance,lootmode,groupid,mincountOrRef,maxcount) VALUES
(29375,42423,-90,1,0,1,2);

/* Caza de dracos --> Tundra Boreal */

Delete from creature where id=26127;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(121041,26127,571,1,1,0,0,3943.337,7164.4897,170.45,6.18,300,0,0,0,0,0,0,0,0);
UPDATE creature_template SET faction_A=14,faction_H=14,unit_flags=4,scale=3, MovementType=0 where entry=26127;
UPDATE quest_template SET SpecialFlags=0, SourceItemId=0, SourceItemCount=0, RequiredNpcOrGo1=26127, RequiredNpcOrGoCount1=1 where id=11919;
UPDATE quest_template SET SpecialFlags=1, SourceItemId=0, SourceItemCount=0, RequiredNpcOrGo1=26127, RequiredNpcOrGoCount1=1 where id=11940;
Delete from creature_addon where guid in (121042,121043,121044,121045,121046,121047);

/* Vuelo de prueba: Zona de Aterrizaje Razaan --> Montañas Filospada */

Update quest_template set Method=0 where id=10711;

/* Avasalla al Avasallador --> Valle de Sombraluna */

UPDATE quest_template SET SpecialFlags=2, EndText='', RequiredNpcOrGO1=22357, RequiredNpcOrGOCount1=1,SourceItemId=0,SourceItemCount=0,Flags=65664,RequiredItemCount4=0,RequiredItemId4=0 where id=11090;

/* La bendición de Zim'Rhuk --> Zul´drak */

UPDATE quest_template SET Flags=128, Method=2 where id=12656;
UPDATE gameobject_template SET faction=35,data1=9021,data2=40,size=3 where entry=190657;

/* Los Líderes de Jin'Alai --> Zul´drak */

DELETE FROM creature WHERE id=28495;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,28495,571,1,1,0,0,5613.0698,-3479.28,350.41,1.3788,300,0,0,0,0,0,0,0,0);

DELETE FROM creature WHERE id=28496;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,28496,571,1,1,0,0,5515.757,-3419.68,350.327,5.59,300,0,0,0,0,0,0,0,0);

/* Clemente libertad --> Tundra Boreal */

UPDATE creature_template SET faction_A=14,faction_H=14,unit_flags=0,rank=0 where entry=25610;
UPDATE creature SET spawntimesecs=300 where id=25610;
UPDATE quest_template SET RequiredSourceItemCount4=0, RequiredSourceItemId4=0 where id=11676;

/* La bendición de Zim'Torga --> Zul´drak */

UPDATE quest_template SET Method=2,Flags=128,SpecialFlags=0 where id=12618;

/* La trampa más mortal jamás tendida --> Valle de Sombraluna */

Update creature_model_info SET modelid_other_gender=21505 where modelid=21505;
Update quest_template SET Specialflags=3,EndText='',Flags=65664, SourceItemId=0, SourceItemCount=0, RequireditemId1=0,RequiredItemCount1=0 WHERE id=11097;

/* Krolmir, el Martillo de las Tormentas --> Cumbres Tormentosas */

update quest_template set method=0 where id=13010;

/* Reinar los Cielos --> Montañas Filospada */

DELETE FROM creature WHERE id=23261;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,23261,530,1,1,0,0,2069.343,7379.1367,371.60,4.227,300,0,0,184000,0,0,0,0,0);

/* Mantener la velocidad y Los esquemas de Rizzle --> Las Mil Agujas */

Delete from gameobject_involvedrelation where quest=1190;
DELETE from creature_involvedrelation where quest=1190;
Insert into creature_involvedrelation (id,quest) VALUES (4720,1190);
UPDATE creature_template SET npcflag=2 where entry=4720;

DELETE from gameobject_questrelation where quest=1194;
Delete from creature_questrelation where quest=1194;
INSERT into creature_questrelation (id, quest) VALUES (4720,1194);

/* Guardianes del altar --> Cuna del Invierno */

UPDATE quest_template SET SpecialFlags=0 where id=4901;

/* Thalorien Buscalba (Horda y Ali) --> Quest Quel´Delar */

DELETE from creature Where id = 37527;
INSERT INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (NULL, 37527, 530, 1, 1, 0, 0, 12560.58, -6779.339, 15.075, 0.2157,300, 0, 0, 558900, 0, 0, 0, 0,0);

DELETE from creature Where id = 37552;
INSERT INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (NULL, 37552, 530, 1, 1, 0, 0, 11786, -7063.38, 25.7397, 0.0255288, 300, 0, 0, 123, 180, 0, 0, 0, 0);

UPDATE creature_template SET gossip_menu_id = 37552, npcflag = 1, AIName = "SmartAI" Where entry = 37552;

DELETE from gossip_menu Where entry = 37552;
DELETE from npc_text Where id = 15155;

INSERT INTO gossip_menu VALUES (37552,15155);
INSERT INTO npc_text (ID,text0_0) VALUES (15155,"These appear to be the remains of Thalorien Dawnseeker, the last wielder of Quel'Delar.");

DELETE from gossip_menu_option Where menu_id = 37552;
INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, box_coded, box_money, box_text) VALUES (37552, 0, 0, 'Examine the remains.', 1, 1, 0, 0, 0, 0, NULL);

DELETE from smart_scripts Where entryorguid = 37552;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES (37552, 0, 0, 0, 62, 0, 100, 0, 37552, 0, 0, 0, 33, 37601, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'q24535,24563');

/* El Círculo de Sangre: el desafío final --> Nagrand */

UPDATE quest_template SET SpecialFlags=0, Flags=128,RequiredNpcOrGo1=18069,RequiredNpcOrGoCount1=1 where id=9977;

/* La purificación de Quel'Delar --> Añadidos gobjects en el suelo con respawn de 30 seg. */

Delete from gameobject where id=201794;
Insert into gameobject (guid,id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES
(NULL,201794,580,3,3,1730.465942,590.482117,28.050457,2.192947,0,0,0,1,30,100,1),
(NULL,201794,580,3,3,1727.939331,610.001,28.05,4.443,0,0,0,1,30,100,1),
(NULL,201794,580,3,3,1727.339,610.001,28.050,4.443898,0,0,0,1,30,100,1),
(NULL,201794,580,3,3,1727.939,610.001,28.050,4.443,0,0,0,1,30,100,1);

/* Añadida aclaración si la quest da 'Mazas' o 'Espadas' para la quest 'Una victoria para El Pacto de Plata' */

UPDATE quest_template SET Title= '[Espadas:]Una victoria para El Pacto de Plata' where id=24796;
UPDATE quest_template SET Title= '[Mazas:] Una victoria para El Pacto de Plata' where id=24795;

#####
#Npc#
#####

/* Clamarelámpagos Soo-notone --> Cuenca de Scholazar */

DELETE FROM creature WHERE id=28107;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,28107,571,1,1,0,0,5114.395,5472.35,-91.8385,1.4976,300,0,0,117700,0,0,0,0,0);

/* Kibli Kilohercio --> Corona del Hielo */

DELETE from creature Where id = 32444;
INSERT INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(NULL, 32444, 571, 1, 135, 0, 0, 7689.553, 2042.042, 500.24386, 1.059, 300, 0, 0, 12600, 0, 0, 0, 0, 0);

/* Brann Barbabronce --> Cumbres Tormentosas */

DELETE from creature Where id = 29579;
INSERT INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(NULL, 29579, 571, 1, 1, 0, 0, 7609.179, -1128.448, 909.64, 4.62, 300, 0, 0, 252, 0, 0, 0, 0, 0);

/* Añadir a Nocturno y ponerlo atacable */

Update creature set position_x=-11158.94,position_y=-1948.92,position_z=91.473,orientation=2.125 where id=17225;
UPDATE creature_template set unit_flags=0 where entry=17225;

/* Npc (Oráculo Pavesa y Cazador Corazón Frenético) */

update creature_template set faction_A=14,faction_H=14, unit_flags=0 where entry=28079;
update creature_template set faction_A=14,faction_H=14, unit_flags=0 where entry=28112;

/* Aleric Hawkins --> Entrañas */

DELETE FROM creature WHERE id=36517;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,36517,0,1,1,0,0,1279.05,335.563,-60.0831,4.34216,300,0,0,18900,0,0,0,0,0);

/* Añade al Npc Kurzel en Drak´taron para la quest 12037 */

DELETE FROM creature WHERE id=26664;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,26664,600,1,1,0,0,-274.1969,-740.713,27.375,1.3788,300,0,0,6986,0,0,0,0,0);



######
#Npc#
#####

/* Brutito Argenta y Escudero Argenta; añadidas las opciones de "Buzón", "Vendedor" y "Banco", así como los items que vende */

UPDATE creature_template SET npcflag = 135297, gossip_menu_id = 50000 WHERE entry = 33238;
UPDATE creature_template SET npcflag = 135297, gossip_menu_id = 50001 WHERE entry = 33239;

DELETE FROM gossip_menu WHERE entry IN (50000, 50001);
INSERT INTO gossip_menu VALUES
(50000, 14324),
(50001, 14372);

DELETE FROM spell_linked_spell WHERE spell_effect = 67401;
INSERT INTO spell_linked_spell VALUES
(-67368, 67401, 0, 'Escudero Argenta-Banco'),
(-67377, 67401, 0, 'Escudero Argenta-Vendedor');

DELETE FROM npc_vendor WHERE entry IN (33238, 33239);
INSERT INTO npc_vendor VALUES
-- Escudero Argenta
(33238,0, 3775, 0, 0, 0),
(33238,0, 5237, 0, 0, 0),
(33238,0,5565, 0, 0, 0),
(33238,0, 16583, 0, 0, 0),
(33238,0, 17020, 0, 0, 0),
(33238,0, 17030, 0, 0, 0),
(33238,0, 17031, 0, 0, 0),
(33238,0, 17032, 0, 0, 0),
(33238,0, 17033, 0, 0, 0),
(33238,0, 21177, 0, 0, 0),
(33238,0, 37201, 0, 0, 0),
(33238,0, 41584, 0, 0, 0),
(33238,0, 41586, 0, 0, 0),
(33238,0, 43231, 0, 0, 0),
(33238,0, 43233, 0, 0, 0),
(33238,0, 43235, 0, 0, 0),
(33238,0, 43237, 0, 0, 0),
(33238,0, 44605, 0, 0, 0),
(33238,0, 44614, 0, 0, 0),
(33238,0, 44615, 0, 0, 0),

(33238,0, 33449, 0, 0, 0),
(33238,0, 33451, 0, 0, 0),
(33238,0, 33454, 0, 0, 0),
(33238,0, 33443, 0, 0, 0),
(33238,0, 35949, 0, 0, 0),
(33238,0, 35952, 0, 0, 0),
(33238,0, 35953, 0, 0, 0),
(33238,0, 35951, 0, 0, 0),
(33238,0, 35948, 0, 0, 0),
(33238,0, 35950, 0, 0, 0),

-- Brutito Argenta

(33239,0, 3775, 0, 0, 0),
(33239,0, 5237, 0, 0, 0),
(33239,0, 5565, 0, 0, 0),
(33239,0, 16583, 0, 0, 0),
(33239,0, 17020, 0, 0, 0),
(33239,0, 17030, 0, 0, 0),
(33239,0, 17031, 0, 0, 0),
(33239,0, 17032, 0, 0, 0),
(33239,0, 17033, 0, 0, 0),
(33239,0, 21177, 0, 0, 0),
(33239,0, 37201, 0, 0, 0),
(33239,0, 41584, 0, 0, 0),
(33239,0, 41586, 0, 0, 0),
(33239,0, 43231, 0, 0, 0),
(33239,0, 43233, 0, 0, 0),
(33239,0, 43235, 0, 0, 0),
(33239,0, 43237, 0, 0, 0),
(33239,0, 44605, 0, 0, 0),
(33239,0, 44614, 0, 0, 0),
(33239,0, 44615, 0, 0, 0),

(33239,0, 33449, 0, 0, 0),
(33239,0, 33451, 0, 0, 0),
(33239,0, 33454, 0, 0, 0),
(33239,0, 33443, 0, 0, 0),
(33239,0, 35949, 0, 0, 0),
(33239,0, 35952, 0, 0, 0),
(33239,0, 35953, 0, 0, 0),
(33239,0, 35951, 0, 0, 0),
(33239,0, 35948, 0, 0, 0),
(33239,0, 35950, 0, 0, 0);

/* Lady Jaina --> Cámaras de Reflexión */

DELETE FROM creature WHERE id=37221;
INSERT INTO creature (guid,id,map,spawnMask,phaseMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,dynamicflags) VALUES
(NULL,37221,668,3,1,0,0,5236.112305,1943.381104,707.695129,0.064955,300,0,0,5040000,0,0,0,0,0);

#############
#Gameobjects#
#############

/* Cofre de hierro vil reforzado (Instance Murallas fuego infernal hero) */

UPDATE gameobject_template SET flags=0 WHERE entry=185169;

/* Alimentar a Arngrim (añadir gobject)--> Cumbres Tormentosas */

Delete from gameobject where id=192524;
Insert into gameobject (guid,id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES
(NULL,192524,571,1,135,7330.6127,-2905.97,823.372,1.6798,0,0,0,1,300,100,1);

/* Los tubérculos hojazul --> Horado Rajacieno */

UPDATE gameobject_template SET faction=35,flags=0,data8=1221 where entry=20920;

Delete from gameobject where id=20920;
Insert into gameobject (guid,id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES
(NULL,20920,47,1,1,2055.96,1584.0399,64.01,1.4289,0,0,0,1,300,100,1),
(NULL,20920,47,1,1,2060.98,1610.01,62.36,1.4289,0,0,0,1,300,100,1),
(NULL,20920,47,1,1,2020.589,1550.27,80.897,0.10,0,0,0,1,300,100,1),
(NULL,20920,47,1,1,2044.0869,1544.06,76.414,0.32,0,0,0,1,300,100,1),
(NULL,20920,47,1,1,2064.43,1575.268,65.858,1.25,0,0,0,1,300,100,1),
(NULL,20920,47,1,1,2064.325,1625.53,64.427,4.593,0,0,0,1,300,100,1);

/* Barras de saronita imbuida (Foso de Saron) --> Añadidos 3 spawn en la entrada de la instance */

Insert into gameobject (guid,id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES
(NULL,201592,658,3,3,461.301,191.5866,528.709,1.07,0,0,0,1,30,100,1),
(NULL,201592,658,3,3,448.607,179.433,528.707,1.495,0,0,0,1,30,100,1),
(NULL,201592,658,3,3,460.522,238.24,528.708,1.322,0,0,0,1,30,100,1);

#######
#Items#
#######

/* Huevo Misterioso y Tarro desagradable (Posible fix para que en vez de contar tiempo de JUEGO, cuente tiempo REAL)*/

UPDATE item_template SET flagsCustom=0x0001 WHERE entry=39878;
UPDATE item_template SET flagsCustom=0x0001 WHERE entry=44717;

########
#Logros#
########

/* ¿Amigo o Enemigo? */

REPLACE INTO creature_template (entry, difficulty_entry_1, difficulty_entry_2, difficulty_entry_3, KillCredit1, KillCredit2, modelid1, modelid2, modelid3, modelid4, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, exp, faction_A, faction_H, npcflag, speed_walk, speed_run, scale, rank, mindmg, maxdmg, dmgschool, attackpower, dmg_multiplier, baseattacktime, rangeattacktime, unit_class, unit_flags, dynamicflags, family, trainer_type, trainer_spell, trainer_class, trainer_race, minrangedmg, maxrangedmg, rangedattackpower, type, type_flags, lootid, pickpocketloot, skinloot, resistance1, resistance2, resistance3, resistance4, resistance5, resistance6, spell1, spell2, spell3, spell4, spell5, spell6, spell7, spell8, PetSpellDataId, VehicleId, mingold, maxgold, AIName, MovementType, InhabitType, Health_mod, Mana_mod, Armor_mod, RacialLeader, questItem1, questItem2, questItem3, questItem4, questItem5, questItem6, movementId, RegenHealth, equipment_id, mechanic_immune_mask, flags_extra, ScriptName, WDBVerified) VALUES (110001, 0, 0, 0, 0, 0, 21774, 0, 0, 0, 'Pavorotti Pavorosso', NULL, NULL, 0, 80, 80, 0, 35, 35, 2, 1, 1.14286, 4, 3, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, '', 1);

DELETE FROM creature WHERE id=110001;
REPLACE INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType) VALUES (null, 110001, 571, 1, 1, 0, 0, 182.783, -5526.1, 369.229, 6.28095, 25, 0, 0, 500000, 0, 0);

REPLACE INTO quest_template (Id, Method, Level, MinLevel, MaxLevel, ZoneOrSort, Type, SuggestedPlayers, LimitTime, RequiredClasses, RequiredRaces, RequiredSkillId, RequiredSkillPoints, RequiredFactionId1, RequiredFactionId2, RequiredFactionValue1, RequiredFactionValue2, RequiredMinRepFaction, RequiredMaxRepFaction, RequiredMinRepValue, RequiredMaxRepValue, PrevQuestId, NextQuestId, ExclusiveGroup, NextQuestIdChain, RewardXPId, RewardOrRequiredMoney, RewardMoneyMaxLevel, RewardSpell, RewardSpellCast, RewardHonor, RewardHonorMultiplier, RewardMailTemplateId, RewardMailDelay, SourceItemId, SourceItemCount, SourceSpellId, Flags, SpecialFlags, RewardTitleId, RequiredPlayerKills, RewardTalents, RewardArenaPoints, RewardItemId1, RewardItemId2, RewardItemId3, RewardItemId4, RewardItemCount1, RewardItemCount2, RewardItemCount3, RewardItemCount4, RewardChoiceItemId1, RewardChoiceItemId2, RewardChoiceItemId3, RewardChoiceItemId4, RewardChoiceItemId5, RewardChoiceItemId6, RewardChoiceItemCount1, RewardChoiceItemCount2, RewardChoiceItemCount3, RewardChoiceItemCount4, RewardChoiceItemCount5, RewardChoiceItemCount6, RewardFactionId1, RewardFactionId2, RewardFactionId3, RewardFactionId4, RewardFactionId5, RewardFactionValueId1, RewardFactionValueId2, RewardFactionValueId3, RewardFactionValueId4, RewardFactionValueId5, RewardFactionValueIdOverride1, RewardFactionValueIdOverride2, RewardFactionValueIdOverride3, RewardFactionValueIdOverride4, RewardFactionValueIdOverride5, PointMapId, PointX, PointY, PointOption, Title, Objectives, Details, EndText, OfferRewardText, RequestItemsText, CompletedText, RequiredNpcOrGo1, RequiredNpcOrGo2, RequiredNpcOrGo3, RequiredNpcOrGo4, RequiredNpcOrGoCount1, RequiredNpcOrGoCount2, RequiredNpcOrGoCount3, RequiredNpcOrGoCount4, RequiredSourceItemId1, RequiredSourceItemId2, RequiredSourceItemId3, RequiredSourceItemId4, RequiredSourceItemCount1, RequiredSourceItemCount2, RequiredSourceItemCount3, RequiredSourceItemCount4, RequiredItemId1, RequiredItemId2, RequiredItemId3, RequiredItemId4, RequiredItemId5, RequiredItemId6, RequiredItemCount1, RequiredItemCount2, RequiredItemCount3, RequiredItemCount4, RequiredItemCount5, RequiredItemCount6, RequiredSpellCast1, RequiredSpellCast2, RequiredSpellCast3, RequiredSpellCast4, Unknown0, ObjectiveText1, ObjectiveText2, ObjectiveText3, ObjectiveText4, DetailsEmote1, DetailsEmote2, DetailsEmote3, DetailsEmote4, DetailsEmoteDelay1, DetailsEmoteDelay2, DetailsEmoteDelay3, DetailsEmoteDelay4, EmoteOnIncomplete, EmoteOnComplete, OfferRewardEmote1, OfferRewardEmote2, OfferRewardEmote3, OfferRewardEmote4, OfferRewardEmoteDelay1, OfferRewardEmoteDelay2, OfferRewardEmoteDelay3, OfferRewardEmoteDelay4, StartScript, CompleteScript, WDBVerified) VALUES (110000, 2, 1, 68, 85, 495, 0, 0, 180, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25285, 0, 0, 0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kentucky Fried Pavo', 'Escarmienta a 15 Pavos del Fiordo en menos de 3 minutos', 'Yo, el Rey de los Pavos, te he elegido a ti $N para que les des un escarmiento a mis subordinados, los cuales se estan rebelando contra mi ¡Esto es intolerable! $B$B¡Hazles saber que mi supremacia es indiscutible y te recompensare con creces! Eso si, tendrás que ser rapido\'', '', '¡NOOOOOO! ¡Mis leales subditos, todos muertos! Te dije que los escarmentaras, no que los mataras...$B$B¡Mi venganza será terrible!', '¡Aun estás aqui!?', 'Habla con Pavarotti Pavorosso e informale de tu exito', 24746, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);

REPLACE INTO creature_involvedrelation (id, quest) VALUES (110001, 110000);
REPLACE INTO creature_questrelation (id, quest) VALUES (110001, 110000);

/* Defensor Supremo (Garganta grito de guerra */

DELETE FROM achievement_criteria_data WHERE criteria_id IN (3698, 3699);
INSERT INTO achievement_criteria_data VALUES
(3698,6,3277,0,''),
(3698,7,23335,0,''),
(3699,6,3277,0,''),
(3699,7,23333,0,'');

/* Defensa Rápida (Reducidos los objetivos, debido a que la montura no funciona, y añadido el logro)*/

UPDATE quest_template SET Method=2, RequiredNpcOrGo3=0,RequiredNpcOrGoCount2=3,RequiredNpcOrGoCount1=1, RequiredNpcOrGoCount3=0 where id=12372;
DELETE FROM disables WHERE sourceType=4 AND entry=3924;

/* Hadronox Rechazado --> Azjol-Nerub */

Delete from disables where sourceType=4 and entry=4244;

###########
#Instances#
###########

-- Ojo de la Eternidad:

/* Inmunidades de Malygos (10 y 25) */

UPDATE creature_template SET mechanic_immune_mask=1|2|4|8|16|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|8388608|67108864|536870912 WHERE entry IN (26310,31734);

/* Modifica la velocidad de movimiento de las chispas de Malygos (10 y 25) */

UPDATE creature_template SET speed_walk=0.3, speed_run=0.3 WHERE entry IN (30084,32187);

-- Prueba del cruzado:

/* Inmunidades de los jefes */

UPDATE creature_template SET mechanic_immune_mask=1|2|4|8|16|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|8388608|67108864|536870912 WHERE entry IN
(34796, 35438, 35439, 35440, -- Gormok el Empalador
35144,35512,35513,35511, -- Fauceácida
34799,35515,35516,35514, -- Aterraescama
35447,35449,35448,34797, -- Aullahielo
34780,35268,35269,35216, -- Lord Jaraxxus
34497,35351,35352,35350, -- Fjola Penívea
34496,35348,35349,35347, -- Eydis Penaumbra
35616,35615,34566,34564); -- Anub'arak

/* Corrección de daño de las Val´kyr (10 y 25) [Tomando como referencia el daño del antiguo emulador] */

UPDATE creature_template SET mindmg=496,maxdmg=674,attackpower=783,dmg_multiplier=35 where entry in (34497,34496,35351,35348,35352,35349);
UPDATE creature_template SET mindmg=496,maxdmg=674,attackpower=783,dmg_multiplier=50 where entry in (35350,35347);

########
#Spells#
########

/* Cuidador de Animales (Talento)--> Cazador */

DELETE FROM spell_pet_auras WHERE aura = 68361;
INSERT INTO spell_pet_auras VALUES
(34453,1,0,68361),
(34454,1,0,68361);

/* Rey de la Selva --> Druida */

DELETE FROM spell_proc_event WHERE entry IN (48492,48494,48495);
INSERT INTO spell_proc_event VALUES (48492, 0, 7, 524288, 0, 2048, 1024, 0, 0, 0, 0);
INSERT INTO spell_proc_event VALUES (48494, 0, 7, 524288, 0, 2048, 1024, 0, 0, 0, 0);
INSERT INTO spell_proc_event VALUES (48495, 0, 7, 524288, 0, 2048, 1024, 0, 0, 0, 0);

/* Bonus 4 partes T10 Pícaro */

DELETE FROM spell_proc_event WHERE entry = 70803;
INSERT INTO spell_proc_event VALUES(70803, 0, 8, 3801088, 8, 0, 87376, 0, 0, 13, 0);

/* Exploit - Cuando usas Mano de protección, si el pj tiene filotormenta, no se le quita */

DELETE FROM spell_linked_spell WHERE spell_effect=-46924 or spell_trigger=46924;
INSERT INTO spell_linked_spell (spell_trigger, spell_effect, type, comment) VALUES
(1022, -46924, 1, 'Hand of protection (Rank1) - remove bladestorm'),
(5599, -46924, 1, 'Hand of protection (Rank2) - remove bladestorm'),
(10278, -46924, 1, 'Hand of protection (Rank3) - remove bladestorm'),
(46924, -55741, 2, 'Bladestorm - Immunity to Desecration (Rank 1)'),
(46924, -68766, 2, 'Bladestorm - Immunity to Desecration (Rank 2)'),
(46924, -13810, 2, 'Bladestorm - Immunity to Frost Trap');

-- Eliminado el Requisito de "Oficial Jinete" para la spell 23161 "Corcel Nefasto"
DELETE from spell_required where spell_id=23161;
INSERT INTO spell_required (spell_id, req_spell) VALUES (23161,0);

-- Eliminado el Requisito de "Oficial Jinete" para la spell 23214 "Destrero de la Alianza"
DELETE from spell_required where spell_id =23214;
INSERT INTO spell_required (spell_id, req_spell) VALUES (23214,0);

-- Eliminado el Requisito de "Oficial Jinete" para la spell 34767 "Destrero de la Horda"
DELETE from spell_required where spell_id =34767;
INSERT INTO spell_required (spell_id, req_spell) VALUES (34767,0);

########
#Arenas#
########

/* Desactivación de las monturas de 2/3 plazas en Arenas, para evitar que no se les pueda pegar a la gente que va montada en el mamut/moto */

-- Desactiva Chopper de Mekkingeniero en Arena Filospada, Ruinas Lordaeron y Arena de Nagrand
DELETE FROM disables WHERE entry = 60424;
INSERT INTO disables (sourceType, entry, flags, params_0, params_1, comment) VALUES (0, 60424, 17, '562,572,559', '', 'Desactiva Chopper Mekkingeniero en Arena Filospada, Ruinas Lordaeron y Arena de Nagrand');

-- Desactiva Meca-jarly en Arenas Filospada, Ruinas Lordaeron y Arena de Nagrand

DELETE FROM disables WHERE entry = 55531;
INSERT INTO disables (sourceType, entry, flags, params_0, params_1, comment) VALUES (0, 55531, 17, '562,572,559', '', 'Desactiva Meca-jarly en Arena Filospada, Ruinas Lordaeron y Arena de Nagrand');

-- Desactiva Mamut Tundra de Viajero (horda) en Arena Filospada, Ruinas Lordaeron y Arena de Nagrand

DELETE FROM disables WHERE entry = 61447;
INSERT INTO disables (sourceType, entry, flags, params_0, params_1, comment) VALUES (0, 61447, 17, '562,572,559', '', 'Desactiva Mamut Tundra de Viajero Horda en Arena Filospada, Ruinas Lordaeron y Arena de Nagrand');

-- Desactiva Mamut Tundra de Viajero (alianza) en Arena Filospada, Ruinas Lordaeron y Arena de Nagrand

DELETE FROM disables WHERE entry = 61425;
INSERT INTO disables (sourceType, entry, flags, params_0, params_1, comment) VALUES (0, 61425, 17, '562,572,559', '', 'Desactiva Mamut Tundra de Viajero Alianza en Arena Filospada, Ruinas Lordaeron y Arena de Nagrand');

-- Desactiva Gran mamut de Hielo (alianza) en Arenas Filospada, Ruinas Lordaeron y Arena de Nagrand

DELETE FROM disables WHERE entry = 61470;
INSERT INTO disables (sourceType, entry, flags, params_0, params_1, comment) VALUES (0, 61470, 17, '562,572,559', '', 'Desactiva Gran Mamut de Hielo Alianza en Arena Filospada, Ruinas Lordaeron y Arena de Nagrand');

-- Desactiva Gran mamut de Hielo (horda) en Arenas Filospada, Ruinas Lordaeron y Arena de Nagrand

DELETE FROM disables WHERE entry = 61469;
INSERT INTO disables (sourceType, entry, flags, params_0, params_1, comment) VALUES (0, 61469, 17, '562,572,559', '', 'Desactiva Gran Mamut de Hielo Horda en Arena Filospada, Ruinas Lordaeron y Arena de Nagrand');

-- Desactiva Riendas del gran mamut de guerra negro (alianza) en Arenas Filospada, Ruinas Lordaeron y Arena de Nagrand

DELETE FROM disables WHERE entry = 61465;
INSERT INTO disables (sourceType, entry, flags, params_0, params_1, comment) VALUES (0, 61465, 17, '562,572,559', '', 'Desactiva Riendas del gran mamut de guerra negro Alianza en Arena Filospada, Ruinas Lordaeron y Arena de Nagrand');

-- Desactiva Riendas del gran mamut de guerra negro (horda) en Arenas Filospada, Ruinas Lordaeron y Arena de Nagrand

DELETE FROM disables WHERE entry = 61467;
INSERT INTO disables (sourceType, entry, flags, params_0, params_1, comment) VALUES (0, 61467, 17, '562,572,559', '', 'Desactiva Riendas del gran mamut de guerra negro Horda en Arena Filospada, Ruinas Lordaeron y Arena de Nagrand');
