@RestResource(urlMapping='/Stripe/Webhook/Processor/*')
global with sharing class StripeWebhookHandler
{
    @HttpPost
    global static void processWebhook(){
        RestRequest req = RestContext.request;
        RestResponse resp = RestContext.response;
        String WebhookKey = 'whsec_3Du8aeUWFW5fC0g1iS24S6x0h0ryVLHc';
        Boolean check = SignatureCheck(req, resp, WebhookKey);
        if (check == true){
            Blob jsonBlob = req.requestBody;
            String jsonString = jsonBlob.toString();
            jsonString = jsonString.replaceAll('\r', '');
            String mystring = WebhookSort(jsonString);
        }
        
    }
    public static Boolean SignatureCheck(RestRequest req, RestResponse resp, String webhookKey){
        try{
            Blob jsonBlob = req.requestBody;
            String jsonString = jsonBlob.toString();
            jsonString = jsonString.replaceAll('\r', '');
            
            String stripeSigniture = req.headers.get('Stripe-Signature');
            
            Map<String,String> sigMap = new Map<String,String>();
            List<String> signatures = stripeSigniture.split(',');
            for(String kv:signatures){
                sigMap.put(kv.split('=')[0],kv.split('=')[1]);
            }
            
            String signature_payload = sigMap.get('t')+'.'+jsonString;
            Blob input = Blob.valueOf(signature_payload);
            
            Blob 
                privateKey=Blob.valueOf(webhookKey);
            
            Blob hmac = Crypto.generateMac('HmacSHA256',input , privateKey);
            String incomingSignature = sigMap.get('v1');
            
            if (incomingSignature==EncodingUtil.convertToHex(hmac)){
                string tempString = 'Webhook was processed';
                Blob tempBlob = Blob.valueOf(tempString);
                resp.responseBody = tempBlob;
                resp.statusCode = 200;
                return true;
                 
            }
            else {
                string tempString = 'Error: The Sec keys do not match. Plese check that the WebhookKey variable value matches the value of Signing secret from the webhook';
                // convert from string to blob
                Blob tempBlob = Blob.valueOf(tempString);
                resp.responseBody = tempBlob;
                resp.statusCode = 401;
                return false;
            }  
        }catch(Exception e){
            Blob tempBlob = Blob.valueOf('Error out of Class StripeWebhookProcessor Method SignatureCheck:  ' + e.getMessage());
            resp.responseBody = tempBlob;
            resp.statusCode = 401;
            return false;
        }
    }

    public static String WebhookSort(String jsonstring){
        Map<String, Object> m = 
            (Map<String, Object>)
            JSON.deserializeUntyped(jsonstring);
        String eventType = ''+ m.get('type');
        String mystring;
        switch on eventType {
            when 'source.chargeable' {  
                mystring = sourcechargeable(m); 
            }
            when 'source.failed' {  
                sourcefailed(m); 
            }
            when 'source.mandate_notification' {  
                sourcemandate_notification(m); 
            }
            when 'source.refund_attributes_required' {  
                sourcerefund_attributes_required(m); 
            }
            when 'source.transaction.created' {  
                sourcetransactioncreated(m); 
            }
            when 'source.transaction.updated' {  
                sourcetransactionupdated(m); 
            }
            when 'tax_rate.created' {  
                tax_ratecreated(m); 
            }
            when 'tax_rate.updated' {  
                tax_rateupdated(m); 
            }
            when 'subscription_schedule.aborted' {  
                subscription_scheduleaborted(m); 
            }
            when 'subscription_schedule.ed' {  
                subscription_scheduleed(m); 
            }
            when 'subscription_schedule.completed' {  
                subscription_schedulecompleted(m); 
            }
            when 'subscription_schedule.created' {  
                subscription_schedulecreated(m); 
            }
            when 'subscription_schedule.expiring' {  
                subscription_scheduleexpiring(m); 
            }
            when 'subscription_schedule.released' {  
                subscription_schedulereleased(m); 
            }
            when 'subscription_schedule.updated' {  
                subscription_scheduleupdated(m); 
            }
            when 'topup.ed' {  
                topuped(m); 
            }
            when 'topup.created' {  
                topupcreated(m); 
            }
            when 'topup.failed' {  
                topupfailed(m); 
            }
            when 'topup.reversed' {  
                topupreversed(m); 
            }
            when 'topup.succeeded' {  
                topupsucceeded(m); 
            }
            when 'sigma.scheduled_query_run.created' {  
                sigmascheduled_query_runcreated(m); 
            }
            when 'review.closed' {  
                reviewclosed(m); 
            }
            when 'review.opened' {  
                reviewopened(m); 
            }
            when 'setup_intent.ed' {  
                setup_intented(m); 
            }
            when 'setup_intent.created' {  
                setup_intentcreated(m); 
            }
            when 'setup_intent.requires_action' {  
                setup_intentrequires_action(m); 
            }
            when 'setup_intent.setup_failed' {  
                setup_intentsetup_failed(m); 
            }
            when 'setup_intent.succeeded' {  
                setup_intentsucceeded(m); 
            }
            when 'recipient.created' {  
                recipientcreated(m); 
            }
            when 'recipient.deleted' {  
                recipientdeleted(m); 
            }
            when 'recipient.updated' {  
                recipientupdated(m); 
            }
            when 'radar.early_fraud_warning.created' {  
                radarearly_fraud_warningcreated(m); 
            }
            when 'radar.early_fraud_warning.updated' {  
                radarearly_fraud_warningupdated(m); 
            }
            when 'sku.created' {  
                skucreated(m); 
            }
            when 'sku.deleted' {  
                skudeleted(m); 
            }
            when 'sku.updated' {  
                skuupdated(m); 
            }
            when 'quote.accepted' {  
                quoteaccepted(m); 
            }
            when 'quote.ed' {  
                quoteed(m); 
            }
            when 'quote.created' {  
                quotecreated(m); 
            }
            when 'quote.finalized' {  
                quotefinalized(m); 
            }
            when 'promotion_code.created' {  
                promotion_codecreated(m); 
            }
            when 'promotion_code.updated' {  
                promotion_codeupdated(m); 
            }
            when 'product.created' {  
                productcreated(m); 
            }
            when 'product.deleted' {  
                productdeleted(m); 
            }
            when 'product.updated' {  
                productupdated(m); 
            }
            when 'price.created' {  
                pricecreated(m); 
            }
            when 'price.deleted' {  
                pricedeleted(m); 
            }
            when 'price.updated' {  
                priceupdated(m); 
            }
            when 'person.created' {  
                personcreated(m); 
            }
            when 'person.deleted' {  
                persondeleted(m); 
            }
            when 'person.updated' {  
                personupdated(m); 
            }
            when 'plan.created' {  
                plancreated(m); 
            }
            when 'plan.deleted' {  
                plandeleted(m); 
            }
            when 'plan.updated' {  
                planupdated(m); 
            }
            when 'payout.ed' {  
                payouted(m); 
            }
            when 'payout.created' {  
                payoutcreated(m); 
            }
            when 'payout.failed' {  
                payoutfailed(m); 
            }
            when 'payout.paid' {  
                payoutpaid(m); 
            }
            when 'payout.updated' {  
                payoutupdated(m); 
            }
            when 'payment_method.attached' {  
                payment_methodattached(m); 
            }
            when 'payment_method.automatically_updated' {  
                payment_methodautomatically_updated(m); 
            }
            when 'payment_method.detached' {  
                payment_methoddetached(m); 
            }
            when 'payment_method.updated' {  
                payment_methodupdated(m); 
            }
            when 'issuing_transaction.created' {  
                issuing_transactioncreated(m); 
            }
            when 'issuing_transaction.updated' {  
                issuing_transactionupdated(m); 
            }
            when 'order.created' {  
                ordercreated(m); 
            }
            when 'order.payment_failed' {  
                orderpayment_failed(m); 
            }
            when 'order.payment_succeeded' {  
                orderpayment_succeeded(m); 
            }
            when 'order.updated' {  
                orderupdated(m); 
            }
            when 'issuing_card.created' {  
                issuing_cardcreated(m); 
            }
            when 'issuing_card.updated' {  
                issuing_cardupdated(m); 
            }
            when 'issuing_cardholder.created' {  
                issuing_cardholdercreated(m); 
            }
            when 'issuing_cardholder.updated' {  
                issuing_cardholderupdated(m); 
            }
            when 'issuing_authorization.created' {  
                issuing_authorizationcreated(m); 
            }
            when 'issuing_authorization.request' {  
                issuing_authorizationrequest(m); 
            }
            when 'issuing_authorization.updated' {  
                issuing_authorizationupdated(m); 
            }
            when 'mandate.updated' {  
                mandateupdated(m); 
            }
            when 'order_return.created' {  
                order_returncreated(m); 
            }
            when 'reporting.report_run.failed' {  
                reportingreport_runfailed(m); 
            }
            when 'reporting.report_run.succeeded' {  
                reportingreport_runsucceeded(m); 
            }
            when 'reporting.report_type.updated' {  
                reportingreport_typeupdated(m); 
            }
            when 'transfer.created' {  
                transfercreated(m); 
            }
            when 'transfer.failed' {  
                transferfailed(m); 
            }
            when 'transfer.paid' {  
                transferpaid(m); 
            }
            when 'transfer.reversed' {  
                transferreversed(m); 
            }
            when 'transfer.updated' {  
                transferupdated(m); 
            }
            when 'issuing_dispute.closed' {  
                issuing_disputeclosed(m); 
            }
            when 'issuing_dispute.created' {  
                issuing_disputecreated(m); 
            }
            when 'issuing_dispute.funds_reinstated' {  
                issuing_disputefunds_reinstated(m); 
            }
            when 'issuing_dispute.submitted' {  
                issuing_disputesubmitted(m); 
            }
            when 'issuing_dispute.updated' {  
                issuing_disputeupdated(m); 
            }
            when 'payment_intent.amount_capturable_updated' {  
                payment_intentamount_capturable_updated(m); 
            }
            when 'payment_intent.ed' {  
                payment_intented(m); 
            }
            when 'payment_intent.created' {  
                payment_intentcreated(m); 
            }
            when 'payment_intent.payment_failed' {  
                payment_intentpayment_failed(m); 
            }
            when 'payment_intent.processing' {  
                payment_intentprocessing(m); 
            }
            when 'payment_intent.requires_action' {  
                payment_intentrequires_action(m); 
            }
            when 'payment_intent.succeeded' {  
                payment_intentsucceeded(m); 
            }
            when 'invoiceitem.created' {  
                invoiceitemcreated(m); 
            }
            when 'invoiceitem.deleted' {  
                invoiceitemdeleted(m); 
            }
            when 'invoiceitem.updated' {  
                invoiceitemupdated(m); 
            }
            when 'invoice.created' {  
                invoicecreated(m); 
            }
            when 'invoice.deleted' {  
                invoicedeleted(m); 
            }
            when 'invoice.finalization_failed' {  
                invoicefinalization_failed(m); 
            }
            when 'invoice.finalized' {  
                invoicefinalized(m); 
            }
            when 'invoice.marked_uncollectible' {  
                invoicemarked_uncollectible(m); 
            }
            when 'invoice.paid' {  
                invoicepaid(m); 
            }
            when 'invoice.payment_action_required' {  
                invoicepayment_action_required(m); 
            }
            when 'invoice.payment_failed' {  
                invoicepayment_failed(m); 
            }
            when 'invoice.payment_succeeded' {  
                invoicepayment_succeeded(m); 
            }
            when 'invoice.sent' {  
                invoicesent(m); 
            }
            when 'invoice.upcoming' {  
                invoiceupcoming(m); 
            }
            when 'invoice.updated' {  
                invoiceupdated(m); 
            }
            when 'invoice.voided' {  
                invoicevoided(m); 
            }
            when 'identity.verification_session.ed' {  
                identityverification_sessioned(m); 
            }
            when 'identity.verification_session.created' {  
                identityverification_sessioncreated(m); 
            }
            when 'identity.verification_session.processing' {  
                identityverification_sessionprocessing(m); 
            }
            when 'identity.verification_session.redacted' {  
                identityverification_sessionredacted(m); 
            }
            when 'identity.verification_session.requires_input' {  
                identityverification_sessionrequires_input(m); 
            }
            when 'identity.verification_session.verified' {  
                identityverification_sessionverified(m); 
            }
            when 'file.created' {  
                filecreated(m); 
            }
            when 'customer.created' {  
                customercreated(m); 
            }
            when 'customer.deleted' {  
                customerdeleted(m); 
            }
            when 'customer.updated' {  
                customerupdated(m); 
            }
            when 'customer.discount.created' {  
                customerdiscountcreated(m); 
            }
            when 'customer.discount.deleted' {  
                customerdiscountdeleted(m); 
            }
            when 'customer.discount.updated' {  
                customerdiscountupdated(m); 
            }
            when 'customer.source.created' {  
                customersourcecreated(m); 
            }
            when 'customer.source.deleted' {  
                customersourcedeleted(m); 
            }
            when 'customer.source.expiring' {  
                customersourceexpiring(m); 
            }
            when 'customer.source.updated' {  
                customersourceupdated(m); 
            }
            when 'customer.subscription.created' {  
                customersubscriptioncreated(m); 
            }
            when 'customer.subscription.deleted' {  
                customersubscriptiondeleted(m); 
            }
            when 'customer.subscription.pending_update_applied' {  
                customersubscriptionpending_update_applied(m); 
            }
            when 'customer.subscription.pending_update_expired' {  
                customersubscriptionpending_update_expired(m); 
            }
            when 'customer.subscription.trial_will_end' {  
                customersubscriptiontrial_will_end(m); 
            }
            when 'customer.subscription.updated' {  
                customersubscriptionupdated(m); 
            }
            when 'customer.tax_id.created' {  
                customertax_idcreated(m); 
            }
            when 'customer.tax_id.deleted' {  
                customertax_iddeleted(m); 
            }
            when 'customer.tax_id.updated' {  
                customertax_idupdated(m); 
            }
            when 'credit_note.created' {  
                credit_notecreated(m); 
            }
            when 'credit_note.updated' {  
                credit_noteupdated(m); 
            }
            when 'credit_note.voided' {  
                credit_notevoided(m); 
            }
            when 'coupon.created' {  
                couponcreated(m); 
            }
            when 'coupon.deleted' {  
                coupondeleted(m); 
            }
            when 'coupon.updated' {  
                couponupdated(m); 
            }
            when 'charge.captured' {  
                chargecaptured(m); 
            }
            when 'charge.expired' {  
                chargeexpired(m); 
            }
            when 'charge.failed' {  
                chargefailed(m); 
            }
            when 'charge.pending' {  
                chargepending(m); 
            }
            when 'charge.refunded' {  
                chargerefunded(m); 
            }
            when 'charge.succeeded' {  
                chargesucceeded(m); 
            }
            when 'charge.updated' {  
                chargeupdated(m); 
            }
            when 'charge.dispute.closed' {  
                chargedisputeclosed(m); 
            }
            when 'charge.dispute.created' {  
                chargedisputecreated(m); 
            }
            when 'charge.dispute.funds_reinstated' {  
                chargedisputefunds_reinstated(m); 
            }
            when 'charge.dispute.funds_withdrawn' {  
                chargedisputefunds_withdrawn(m); 
            }
            when 'charge.dispute.updated' {  
                chargedisputeupdated(m); 
            }
            when 'charge.refund.updated' {  
                chargerefundupdated(m); 
            }
            when 'capability.updated' {  
                capabilityupdated(m); 
            }
            when 'billing_portal.configuration.created' {  
                billing_portalconfigurationcreated(m); 
            }
            when 'billing_portal.configuration.updated' {  
                billing_portalconfigurationupdated(m); 
            }
            when 'balance.available' {  
                balanceavailable(m); 
            }
            when 'application_fee.created' {  
                application_feecreated(m); 
            }
            when 'application_fee.refunded' {  
                application_feerefunded(m); 
            }
            when 'application_fee.refund.updated' {  
                application_feerefundupdated(m); 
            }
            when 'account.updated' {  
                accountupdated(m); 
            }
            when 'account.application.authorized' {  
                accountapplicationauthorized(m); 
            }
            when 'account.application.deauthorized' {  
                accountapplicationdeauthorized(m); 
            }
            when 'account.external_account.created' {  
                accountexternal_accountcreated(m); 
            }
            when 'account.external_account.deleted' {  
                accountexternal_accountdeleted(m); 
            }
            when 'account.external_account.updated' {  
                accountexternal_accountupdated(m); 
            }
            when 'checkout.session.async_payment_failed' {  
                checkoutsessionasync_payment_failed(m); 
            }
            when 'checkout.session.async_payment_succeeded' {  
                checkoutsessionasync_payment_succeeded(m); 
            }
            when 'checkout.session.completed' {  
                checkoutsessioncompleted(m); 
            }
            when 'checkout.session.expired' {  
                mystring = checkoutsessionexpired(m); 
            }
        }
        return mystring;
    }
    
    public static String sourcechargeable(Map<String, Object> m){
        String mystring = 'test return string';
        return mystring;
    }
    public static void sourcefailed(Map<String, Object> m){
        //your code here 
    }
    public static void sourcemandate_notification(Map<String, Object> m){
        //your code here 
    }
    public static void sourcerefund_attributes_required(Map<String, Object> m){
        //your code here 
    }
    public static void sourcetransactioncreated(Map<String, Object> m){
        //your code here 
    }
    public static void sourcetransactionupdated(Map<String, Object> m){
        ///your code here 
    }
    public static void tax_ratecreated(Map<String, Object> m){
        //your code here 
    }
    public static void tax_rateupdated(Map<String, Object> m){
        //your code here 
    }
    public static void subscription_scheduleaborted(Map<String, Object> m){
        //your code here 
    }
    public static void subscription_scheduleed(Map<String, Object> m){
        //your code here 
    }
    public static void subscription_schedulecompleted(Map<String, Object> m){
        //your code here 
    }
    public static void subscription_schedulecreated(Map<String, Object> m){
        //your code here 
    }
    public static void subscription_scheduleexpiring(Map<String, Object> m){
        //your code here 
    }
    public static void subscription_schedulereleased(Map<String, Object> m){
        //your code here 
    }
    public static void subscription_scheduleupdated(Map<String, Object> m){
        //your code here 
    }
    public static void topuped(Map<String, Object> m){
        //your code here 
    }
    public static void topupcreated(Map<String, Object> m){
        //your code here 
    }
    public static void topupfailed(Map<String, Object> m){
        //your code here 
    }
    public static void topupreversed(Map<String, Object> m){
        //your code here 
    }
    public static void topupsucceeded(Map<String, Object> m){
        //your code here 
    }
    public static void sigmascheduled_query_runcreated(Map<String, Object> m){
        //your code here 
    }
    public static void reviewclosed(Map<String, Object> m){
        //your code here 
    }
    public static void reviewopened(Map<String, Object> m){
        //your code here 
    }
    public static void setup_intented(Map<String, Object> m){
        //your code here 
    }
    public static void setup_intentcreated(Map<String, Object> m){
        //your code here 
    }
    public static void setup_intentrequires_action(Map<String, Object> m){
        //your code here 
    }
    public static void setup_intentsetup_failed(Map<String, Object> m){
        //your code here 
    }
    public static void setup_intentsucceeded(Map<String, Object> m){
        //your code here 
    }
    public static void recipientcreated(Map<String, Object> m){
        //your code here 
    }
    public static void recipientdeleted(Map<String, Object> m){
        //your code here 
    }
    public static void recipientupdated(Map<String, Object> m){
        //your code here 
    }
    public static void radarearly_fraud_warningcreated(Map<String, Object> m){
        //your code here 
    }
    public static void radarearly_fraud_warningupdated(Map<String, Object> m){
        //your code here 
    }
    public static void skucreated(Map<String, Object> m){
        //your code here 
    }
    public static void skudeleted(Map<String, Object> m){
        //your code here 
    }
    public static void skuupdated(Map<String, Object> m){
        //your code here 
    }
    public static void quoteaccepted(Map<String, Object> m){
        //your code here 
    }
    public static void quoteed(Map<String, Object> m){
        //your code here 
    }
    public static void quotecreated(Map<String, Object> m){
        //your code here 
    }
    public static void quotefinalized(Map<String, Object> m){
        //your code here 
    }
    public static void promotion_codecreated(Map<String, Object> m){
        //your code here 
    }
    public static void promotion_codeupdated(Map<String, Object> m){
        //your code here 
    }
    public static void productcreated(Map<String, Object> m){
        //your code here 
    }
    public static void productdeleted(Map<String, Object> m){
        //your code here 
    }
    public static void productupdated(Map<String, Object> m){
        //your code here 
    }
    public static void pricecreated(Map<String, Object> m){
        //your code here 
    }
    public static void pricedeleted(Map<String, Object> m){
        //your code here 
    }
    public static void priceupdated(Map<String, Object> m){
        //your code here 
    }
    public static void personcreated(Map<String, Object> m){
        //your code here 
    }
    public static void persondeleted(Map<String, Object> m){
        //your code here 
    }
    public static void personupdated(Map<String, Object> m){
        //your code here 
    }
    public static void plancreated(Map<String, Object> m){
        //your code here 
    }
    public static void plandeleted(Map<String, Object> m){
        //your code here 
    }
    public static void planupdated(Map<String, Object> m){
        //your code here 
    }
    public static void payouted(Map<String, Object> m){
        //your code here 
    }
    public static void payoutcreated(Map<String, Object> m){
        //your code here 
    }
    public static void payoutfailed(Map<String, Object> m){
        //your code here 
    }
    public static void payoutpaid(Map<String, Object> m){
        //your code here 
    }
    public static void payoutupdated(Map<String, Object> m){
        //your code here 
    }
    public static void payment_methodattached(Map<String, Object> m){
        //your code here 
    }
    public static void payment_methodautomatically_updated(Map<String, Object> m){
        //your code here 
    }
    public static void payment_methoddetached(Map<String, Object> m){
        //your code here 
    }
    public static void payment_methodupdated(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_transactioncreated(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_transactionupdated(Map<String, Object> m){
        //your code here 
    }
    public static void ordercreated(Map<String, Object> m){
        //your code here 
    }
    public static void orderpayment_failed(Map<String, Object> m){
        //your code here 
    }
    public static void orderpayment_succeeded(Map<String, Object> m){
        //your code here 
    }
    public static void orderupdated(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_cardcreated(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_cardupdated(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_cardholdercreated(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_cardholderupdated(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_authorizationcreated(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_authorizationrequest(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_authorizationupdated(Map<String, Object> m){
        //your code here 
    }
    public static void mandateupdated(Map<String, Object> m){
        //your code here 
    }
    public static void order_returncreated(Map<String, Object> m){
        //your code here 
    }
    public static void reportingreport_runfailed(Map<String, Object> m){
        //your code here 
    }
    public static void reportingreport_runsucceeded(Map<String, Object> m){
        //your code here 
    }
    public static void reportingreport_typeupdated(Map<String, Object> m){
        //your code here 
    }
    public static void transfercreated(Map<String, Object> m){
        //your code here 
    }
    public static void transferfailed(Map<String, Object> m){
        //your code here 
    }
    public static void transferpaid(Map<String, Object> m){
        //your code here 
    }
    public static void transferreversed(Map<String, Object> m){
        //your code here 
    }
    public static void transferupdated(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_disputeclosed(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_disputecreated(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_disputefunds_reinstated(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_disputesubmitted(Map<String, Object> m){
        //your code here 
    }
    public static void issuing_disputeupdated(Map<String, Object> m){
        //your code here 
    }
    public static void payment_intentamount_capturable_updated(Map<String, Object> m){
        //your code here 
    }
    public static void payment_intented(Map<String, Object> m){
        //your code here 
    }
    public static void payment_intentcreated(Map<String, Object> m){
        //your code here 
    }
    public static void payment_intentpayment_failed(Map<String, Object> m){
        //your code here 
    }
    public static void payment_intentprocessing(Map<String, Object> m){
        //your code here 
    }
    public static void payment_intentrequires_action(Map<String, Object> m){
        //your code here 
    }
    public static void payment_intentsucceeded(Map<String, Object> m){
        //your code here 
    }
    public static void invoiceitemcreated(Map<String, Object> m){
        //your code here 
    }
    public static void invoiceitemdeleted(Map<String, Object> m){
        //your code here 
    }
    public static void invoiceitemupdated(Map<String, Object> m){
        //your code here 
    }
    public static void invoicecreated(Map<String, Object> m){
        //your code here 
    }
    public static void invoicedeleted(Map<String, Object> m){
        //your code here 
    }
    public static void invoicefinalization_failed(Map<String, Object> m){
        //your code here 
    }
    public static void invoicefinalized(Map<String, Object> m){
        //your code here 
    }
    public static void invoicemarked_uncollectible(Map<String, Object> m){
        //your code here 
    }
    public static void invoicepaid(Map<String, Object> m){
        //your code here 
    }
    public static void invoicepayment_action_required(Map<String, Object> m){
        //your code here 
    }
    public static void invoicepayment_failed(Map<String, Object> m){
        //your code here 
    }
    public static void invoicepayment_succeeded(Map<String, Object> m){
        //your code here 
    }
    public static void invoicesent(Map<String, Object> m){
        //your code here 
    }
    public static void invoiceupcoming(Map<String, Object> m){
        //your code here 
    }
    public static void invoiceupdated(Map<String, Object> m){
        //your code here 
    }
    public static void invoicevoided(Map<String, Object> m){
        //your code here 
    }
    public static void identityverification_sessioned(Map<String, Object> m){
        //your code here 
    }
    public static void identityverification_sessioncreated(Map<String, Object> m){
        //your code here 
    }
    public static void identityverification_sessionprocessing(Map<String, Object> m){
        //your code here 
    }
    public static void identityverification_sessionredacted(Map<String, Object> m){
        //your code here 
    }
    public static void identityverification_sessionrequires_input(Map<String, Object> m){
        //your code here 
    }
    public static void identityverification_sessionverified(Map<String, Object> m){
        //your code here 
    }
    public static void filecreated(Map<String, Object> m){
        //your code here 
    }
    public static void customercreated(Map<String, Object> m){
        //your code here 
    }
    public static void customerdeleted(Map<String, Object> m){
        //your code here 
    }
    public static void customerupdated(Map<String, Object> m){
        //your code here 
    }
    public static void customerdiscountcreated(Map<String, Object> m){
        //your code here 
    }
    public static void customerdiscountdeleted(Map<String, Object> m){
        //your code here 
    }
    public static void customerdiscountupdated(Map<String, Object> m){
        //your code here 
    }
    public static void customersourcecreated(Map<String, Object> m){
        //your code here 
    }
    public static void customersourcedeleted(Map<String, Object> m){
        //your code here 
    }
    public static void customersourceexpiring(Map<String, Object> m){
        //your code here 
    }
    public static void customersourceupdated(Map<String, Object> m){
        //your code here 
    }
    public static void customersubscriptioncreated(Map<String, Object> m){
        //your code here 
    }
    public static void customersubscriptiondeleted(Map<String, Object> m){
        //your code here 
    }
    public static void customersubscriptionpending_update_applied(Map<String, Object> m){
        //your code here 
    }
    public static void customersubscriptionpending_update_expired(Map<String, Object> m){
        //your code here 
    }
    public static void customersubscriptiontrial_will_end(Map<String, Object> m){
        //your code here 
    }
    public static void customersubscriptionupdated(Map<String, Object> m){
        //your code here 
    }
    public static void customertax_idcreated(Map<String, Object> m){
        //your code here 
    }
    public static void customertax_iddeleted(Map<String, Object> m){
        //your code here 
    }
    public static void customertax_idupdated(Map<String, Object> m){
        //your code here 
    }
    public static void credit_notecreated(Map<String, Object> m){
        //your code here 
    }
    public static void credit_noteupdated(Map<String, Object> m){
        //your code here 
    }
    public static void credit_notevoided(Map<String, Object> m){
        //your code here 
    }
    public static void couponcreated(Map<String, Object> m){
        //your code here 
    }
    public static void coupondeleted(Map<String, Object> m){
        //your code here 
    }
    public static void couponupdated(Map<String, Object> m){
        //your code here 
    }
    public static void chargecaptured(Map<String, Object> m){
        //your code here 
    }
    public static void chargeexpired(Map<String, Object> m){
        //your code here 
    }
    public static void chargefailed(Map<String, Object> m){
        //your code here 
    }
    public static void chargepending(Map<String, Object> m){
        //your code here 
    }
    public static void chargerefunded(Map<String, Object> m){
        //your code here 
    }
    public static void chargesucceeded(Map<String, Object> m){
        //your code here 
    }
    public static void chargeupdated(Map<String, Object> m){
        //your code here 
    }
    public static void chargedisputeclosed(Map<String, Object> m){
        //your code here 
    }
    public static void chargedisputecreated(Map<String, Object> m){
        //your code here 
    }
    public static void chargedisputefunds_reinstated(Map<String, Object> m){
        //your code here 
    }
    public static void chargedisputefunds_withdrawn(Map<String, Object> m){
        //your code here 
    }
    public static void chargedisputeupdated(Map<String, Object> m){
        //your code here 
    }
    public static void chargerefundupdated(Map<String, Object> m){
        //your code here 
    }
    public static void capabilityupdated(Map<String, Object> m){
        //your code here 
    }
    public static void billing_portalconfigurationcreated(Map<String, Object> m){
        //your code here 
    }
    public static void billing_portalconfigurationupdated(Map<String, Object> m){
        //your code here 
    }
    public static void balanceavailable(Map<String, Object> m){
        //your code here 
    }
    public static void application_feecreated(Map<String, Object> m){
        //your code here 
    }
    public static void application_feerefunded(Map<String, Object> m){
        //your code here 
    }
    public static void application_feerefundupdated(Map<String, Object> m){
        //your code here 
    }
    public static void accountupdated(Map<String, Object> m){
        //your code here 
    }
    public static void accountapplicationauthorized(Map<String, Object> m){
        //your code here 
    }
    public static void accountapplicationdeauthorized(Map<String, Object> m){
        //your code here 
    }
    public static void accountexternal_accountcreated(Map<String, Object> m){
        //your code here 
    }
    public static void accountexternal_accountdeleted(Map<String, Object> m){
        //your code here 
    }
    public static void accountexternal_accountupdated(Map<String, Object> m){
        //your code here 
    }
    public static void checkoutsessionasync_payment_failed(Map<String, Object> m){
        //your code here 
    }
    public static void checkoutsessionasync_payment_succeeded(Map<String, Object> m){
        //your code here 
    }
    public static void checkoutsessioncompleted(Map<String, Object> m){
        //your code here 
    }
    public static String checkoutsessionexpired(Map<String, Object> m){
        //your code here
        String mystring = 'test return string';
        return mystring;
    }
}