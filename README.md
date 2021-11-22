# SalesForce-StripeHandler



## Installing


**1. Deploy the StripeHandler project to salesforce**

**2. Create a Named Credential**

  a. Navigate to  `https://<your_instance_name>.lightning.force.com/lightning/setup/NamedCredential/home`

  b.   Then Click `New Named Credential`
  
   **Values for Named Credential**  
  
  Label: `Stripe_Secret_API_Key`

  Name: `Stripe_Secret_API_Key`

  Identity Type: `Named Principle`

  Authentication Protocol: `Password Authentication`

  UserName: `<Your Secret Key from stripe> e.g sk_testsldigjssdlgijsdgli`

  Password: `Single space, this will set the password to emtpy and this is what we want`

![NamedCred](Screenshots/NamedCredentials.gif)

**3. Configure Webhooks**
Navigate to:
`https://<Your_instance_name>lightning.force.com/lightning/setup/CustomDomain/home`

Create a new Site

Fill out the Site form

Make sure to check the active box

Click `Save`

Click on `public access seetings`

Click `enable apex class Access`

Add the `StripeWebhookHandler`

Click `Save`

Navigate back to Sites and copy the URL for this site

Open the stripe dashboard dashboard.stripe.com

Click on `developers`

Click the `webhooks` on the navigation bar

Click `add an endpoint`

For the endpoint url paste in the url for the site you just created

Then append `/services/apexrest/Stripe/Webhook/Processor/` to the end of the url. 

This will direct posts from the webhook to the webhook handler. 

Add in the events you want this webhook to process. The handler can handle all stripe events as of November 5th 2021. 

Once events have been added click `add endpoint`. 

From the webhook in stripe click `Reveal` under the Signing Secret

Copy the Signing Secret value

From Visual Studios open the project and navigate to force-app/main/default -> classes -> StripeWebhookHandler.cls

Paste the Signing Secret in as a string value into the `WebhookKey` variable

Save the file 

Deploy the file to the Org

Navigate back to the Stripe Webhook we created and send a test webhook

If the return was a 200 status code with a response of ‘webhook was processed’ the configuration was successful and we can now process events from Stripe to Salesforce

![image](Screenshots/StripeWebhookConfig.gif))


## Usage Examples

Deploy any of the [examples](https://github.com/millin-stripe/SalesForce-StripeHandler/tree/main/Examples) under the Example folder to see different integrations and usecases. 

How to use the Stripe API handler. 
https://youtu.be/5bXWbYZXi9A 

