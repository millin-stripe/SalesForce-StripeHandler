public with sharing class StripeAPIHandler {
    @AuraEnabled
    public static String makeGetCallout(String urlencoded, String url, String method) {
        String delimiter = 'com';
        String input = '' + url;
        String firstSplit = input.substringBefore(delimiter);
        String lastSplits = input.substringAfter(delimiter);
        HTTPRequest r = new HTTPRequest();
        r.setHeader('Content-Type','application/x-www-form-urlencoded');
        r.setHeader('Accept', 'application/json');
        r.setEndpoint('callout:Stripe_Secret_API_Key' + lastSplits);
        r.setMethod(method);
        if (urlencoded != null){
            String Body = '' + urlencoded;
            r.setBody(Body);
        }
        return new Http().send(r).getBody();
}
}

