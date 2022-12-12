/**
* This interceptor secures all API requests
*/
component{
    // This will only run when the event starts with "api."
    function preProcess( event, interceptData, buffer ) eventPattern = '^api\.' {
        var APIUser = event.getHTTPHeader( 'APIUser', 'default' );

        // Only Honest Abe can access our API
        if( APIUser != 'Honest Abe' ) {
            // Every one else will get the error response from this event
            event.overrideEvent( 'api.general.authFailed' );
        }
    }
}
