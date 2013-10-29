class CreateProcedureGatewayOfCrawlfish < ActiveRecord::Migration
def up
    execute "DROP PROCEDURE IF EXISTS p_gateway_of_crawlfish"

    execute <<-SQL
    CREATE PROCEDURE p_gateway_of_crawlfish(IN v2_product_id BIGINT,
                                            IN v2_sub_category VARCHAR(255),
                                            IN v2_debug_id VARCHAR(255),
					    IN v2_product_name VARCHAR(255),
					    IN v2_delete_flag INT)


    BEGIN

	IF v2_delete_flag = 0 THEN

	IF LOWER(v2_sub_category) = LOWER('books_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_books_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_books_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);


	ELSEIF LOWER(v2_sub_category) = LOWER('mobiles_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_mobiles_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_mobiles_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);
	
	ELSEIF LOWER(v2_sub_category) = LOWER('laptops_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_laptops_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_laptops_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);

	ELSEIF LOWER(v2_sub_category) = LOWER('desktops_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_desktops_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_desktops_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);

	ELSEIF LOWER(v2_sub_category) = LOWER('external_hdds_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_external_hdds_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_external_hdds_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);

	ELSEIF LOWER(v2_sub_category) = LOWER('printers_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_printers_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_printers_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);

	ELSEIF LOWER(v2_sub_category) = LOWER('routers_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_routers_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_routers_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);

	ELSEIF LOWER(v2_sub_category) = LOWER('mouses_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_mouses_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_mouses_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);

	ELSEIF LOWER(v2_sub_category) = LOWER('keyboards_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_keyboards_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_keyboards_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);

	ELSEIF LOWER(v2_sub_category) = LOWER('speakers_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_speakers_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_speakers_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);

	ELSEIF LOWER(v2_sub_category) = LOWER('memory_cards_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_memory_cards_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_memory_cards_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);

	ELSEIF LOWER(v2_sub_category) = LOWER('pendrives_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_pendrives_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_pendrives_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);

	ELSEIF LOWER(v2_sub_category) = LOWER('headphones_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_headphones_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_headphones_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);

	ELSEIF LOWER(v2_sub_category) = LOWER('headsets_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_headsets_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_headsets_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);

	ELSEIF LOWER(v2_sub_category) = LOWER('tablets_lists') THEN

	call debug.debug_insert(v2_debug_id,'Procedure p_gateway_calls_tablets_lists is invoked, about a  nanosecond ago');

	call p_gateway_calls_tablets_lists(v2_product_id,
                                         v2_sub_category,
                                         v2_debug_id,
					 v2_product_name);

	ELSE

	call debug.debug_insert(v2_debug_id,'Some problem in procedure p_gateway_of_crawlfish');

	END IF;

	END IF;
 
    END;

  SQL

  end

  def down

    execute "DROP PROCEDURE p_gateway_of_crawlfish"

  end
end

