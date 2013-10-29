class CreateFunctionStripNonAlphanumeric < ActiveRecord::Migration
  def up
  execute <<-SQL
	CREATE FUNCTION strip_non_alphanumeric( _dirty_string VARCHAR(255) ) 
	RETURNS VARCHAR(255) 
	BEGIN 
		DECLARE _length INT; 
		DECLARE _position INT; 
		DECLARE _current_char VARCHAR(1); 
		DECLARE _clean_string VARCHAR(255); 

		SET _clean_string = ''; 
		SET _length = LENGTH(_dirty_string); 
		SET _position = 1; 
		WHILE _position <= _length DO 
		SET _current_char = SUBSTRING(_dirty_string, _position, 1); 

		IF _current_char REGEXP '[A-Za-z0-9 ]' THEN 
		SET _clean_string = CONCAT(_clean_string, _current_char); 
		ELSE
		SET _clean_string = CONCAT(_clean_string, ' '); 
		END IF; 

		SET _position = _position + 1; 
		END WHILE; 

	RETURN CONCAT('', _clean_string); 
	END
  SQL
  end

  def down
	execute "DROP FUNCTION strip_non_alphanumeric"
  end
end
