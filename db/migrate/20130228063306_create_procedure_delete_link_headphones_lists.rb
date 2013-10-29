class CreateProcedureDeleteLinkHeadphonesLists < ActiveRecord::Migration

  def up

    execute <<-SQL
    CREATE PROCEDURE p_Delete_link_f1_headphones_lists(IN v1_headphones_list_id BIGINT,
                                                    IN v1_debugid VARCHAR(255))
     BEGIN

	DELETE FROM link_f1_headphones_lists WHERE headphones_list_id = v1_headphones_list_id;

	/* Insert a record in debug table for tracking the events */
	call debug.debug_insert(v1_debugid,concat('A link for the headphones_list_id ',v1_headphones_list_id,
	' has been deleted from link_f1_headphones_lists, about a nanosecond ago'));

    END;
    SQL

  end


  def down

	execute "DROP PROCEDURE p_Delete_link_f1_headphones_lists"

  end

end
