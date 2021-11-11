import { LightningElement } from 'lwc';
import makeGetCallout from '@salesforce/apex/StripeAPIHandler.makeGetCallout';

export default class StripeExampleCheckout extends LightningElement {
    customerEmail = 'exampleCustomer@example.com';
    amount = 76800.00;
    paymentMethodOne='card';
    paymentMethodTwo='klarna';
    customerID = '';
    currency = 'usd';

    async getCheckoutLink(){
        //Get Customer
        var customerID;
        var url = "https://api.stripe.com//v1/customers?email=" + this.customerEmail + "&limit=1";
        var method = 'GET';
        var urlencoded = new URLSearchParams();
        let pgetcustomer = await makeGetCallout({urlencoded:null,url:url, method:method});
        var getcustomer = JSON.parse(pgetcustomer);
        if (getcustomer.data.length >= 1){
            customerID = getcustomer.data[0].id
        }
        //Create Customer if no customer is found
        if (getcustomer.data.length == 0){
            var urlencoded = new URLSearchParams();
            urlencoded.append("email", this.customerEmail);
            var url = "https://api.stripe.com//v1/customers";
            var method = "POST";
            let pcreatecustomer = await makeGetCallout({urlencoded:urlencoded.toString(),url:url, method:method});
            var createcustomer = JSON.parse(pcreatecustomer);
            customerID = createcustomer.id
        }

        //Create link
        var urlencoded = new URLSearchParams();
        urlencoded.append("cancel_url", "https://www.google.com");
        urlencoded.append("success_url", "https://www.google.com");
        urlencoded.append("customer", customerID);
        urlencoded.append("customer_update[address]", "auto");
        urlencoded.append("customer_update[name]", "auto");
        urlencoded.append("line_items[0][price_data][currency]", this.currency);
        urlencoded.append("line_items[0][price_data][product_data][name]", "Sales Force Example");
        urlencoded.append("line_items[0][price_data][product_data][description]", "Sales Force Example");
        urlencoded.append("line_items[0][price_data][unit_amount_decimal]", this.amount);
        urlencoded.append("line_items[0][quantity]", "1");
        urlencoded.append("mode", "payment");
        urlencoded.append("payment_method_types[0]", this.paymentMethodOne);
        urlencoded.append("payment_method_types[1]", this.paymentMethodTwo);
        var method = 'POST';
        var url = 'https://api.stripe.com/v1/checkout/sessions'
        let pcheckout = await makeGetCallout({urlencoded:urlencoded.toString(),url:url, method:method});
        var checkout = JSON.parse(pcheckout);
        window.open(checkout.url);
        }

}