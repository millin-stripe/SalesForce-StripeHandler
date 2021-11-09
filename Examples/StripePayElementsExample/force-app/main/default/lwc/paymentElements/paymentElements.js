import { LightningElement, track, api } from 'lwc';
import makeGetCallout from '@salesforce/apex/StripeAPIHandler.makeGetCallout';
export default class PaymentElements extends LightningElement {
    //@track siteclientSecret;
    @api siteclientSecret;
    @api isReloaded = false;
    async renderedCallback(){
        var amount = 4000;
        var currency = 'usd';
        var paymentMethodone = 'card';
        var paymentMethodtwo = 'afterpay_clearpay';
        var urlencoded = new URLSearchParams();
        urlencoded.append("amount", amount);
        urlencoded.append("currency", currency);
        urlencoded.append("payment_method_types[0]", paymentMethodone);
        urlencoded.append("payment_method_types[1]", paymentMethodtwo);
        var method = 'POST';
        var url = 'https://api.stripe.com//v1/payment_intents'
        let presult = await makeGetCallout({urlencoded:urlencoded.toString(),url:url, method:method});
        var result = JSON.parse(presult);
        if (this.siteclientSecret == undefined){
            this.siteclientSecret = '/apex/PaymentElements?clientSecret=' + result.client_secret;
            console.log(this.siteclientSecret);
        } 
    }
    
}