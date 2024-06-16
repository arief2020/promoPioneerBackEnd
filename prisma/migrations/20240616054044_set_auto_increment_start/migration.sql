-- Tambahkan ini di bagian akhir file migration.sql
DO $$
BEGIN
   IF (SELECT last_value FROM "Product_id_seq") < 21 THEN
      ALTER SEQUENCE "Product_id_seq" RESTART WITH 21;
   END IF;
END $$;
