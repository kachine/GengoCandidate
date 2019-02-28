-- Example usage: 
--    sqlite3 :memory: < scripts.sql

-- 常用漢字一覧を新規テーブルにロード
CREATE TABLE KANJI_MASTER (
    SEQ     INTEGER,
    KANJI   TEXT,
    PRIMARY KEY (
        SEQ
    )
);
.separator ,
.import ./johyohkanji.list KANJI_MASTER
-- Expected result:
-- sqlite>select count(0) from KANJI_MASTER;
-- 2136


-- 既存元号一覧を新規テーブルにロード
CREATE TABLE GENGO_MASTER (
    GENGO   TEXT,
    PRIMARY KEY (
        GENGO
    )
);
.import ./old_gengo.list GENGO_MASTER
-- Expected result:
-- sqlite> select count(0) from GENGO_MASTER;
-- 247


-- 新規元号候補一覧を新規テーブルに作成
CREATE TABLE GENGO_CANDIDATES (
    GENGO_CANDIDATE TEXT,
    PRIMARY KEY (
        GENGO_CANDIDATE
    )
);

INSERT
  INTO GENGO_CANDIDATES
SELECT km1.KANJI||km2.KANJI as GENGO_CANDIDATE
  FROM KANJI_MASTER km1
           CROSS JOIN KANJI_MASTER km2
 WHERE km1.KANJI||km2.KANJI NOT IN (
           SELECT GENGO
             FROM GENGO_MASTER
           )
 ORDER BY
       km1.SEQ,
       km2.SEQ;
-- Expected result:
-- sqlite> select count(0) from GENGO_CANDIDATES;
-- 4562293


-- 新規元号候補一覧をファイルに出力
.head off
.mode list
.out ./gengo_candidates.txt
SELECT GENGO_CANDIDATE
  FROM GENGO_CANDIDATES;


-- 終了
.exit
