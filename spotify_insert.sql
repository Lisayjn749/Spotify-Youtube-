--- Spotify insert --- 

-- Album Type -- 
create sequence seq_spot_album_type;

insert into spot_album_type(album_type_pk, type_name)
select seq_spot_album_type.nextval, album_type
from (
    select album_type
    from spot_stage
    minus 
    select type_name
    from spot_album_type
)


-- 3
select count(distinct album_type) from spot_stage;	
select count(ALBUM_TYPE_pk) from SPOT_ALBUM_TYPE;

select * from SPOT_ALBUM_TYPE;	


-- Album -- 
create sequence seq_spot_album;

insert into spot_album(album_pk, album_name)
select seq_spot_album.nextval, album
from (
    select album
    from spot_stage
    minus 
    select album_name
    from spot_album
)

-- 11853
select count(distinct album) from spot_stage;	
select count(ALBUM_pk) from SPOT_ALBUM;



-- Album Type Map -- 
create sequence seq_spot_alb_alb_type;

insert into SPOT_ALBUM_ABLUM_TYPE(alb_alb_type_pk, album_fk, album_type_fk)
select seq_spot_alb_alb_type.nextval, album_pk, album_type_pk
from (
    select album_pk, album_type_pk
    from spot_stage stg, spot_album alb, spot_album_type typ
    where alb.album_name = stg.album
    and typ.type_name = stg.album_type
    minus 
    select album_fk, album_type_fk
    from SPOT_ALBUM_ABLUM_TYPE
)

-- 11937
SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT DISTINCT album, album_type
  FROM spot_stage
);
SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT DISTINCT album_fk, album_type_fk
  FROM SPOT_ALBUM_TYPE_MAP
);

-- Artist -- 
create sequence seq_spot_artist;

insert into spot_artist(artist_pk, artist_name)
select seq_spot_artist.nextval, artist
from (
    select artist
    from spot_stage
    minus 
    select artist_name
    from spot_artist
)

-- 2074 
select count(distinct ARTIST) from spot_stage;
select count(ARTIST_pk) from SPOT_ARTIST;

select * from SPOT_ARTIST;	


-- Artist Album Bridge -- 
create sequence seq_spot_art_alb;

insert into SPOT_artist_album(art_alb_pk, artist_fk, album_fk)
select seq_spot_art_alb.nextval, artist_pk, album_pk
from (
    select artist_pk, album_pk
    from spot_stage stg, spot_album alb, spot_artist art
    where alb.album_name = stg.album
    and art.artist_name = stg.artist
    minus 
    select artist_fk, album_fk
    from SPOT_artist_album
)

-- 14179
SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT DISTINCT album, artist
  FROM spot_stage
);
SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT DISTINCT album_fk, album_type_fk
  FROM SPOT_ALBUM_TYPE_MAP
);


-- Track -- 
create sequence seq_spot_track;

insert into spot_track(track_pk, track_name)
select seq_spot_track.nextval, track
from(
    select track
    from spot_stage
    minus 
    select track_name
    from spot_track
)

-- 17716
select count(distinct TRACK) from SPOT_stage;
select count(TRACK_pk) from SPOT_TRACK;


-- Album Track Bridge -- 
create sequence seq_spot_alb_track;

insert into SPOT_album_track(alb_track_pk, album_fk, track_fk)
select seq_spot_alb_track.nextval, album_pk, track_pk
from (
    select album_pk, track_pk
    from spot_stage stg, spot_album alb, spot_track track
    where alb.album_name = stg.album
    and track.track_name = stg.track
    minus 
    select album_fk, track_fk
    from SPOT_album_track
)

-- 18682
SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT DISTINCT album, track
  FROM spot_stage
);

-- Track Artist Bridge -- 
create sequence seq_spot_track_art;

insert into SPOT_track_artist(track_art_pk, track_fk, artist_fk)
select seq_spot_track_art.nextval, track_pk, artist_pk
from (
    select track_pk, artist_pk
    from spot_stage stg, spot_track track, spot_artist art
    where art.artist_name = stg.artist
    and track.track_name = stg.track
    minus 
    select track_fk, artist_fk
    from SPOT_track_artist
)

-- 20512
SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT DISTINCT artist, track
  FROM spot_stage
);


-- Platform -- 
create sequence seq_spot_platform;

insert into spot_platform(platform_pk, platform_name)
select seq_spot_platform.nextval, most_playedon
from (
    select most_playedon
    from spot_stage
    minus 
    select platform_name
    from spot_platform
)

-- 2
select count(distinct most_playedon) from spot_stage;	
select count(platform_pk) from SPOT_MOST_PLAY;

-- Platform Track Bridge -- 
create sequence seq_spot_plat_track;

insert into SPOT_plat_track(plat_track_pk, platform_fk, track_fk)
select seq_spot_plat_track.nextval, platform_pk, track_pk
from (
    select platform_pk, track_pk
    from spot_stage stg, spot_track track, spot_platform plat
    where plat.platform_name = stg.most_playedon
    and track.track_name = stg.track
    minus 
    select platform_fk, track_fk
    from SPOT_plat_track
)

-- 18085
SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT DISTINCT most_playedon, track
  FROM spot_stage)


-- Channel -- 
create sequence seq_spot_channel;

insert into spot_channel(channel_pk, channel_name)
select seq_spot_channel.nextval, channel
from (
    select channel
    from spot_stage stage
    minus 
    select channel_name
    from spot_channel
)

-- 6673
select count(distinct channel) from spot_stage;	
select count(CHANNEL_pk ) from SPOT_CHANNEL;


-- Vid -- 
create sequence seq_spot_vid;

insert into spot_vid(vid_pk, vid_name, licensed, official_video)
select seq_spot_vid.nextval, title, licensed, official_video
from (
    select distinct title, licensed, official_video
    from spot_stage
    minus 
    select vid_name, licensed, official_video
    from spot_vid
)

-- 18036
SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT DISTINCT title, licensed, official_video
  FROM spot_stage)
  

-- Video Channel Bridge -- 
create sequence seq_spot_vid_channel;

insert into SPOT_vid_channel(vid_chanl_pk, vid_fk, channel_fk)
select seq_spot_vid_channel.nextval, vid_pk, channel_pk
from (
    select vid_pk, channel_pk
    from spot_stage stg, spot_vid vid, spot_channel chanl
    where vid.vid_name = stg.title
    and chanl.channel_name = stg.channel
    minus 
    select vid_fk, channel_fk
    from SPOT_vid_channel
)

-- 18029
SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT DISTINCT title, channel
  FROM spot_stage
);
  

SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT DISTINCT vid_fk, channel_fk
  FROM spot_vid_channel
);

-- Video Track Bridge -- 
create sequence seq_spot_vid_track;

insert into SPOT_vid_track(vid_track_pk, vid_fk, track_fk)
select seq_spot_vid_track.nextval, vid_pk, track_pk
from (
    select vid_pk, track_pk
    from spot_stage stg, spot_track track, spot_vid vid
    where vid.vid_name = stg.title
    and track.track_name = stg.track
    minus 
    select vid_fk, track_fk
    from SPOT_vid_track
)

-- 19050
SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT DISTINCT title, track
  FROM spot_stage)

-- Youtube Stats -- 
create sequence seq_spot_yt_stats;

insert into spot_yt_stats(yt_stat_pk, yt_views, likes, comments, vid_fk)
select seq_spot_yt_stats.nextval, views, likes, comments, vid_pk
from (
    select views, likes, comments, vid_pk
    from spot_stage stage, spot_vid vid
    where vid.vid_name = stage.title
    minus 
    select yt_views, likes, comments, vid_fk
    from spot_yt_stats
)

-- 19208
SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT DISTINCT title, views, likes, comments
  FROM spot_stage)


-- Spotify Stats -- 
create sequence seq_spot_sp_stats;

insert into spot_sp_stats(sp_stat_pk, sp_streams, track_fk)
select seq_spot_sp_stats.nextval, stream, track_pk
from (select stream, track_pk
    from spot_stage stage, spot_track track
    where track.track_name = stage.track
    minus 
    select sp_streams, track_fk
    from spot_sp_stats
)

drop sequence seq_spot_sp_stats;
truncate table spot_sp_stats;

-- 18908
SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT distinct stream, track
  FROM spot_stage
);	


-- Feature --
create sequence seq_spot_feature;

insert into spot_feature(feature_pk, Danceability, Energy, Loudness, Speechiness, Acousticness, Instrumentalness, Liveness, Valence, Tempo, Duration_min, Energy_Liveness, track_fk)
select seq_spot_feature.nextval, Danceability, Energy, Loudness, Speechiness, Acousticness, Instrumentalness, Liveness, Valence, Tempo, Duration_min, EnergyLiveness, track_pk
from (
    select Danceability, Energy, Loudness, Speechiness, Acousticness, Instrumentalness, Liveness, Valence, Tempo, Duration_min, EnergyLiveness, track_pk
    from spot_stage stage, spot_track track
    where track.track_name = stage.track
    minus 
    select Danceability, Energy, Loudness, Speechiness, Acousticness, Instrumentalness, Liveness, Valence, Tempo, Duration_min, Energy_Liveness, track_fk
    from spot_feature
)

-- 18730
SELECT COUNT(*) AS distinct_pair_count
FROM (
  SELECT distinct Danceability, Energy, Loudness, Speechiness, Acousticness, Instrumentalness, Liveness, Valence, Tempo, Duration_min, EnergyLiveness
  FROM spot_stage
);	






-- Views -- 
create or replace view spot_view as 
select *
from (
    select 
        artist_name artist, track_name track, album_name album, type_name album_type,
        Danceability, Energy, Loudness, Speechiness, Acousticness, Instrumentalness, Liveness, Valence, Tempo, Duration_min, 
        vid_name title, channel_name channel, 
        yt_views, likes, comments,
        licensed, official_video, sp_streams, Energy_Liveness EnergyLiveness, platform_name most_playedon
    from 
        spot_yt_stats yt_stats
    
    full outer join 
        spot_vid vid
    on vid.vid_pk = yt_stats.vid_fk
    
    join 
        spot_channel channel
    on channel.channel_pk = vid.channel_fk
    
    full outer join
        spot_track track
    on track.track_pk = vid.track_fk
    
    join 
        spot_feature 
    on track.track_pk = spot_feature.track_fk
    
    join 
        spot_sp_stats sp_stats
    on track.track_pk = sp_stats.track_fk
    
    join 
        spot_artist artist
    on artist.artist_pk = track.artist_fk
    
    join 
        spot_most_play most_play
    on most_play.platform_pk = track.platform_fk
    
    join 
        spot_album album
    on album.album_pk = track.album_fk
    
    join 
        spot_album_type_map alb_map
    on alb_map.album_fk = album.album_pk
    
    join 
        spot_album_type typ
    on typ.album_type_pk = alb_map.album_type_fk
)
        
select count(licensed) from spot_vid    
select count(vid_name) from spot_vid
select count(*) from spot_yt_stats
select count(*) from ly_spot_stage
select count(distinct yt_stat_pk) from spot_yt_stats
select count(*) from spot_track

-- Album Type-- 
create or replace view spot_album_type_view as 
select * 
from (select album_type_pk, type_name album_type
        from spot_album_type)
        
-- Album -- 
create or replace view spot_album_view as 
select * 
from (select album_pk, ablum_name album
        from spot_album_type)

select  'drop sequence seq_'||table_name || ';'
     from user_tables  -- user_tables
     where  table_name like '%SPOT%'
     
    
select  'drop table '||table_name || ';'
     from user_tables  -- user_tables
     where  table_name like '%SPOT%'


select  'select * from '||table_name || ';'，
         'select ' || table_name || '_pk count(*) from spot_stage;',
        'select count(*) from '||table_name || ';'
     from user_tables  -- user_tables
     where  table_name like '%SPOT%'

select count(*) from spot_stage

drop table SPOT_ALBUM;
drop table SPOT_ALBUM_ABLUM_TYPE;
drop table SPOT_ALBUM_TRACK;
drop table SPOT_ALBUM_TYPE;
drop table SPOT_ALBUM_TYPE_MAP;
drop table SPOT_ARTIST;
drop table SPOT_ARTIST_ALBUM;
drop table SPOT_CHANNEL;
drop table SPOT_PLATFORM;
drop table SPOT_PLAT_TRACK;
drop table SPOT_TRACK;
drop table SPOT_TRACK_ARTIST;
drop table SPOT_VID;
drop table SPOT_VID_CHANNEL;
drop table SPOT_VID_TRACK;

select album, album_type 
from SPOT_STAGE
group by album 
having count(album_type) > 1

     
drop sequence seq_SPOT_ALBUM;
drop sequence seq_SPOT_ALBUM_TYPE;
drop sequence seq_SPOT_ALBUM_TYPE_MAP;
drop sequence seq_SPOT_CHANNEL;
drop sequence seq_SPOT_FEATURE;
drop sequence seq_SPOT_MOST_PLAY;
drop sequence seq_SPOT_SP_STATS;
drop sequence seq_SPOT_STAGE;
drop sequence seq_SPOT_TRACK;
drop sequence seq_SPOT_VID;
drop sequence seq_SPOT_YT_STATS;
drop sequence seq_SPOT_ARTIST;

SET DEFINE OFF
CREATE TABLE SPOT_STAGE ( Artist VARCHAR2(500),
Track VARCHAR2(2000),
Album VARCHAR2(500),
Album_type VARCHAR2(500),
Danceability NUMBER(38, 3),
Energy NUMBER(38, 3),
Loudness NUMBER(38, 3),
Speechiness NUMBER(38, 4),
Acousticness NUMBER(38, 8),
Instrumentalness NUMBER(38, 8),
Liveness NUMBER(38, 4),
Valence NUMBER(38, 3),
Tempo NUMBER(38, 3),
Duration_min NUMBER(38, 9),
Title VARCHAR2(1000),
Channel VARCHAR2(1000),
Views NUMBER(38),
Likes NUMBER(38),
Comments NUMBER(38),
Licensed VARCHAR2(100),
official_video VARCHAR2(100),
Stream NUMBER(38),
EnergyLiveness NUMBER(38, 9),
most_playedon VARCHAR2(100));

select album
from (
    select album, album_type
    from spot_stage
    group by album, album_type
)
group by album
having count(*) > 1

select title
from (
    select title,channel
    from spot_stage
    group by title, channel
)
group by title
having count(*) > 1

select title, channel
from spot_stage
where title = 'Vete'

select album, album_type, artist, track, most_playedon
from spot_stage
where album = 'Home'

select album, album_type, artist, track, most_playedon
from spot_stage
where track = 'El Perdedor'

-- 1. add pk to bridge tables 
-- 2. get rid of 'map' in bridge tables names
-- 2.1 fix names of the constraints
-- 3. change most_play to platform
-- 3.1 change id to pk and fk
-- 4. add the 6 bridge tables listed below
-- 5. check data model first!
-- 6. check insert rows and compare with each other!

-- many to many
-- track and artist (song be sang by multiple artists) -- album_artist
-- album and track (one track belongs to multiple albums)
-- artist and album 
-- album and album type (one album has multiple album types)
-- video and channel
-- platform and track 



-- shows dups!
select track_name, count(*) 
from spot_track
group by track_name
having count(*) > 1

select count(*) from spot_track_artist brg
join spot_track trk
    on trk.track_pk = brg.track_fk
    
    
select count(distinct track_name) from spot_track_artist brg
join spot_track trk
    on trk.track_pk = brg.track_fk

select track_name from spot_track_artist brg
join spot_track trk
    on trk.track_pk = brg.track_fk

minus 
select track 
from spot_stage

select * from SPOT_ALBUM;	

SELECT COUNT(*) FROM (SELECT DISTINCT stream, track)

select count(distinct stream) from spot_stage;	
select count(Sp_STAT_pk) from SPOT_SP_STATS;
select count(*) from SPOT_SP_STATS


SELECT track_name, COUNT(*)
FROM spot_track
GROUP BY track_name
HAVING COUNT(*) > 1;

select track
from spot_stage
where stream is null
    


select * from SPOT_CHANNEL;	

select * from spot_view

select * from SPOT_STAGE;	select SPOT_STAGE_pk count(*) from spot_stage;	select count(*) from SPOT_STAGE;

select * from SPOT_VID;	select SPOT_VID_pk count(*) from spot_stage;	select count(*) from SPOT_VID;
select * from SPOT_YT_STATS;	select SPOT_YT_STATS_pk count(*) from spot_stage;	select count(*) from SPOT_YT_STATS;


create or replace view spot_top_artist_by_view as 

select channel, sum(views) total_views
from spot_stage
group by channel
order by total_views desc
fetch first 10 rows only

select * from spot_top_artist_by_view


CREATE VIEW v_top_youtube_tracks AS
SELECT
  trk.track_name,
  art.artist_name,
  yt.views,
  sp.streams,
  f.danceability,
  f.energy,
  f.valence,
  f.speechiness,
  f.instrumentalness,
  f.liveness,
  f.loudness,
  f.tempo,
  f.duration
FROM SPOT_TRACK trk
JOIN SPOT_VID_TRACK ytvt ON ytvt.track_fk = trk.track_pk
JOIN NKF_SPOT_VID vid ON ytvid.vid_pk = ytvt.yt_vid_fk
JOIN N_SPOT_YT_STAT yt ON yt.yt_vid_fk = ytvid.vid_pk
LEFT JOIN NKF_SPOT_SP_STAT sp ON sp.track_fk = trk.track_pk
JOIN NKF_SPOT_TRACK_ARTIST ta ON ta.track_fk = trk.track_pk
JOIN NKF_SPOT_ARTIST art ON art.artist_pk = ta.artist_fk
LEFT JOIN NKF_SPOT_FEATURE f ON f.track_fk = trk.track_pk
ORDER BY yt.views DESC;


  
    