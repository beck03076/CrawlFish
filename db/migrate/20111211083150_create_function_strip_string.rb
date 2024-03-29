class CreateFunctionStripString < ActiveRecord::Migration
  def up
    execute <<-SQL
    CREATE FUNCTION `CAP_FIRST`(input VARCHAR(255)) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
    BEGIN
        DECLARE len INT;
        DECLARE i INT;
        DECLARE answer VARCHAR(255);

        SET len   = CHAR_LENGTH(input);
        SET input = LOWER(input);
        SET i = 0;

        WHILE (i < len) DO
        IF (MID(input,i,1) = ' ' OR i = 0) THEN
        IF (i < len) THEN
        SET input = CONCAT(
        LEFT(input,i),
        UPPER(MID(input,i + 1,1)),
        RIGHT(input,len - i - 1)
        );
        END IF;
        END IF;
        SET i = i + 1;
        END WHILE;

        SET answer = REPLACE(input," ","-");

        RETURN answer;

    END
    SQL
  end

  def down
    execute "DROP FUNCTION CAP_FIRST"
  end
end

