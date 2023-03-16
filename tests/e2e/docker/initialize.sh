#!/bin/bash

echo "$ printenv"
printenv

# Without this, things fail and loop
# Make sure to include the --user flag with an account that has permissions for this action. {"status":401}
echo "user: admin" > wp-cli.yml

echo "Install WooCommerce & Storefront"
wp plugin install woocommerce --activate
wp theme install storefront --activate

echo "Creating WooCommerce Customer Account"
wp user create customer customer@woocommercecoree2etestsuite.com \
	--user_pass=password \
	--role=subscriber \
	--first_name='Jane' \
	--last_name='Smith' \
	--path=/var/www/html || true

echo "Adding basic WooCommerce settings..."
wp option set woocommerce_store_address "Example Address Line 1"
wp option set woocommerce_store_address_2 "Example Address Line 2"
wp option set woocommerce_store_city "Example City"
wp option set woocommerce_default_country "US:CA"
wp option set woocommerce_store_postcode "94110"
wp option set woocommerce_currency "USD"
wp option set woocommerce_product_type "both"
wp option set woocommerce_allow_tracking "no"
wp rewrite structure /%postname%/

echo "Importing WooCommerce shop pages..."
wp wc --user=admin tool run install_pages

echo "Installing and activating the WordPress Importer plugin..."
wp plugin install wordpress-importer --activate

echo "Importing WooCommerce sample products..."
wp import wp-content/plugins/woocommerce/sample-data/sample_products.xml --authors=skip

echo "Installing basic-auth to interact with the API..."
wp plugin install https://github.com/WP-API/basic-auth/archive/master.zip --activate --force

# install the WP Mail Logging plugin to test emails
wp plugin install wp-mail-logging --activate

wp plugin delete akismet
wp plugin delete hello

# initialize pretty permalinks
wp rewrite structure /%postname%/

# echo "Activate <your-extension>"
wp plugin activate bh-wc-filter-orders-by-coupon

wp wc shop_coupon create --code=COUPON10 --amount=10
wp wc shop_coupon create --code=COUPON20 --amount=20
wp wc shop_coupon create --code=COUPON30 --amount=30

# Do we need to delete the orders here or is it always a fresh slate when this runs?
# wp wc shop_order list --field=id | xargs -n1 wp wc shop_order delete --force

wp wc shop_order create --coupon_lines='[{"code":"COUPON20"}]' --allow-root
wp wc shop_order create --coupon_lines='[{"code":"COUPON20"}]' --allow-root

wp wc shop_order create --coupon_lines='[{"code":"COUPON30"}]' --allow-root
wp wc shop_order create --coupon_lines='[{"code":"COUPON30"}]' --allow-root
wp wc shop_order create --coupon_lines='[{"code":"COUPON30"}]' --allow-root

echo "Success! Your E2E Test Environment is now ready."
