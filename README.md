# SalesForce-StripeHandler


### Sections
[Challenge Overview](/README.md)

[Section 1: Sell concert tickets](/README-pt1-concerttickets.md)

[Section 2: Sell video courses](README-pt2-videopurchase.md)

[Section 3: Lesson signup](README-pt3-lessonsignup.md)

[Section 4: Lesson payment capture](README-pt4-paymentcapture.md)

[Section 5: Lesson account management](README-pt5-accountmanagement.md)

[Section 6: Lesson Reporting](README-pt6-reporting.md)

# Getting started
To goal of this coding challenge is to complete the app started in this repo, a website for a music store.  To get started: 

* Read this doc to get an overview of how the challenge is set up. 
* Complete all sections of the challenge. When you've finished, deploy your solution and push it back to this repo.


**Getting Help**

If you need any help please reach out to verification@stripe.com 

# Challenge Overview

Looking to grow their business a US-based music school wants to expand their online presence to include selling instructional videos, concert tickets and by offering online lessons. 

# Using the provided starter code

Within the code directory you'll find the [starter code](code/) for client and server you selected to complete the challenge.

The README for each section of the challenge provides more information about the starter code specific for that section. 

We hope the starter code is helpful to you, but feel free to use a different framework if that's easier for you.  Please let us know in the feedback doc why you decided to not use the starter code and how we could make it better.

## Running locally

As a first step in completing the challenge we recommend you get your local server up and running:

**1. First checkout the repo and configure the environment variables:**

Inside `./code/server` you will find an example for your **.env** file. Make a copy of `.env.example` at the same level and rename it to `.env`.

For example:

```
cp .env.example .env
```

Replace the placehold variables in the .env file wtih your keys: 

```
STRIPE_PUBLISHABLE_KEY=<replace-with-your-publishable-key>
STRIPE_SECRET_KEY=<replace-with-your-secret-key>
STRIPE_WEBHOOK_SECRET=<replace-with-your-webhook-secret>
```

We've also provided a config file, `config.json` which contains some constants used by the video and concert tickets sections of the app.  See the server file for examples of how to load these values. 

**For Vanilla stack client**

`STATIC_DIR` tells the server where to the static files are located and does not need to be modified unless you restructure the directories.

**2. Follow the server instructions on how to run:**

Please follow the instructions in the README you'll find in the code/server folder on how to run your server.

With your server running the page should look like this:

**Note**: if you are working with the react client, after you start you server, please follow  the instructions in the README you'll find in the code/client folder on how to start the react client.

![Overview](screenshots/MusicShopOverview.gif)

**3. [Optional] Run a webhook locally:**

We recommend using the Stripe CLI to easily spin up a local webhook.

First [install the CLI](https://stripe.com/docs/stripe-cli) and [link your Stripe account](https://stripe.com/docs/stripe-cli#link-account).

```
stripe listen --forward-to localhost:4242/webhook
```

The CLI will print a webhook secret key to the console. Set `STRIPE_WEBHOOK_SECRET` to this value in your .env file.

You should see events logged in the console where the CLI is running.


## Your Stripe Account

We'll run test mode transaction on your Stripe account to test your solution. If this activity might disrupt your other work you may want to spin up a separate Stripe account just for these challenges.  We recommend you keep the account you use for challenges up to date with the latest API version. 


## Submitting your challenge

When you are done there are 3 steps to submitting your solution:

* Open a pr with the changes you want to merge into master
* let us know you’ve completed the exam by filling in the template provided. You can either do one push or one per challenge completed. We advise you to create a separate branch in which you can work your solution before merging it into master.
* Merge your changes to master.
* To ensure your challenge can be evaluated, we advise you to run the test scripts in `./test`.

**Note**: Please make sure all your features run in the latest version of Google Chrome.

**Navigation**
[Continue to Section 1: Sell Concert Tickets](/README-pt1-concerttickets.md)
