const {
    merchant,
    uiUnblocked,
} = require( '@woocommerce/e2e-utils' );

describe( 'Verify filter is working', () => {
    it( 'should see no orders when filtering by coupon10', async () => {
        await merchant.login();

        await merchant.openAllOrdersView();

        // select id dropdown_coupons_used

        // Select coupon30 from the select drop-down
        await page.select( '#dropdown_coupons_used', 'coupon10' );

        // Press the Filter button.
        await page.click( '#post-query-submit', { waitUntil: 'networkidle0' } );

        await uiUnblocked();

        await page.waitFor(1000);

        // The list table tbody is called #the-list.
        const orderCount = await page.evaluate(
            'document.querySelector("#the-list").childElementCount '
        );

        // In initalize.sh we created zero (0) order using coupon10.
        // But "No orders found" counts as a row.
        expect( orderCount ).toEqual( 1 );
    } );

    it( 'should see two orders when filtering by coupon20', async () => {
        await merchant.login();

        await merchant.openAllOrdersView();

        // select id dropdown_coupons_used

        // Select coupon30 from the select drop-down
        await page.select( '#dropdown_coupons_used', 'coupon20' );

        // Press the Filter button.
        await page.click( '#post-query-submit', { waitUntil: 'networkidle0' } );

        await uiUnblocked();

        await page.waitFor(1000);

        // The list table tbody is called #the-list.
        const orderCount = await page.evaluate(
            'document.querySelector("#the-list").childElementCount '
        );

        // In initalize.sh we created two (2) order using coupon 20.
        expect( orderCount ).toEqual( 2 );
    } );

    it( 'should see three orders when filtering by coupon30', async () => {
        await merchant.login();

        await merchant.openAllOrdersView();

        // select id dropdown_coupons_used

        // Select coupon30 from the select drop-down
        await page.select( '#dropdown_coupons_used', 'coupon30' );

        // Press the Filter button.
        await page.click( '#post-query-submit', { waitUntil: 'networkidle0' } );

        await uiUnblocked();

        await page.waitFor(1000);

        // The list table tbody is called #the-list.
        const orderCount = await page.evaluate(
            'document.querySelector("#the-list").childElementCount '
        );

        // In initalize.sh we created three (3) order using coupon30.
        expect( orderCount ).toEqual( 3 );
    } );
} );
