CREATE OR REPLACE FUNCTION reset_all_sequences(min_value integer DEFAULT 1000)
RETURNS void AS $$
DECLARE
  rec RECORD;
  seq_name text;
  max_val bigint;
  new_val bigint;
  table_full_name text;
BEGIN
  FOR rec IN
    SELECT 
      table_schema,
      table_name,
      column_name,
      substring(column_default FROM '''(.+?)''') AS seq_name
    FROM information_schema.columns
    WHERE column_default LIKE 'nextval(%'
      AND table_schema = current_schema()
  LOOP
    seq_name := rec.seq_name;
    table_full_name := quote_ident(rec.table_schema) || '.' || quote_ident(rec.table_name);

    -- テーブルの対象カラムの最大値を取得
    EXECUTE format('SELECT COALESCE(MAX(%I), 0) FROM %s', rec.column_name, table_full_name)
    INTO max_val;

    -- 最大値と min_value の大きい方を設定
    new_val := GREATEST(min_value, max_val);

    RAISE NOTICE 'Resetting sequence % for %(%), max_val: %, setval to: %', seq_name, rec.table_name, rec.column_name, max_val, new_val;

    -- シーケンスの値を更新
    EXECUTE format('SELECT setval(%L, %s, true)', seq_name, new_val);
  END LOOP;
END;
$$ LANGUAGE plpgsql;


SELECT reset_all_sequences();

-- テスト
SELECT nextval('user_id_seq');