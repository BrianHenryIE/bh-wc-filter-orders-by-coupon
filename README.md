## WooCommerce Filter Orders by Coupon

 - Requires WordPress 3.8+, WooCommerce 2.2+
 - Contributors: [Beka Rice](http://github.com/bekarice), [SkyVerge](http://github.com/skyverge/), [Brian Henry](https://BrianHenry.ie)
 - Like this? [We always appreciate donations](https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=paypal@skyverge.com&item_name=Donation+for+WooCommerce+Filter+Orders)
 - Current version: 1.1.0
 - License: [GPLv3](http://www.gnu.org/licenses/gpl-3.0.html)
 
### Description
 
Does exactly what you think :) This plugin adds a new filtering option to the orders screen. This allows you to filter your orders by the coupon used within the order.

While you can search for the coupon used, this isn't ideal to find orders that have used a coupon, as you may have product names that contain the coupon name. This plugin adds a filtering option to return exact results for orders that have used a particular coupon.

Only coupons that are "published" (no drafts) will be available in the filtering dropdown.  If you have no published coupons, this dropdown will not show.

### Testing

The test dependencies require Node v12, so always run `nvm use` before any commands. Install the dependencies with:

``bash
nvm use
npm install
```

To run the tests:

```
nvm use
npm run-script docker:up
npm run-script test:e2e
```

To enable and migrate the existing orders to HPOS:

```
nvm use
npm run-script docker:ssh

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# This said it worked
wp option set woocommerce_custom_orders_table_enabled yes --allow-root
wp option set woocommerce_feature_custom_order_tables_enabled yes --allow-root

wp option get woocommerce_custom_orders_table_enabled --allow-root
wp option get woocommerce_feature_custom_order_tables_enabled --allow-root

wp wc cot sync --allow-root
```

This worked with no changes to the code.

### Changelog

**2023.03.15**

* Added HPOS tests.

**2017.06.27 - version 1.1.0**
 * Feature: Add support for GitHub Updater
 * Misc: Code cleanup

**2015.07.27 - version 1.0.1**
 * Misc: WooCommerce 2.4 compatibility

**2015.03.06 - version 1.0.0**
 * Initial Release
