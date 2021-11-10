import { LightningElement, track, api } from 'lwc';
import makeGetCallout from '@salesforce/apex/StripeAPIHandler.makeGetCallout';

export default class ExampleInvoice extends LightningElement {
    
    async Invoiceurl(){
        //SetExample Vars
        var email = "myexampleCustomer@example.com";
        var amount = 76856.00
        var currency = 'usd';

        //Get Customer
        var customerID;
        var url = "https://api.stripe.com//v1/customers?email=" + email + "&limit=1";
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
            urlencoded.append("email", email);
            var url = "https://api.stripe.com//v1/customers";
            var method = "POST";
            let pcreatecustomer = await makeGetCallout({urlencoded:urlencoded.toString(),url:url, method:method});
            var createcustomer = JSON.parse(pcreatecustomer);
            customerID = createcustomer.id
        }
        //Create Line Item
        var urlencoded = new URLSearchParams();
        urlencoded.append("customer", customerID);
        urlencoded.append("amount", amount);
        urlencoded.append("currency", currency);
        urlencoded.append("description", "Sales Force Example Integration");
        var url = "https://api.stripe.com//v1/invoiceitems";
        var method = "POST";
        let plineitems = await makeGetCallout({urlencoded:urlencoded.toString(),url:url, method:method});
        var lineitems = JSON.parse(plineitems);
        
        //Create Invoice
        var urlencoded = new URLSearchParams();
        urlencoded.append("customer", customerID);
        urlencoded.append("collection_method", "send_invoice");
        urlencoded.append("days_until_due", 30);
        urlencoded.append("description", "SalesForce Example Integration");
        var url = "https://api.stripe.com//v1/invoices";
        var method = "POST";
        let pinvoice = await makeGetCallout({urlencoded:urlencoded.toString(),url:url, method:method});
        var invoice = JSON.parse(pinvoice);

        //Finalize Invoice
        var urlencoded = new URLSearchParams();
        var url = "https://api.stripe.com//v1/invoices/" + invoice.id + "/finalize"
        var method = "POST";
        let pfinvoice = await makeGetCallout({urlencoded:null,url:url, method:method});
        var finvoice = JSON.parse(pfinvoice);
        window.open(finvoice.hosted_invoice_url);
            
        }   
    
}