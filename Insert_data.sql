--- Spotify+Youtube Insert --- 
--- Insert the raw data to the normalized tables in the database -- 

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

-- Check if there's duplicates
-- 3 distinct values
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
     
    

      
-- Shortcut commands -- 
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




  
    
