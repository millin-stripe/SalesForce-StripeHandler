import { LightningElement, track, api } from 'lwc';
import makeGetCallout from '@salesforce/apex/StripeAPIHandler.makeGetCallout';
export default class PaymentElements extends LightningElement {

    @api siteclientSecret;
    @api isReloaded = false;
//This starts the url call back into stripe.
    async renderedCallback(){
        //check to see if this iframe url is set for the visualforce page. Due to security restrictions around external JS loads in SF
        //we have to do a Visualforce page and not directly with a lwc
        if (this.siteclientSecret == undefined){
            //Vaiables you can set
            var amount = 4000;
            var currency = 'usd';
            var paymentMethodone = 'card';

            //Start calling the Stripe API Handler Class
            //Define url Parameters if needed
            var urlencoded = new URLSearchParams();
            urlencoded.append("amount", amount);
            urlencoded.append("currency", currency);
            urlencoded.append("payment_method_types[0]", paymentMethodone);

            //Define URL Method
            var method = 'POST';

            //Define URL to call in stripe
            var url = 'https://api.stripe.com//v1/payment_intents'

            //Call the Stripe API Handler class. this returns a promise with a string body that is JSON
            let presult = await makeGetCallout({urlencoded:urlencoded.toString(),url:url, method:method});

            //Take the text return and make it a JSON object
            var result = JSON.parse(presult);
            
            //This creates the url for the iframe for the visualforce page StripeElement. 
            this.siteclientSecret = '/apex/StripeElement?clientSecret=' + result.client_secret;
            console.log(this.siteclientSecret);
        } 
    }
    
}